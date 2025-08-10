# Multi-stage build for NMOX Server
FROM ubuntu:22.04 AS base

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    build-essential \
    libssl-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Rust for WASM compilation
FROM base AS rust-builder
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup target add wasm32-unknown-unknown
RUN cargo install wasm-pack

# Install Node.js for tooling
FROM base AS node-builder
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y nodejs

# Squeak Smalltalk stage
FROM base AS squeak
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libpulse0 \
    libasound2 \
    libcairo2 \
    libpango-1.0-0 \
    libssl3 \
    && rm -rf /var/lib/apt/lists/*

# Download and install Squeak VM
RUN wget -q https://files.squeak.org/6.0/Squeak6.0-22148-64bit/Squeak6.0-22148-64bit-Linux-x64.tar.gz \
    && tar -xzf Squeak6.0-22148-64bit-Linux-x64.tar.gz -C /opt \
    && rm Squeak6.0-22148-64bit-Linux-x64.tar.gz \
    && mv /opt/Squeak6.0-22148-64bit-Linux-x64 /opt/squeak

# Final stage
FROM squeak AS runtime

# Copy Rust toolchain from builder
COPY --from=rust-builder /root/.cargo /root/.cargo
COPY --from=rust-builder /root/.rustup /root/.rustup
ENV PATH="/root/.cargo/bin:${PATH}"

# Copy Node.js from builder
COPY --from=node-builder /usr/bin/node /usr/bin/node
COPY --from=node-builder /usr/bin/npm /usr/bin/npm
COPY --from=node-builder /usr/lib/node_modules /usr/lib/node_modules

# Create NMOX directory structure
RUN mkdir -p /opt/nmox/{bin,lib,etc,srv,var,tmp}

# Set working directory
WORKDIR /opt/nmox

# Copy application files
COPY ./bin /opt/nmox/bin
COPY ./x/lib /opt/nmox/lib
COPY ./x/etc /opt/nmox/etc
COPY ./x/srv /opt/nmox/srv

# Make scripts executable
RUN chmod +x /opt/nmox/bin/*

# Create non-root user
RUN useradd -m -s /bin/bash nmox && \
    chown -R nmox:nmox /opt/nmox

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8080/health || exit 1

# Switch to non-root user
USER nmox

# Expose ports
EXPOSE 8080 9009

# Default command
CMD ["/opt/nmox/bin/nmox-kernel", "start"]