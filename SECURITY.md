# Security Policy

## NMOX Server Security

NMOX Server takes security seriously. We appreciate the community's efforts to responsibly discover and disclose security issues.

## Supported Versions

| Version | Supported          |
|---------|-------------------|
| 3.x.x   | :white_check_mark: |
| 2.x.x   | :x:               |
| 1.x.x   | :x:               |

## Reporting a Vulnerability

### Quick Links
- Security Issues: security@nmox.org
- PGP Key: [https://keys.nmox.org/security.asc](https://keys.nmox.org/security.asc)
- Bug Bounty Program: [https://bounty.nmox.org](https://bounty.nmox.org)

### Reporting Process

1. **Initial Report**
   - Email security@nmox.org
   - Include "SECURITY" in the subject line
   - Encrypt sensitive details using our PGP key
   - Provide clear steps to reproduce

2. **Response Timeline**
   - Initial response: Within 24 hours
   - Issue triage: Within 72 hours
   - Regular updates: Every 5 business days
   - Public disclosure: After fix is deployed

3. **Required Information**
   - Affected component(s)
   - Version number(s)
   - Step-by-step reproduction
   - Impact assessment
   - Possible mitigations

## Security Considerations

### Cross-Language Security

NMOX's multi-language nature requires special security considerations:

1. **X Object Validation**
   - Validate data at language boundaries
   - Use type-safe conversions
   - Implement sanitization checks

2. **Inter-Process Communication**
   - Use secure IPC mechanisms
   - Implement message authentication
   - Validate data formats

3. **Docker Security**
   - Regular base image updates
   - Minimal container permissions
   - Read-only filesystem where possible

### Web Security

Core web security practices:

1. **Input Validation**
   - Validate all input parameters
   - Use parameterized queries
   - Implement content security policies

2. **Authentication**
   - OAuth 2.0 implementation
   - Multi-factor authentication support
   - Session management best practices

3. **Authorization**
   - Role-based access control
   - Resource-level permissions
   - Audit logging

### Development Practices

1. **Code Security**
   ```sh
   # Run security audit
   make security-check
   
   # Analyze dependencies
   make deps-audit
   
   # Check for known vulnerabilities
   make vuln-scan
   ```

2. **Dependency Management**
   - Regular dependency updates
   - Automated vulnerability scanning
   - Lock file verification

3. **Deployment Security**
   - Secure configuration management
   - Environment separation
   - Secret management

## Security Tooling

### Required Tools

- SAST (Static Application Security Testing)
- Dependency scanners
- Container security scanning
- Network security monitoring

### Recommended Tools

1. **Rust Security**
   ```sh
   cargo audit
   cargo deny check advisories
   ```

2. **JavaScript Security**
   ```sh
   npm audit
   yarn audit
   ```

3. **Container Security**
   ```sh
   docker scan
   trivy image nmox-server
   ```

## Common Vulnerabilities Prevention

1. **Cross-Site Scripting (XSS)**
   - Implement Content Security Policy
   - Use context-aware encoding
   - Validate and sanitize input

2. **SQL Injection**
   - Use parameterized queries
   - Implement proper escaping
   - Validate input types

3. **Cross-Site Request Forgery (CSRF)**
   - Implement CSRF tokens
   - Validate origin headers
   - Use SameSite cookies

## Security Best Practices

### Data Handling

1. **Storage**
   - Encrypt sensitive data at rest
   - Use secure key management
   - Implement data access logging

2. **Transmission**
   - Use TLS 1.3
   - Implement certificate pinning
   - Validate SSL/TLS configurations

3. **Processing**
   - Sanitize all inputs
   - Validate data types
   - Implement rate limiting

### System Security

1. **File System**
   - Follow principle of least privilege
   - Implement proper permissions
   - Use secure temporary files

2. **Network**
   - Implement firewall rules
   - Use secure protocols
   - Monitor network traffic

3. **Process**
   - Sandbox untrusted code
   - Implement resource limits
   - Monitor process behavior

## Incident Response

### Response Process

1. **Detection**
   - Monitor security alerts
   - Analyze system logs
   - Review access patterns

2. **Containment**
   - Isolate affected systems
   - Block malicious activity
   - Preserve evidence

3. **Remediation**
   - Fix vulnerabilities
   - Update affected systems
   - Implement preventive measures

### Disclosure Policy

1. **Timeline**
   - 90-day disclosure deadline
   - Coordinated disclosure process
   - Regular status updates

2. **Communication**
   - Clear impact assessment
   - Mitigation steps
   - User notifications

## Compliance

- GDPR compliance for EU users
- CCPA compliance for California users
- SOC 2 Type II certification (in progress)

## Recognition

We maintain a security hall of fame at [https://nmox.org/security/hall-of-fame](https://nmox.org/security/hall-of-fame) to acknowledge security researchers who have helped improve NMOX Server's security. (Coming soon..)

## Updates

This security policy is reviewed and updated quarterly. Last update: Q2 2024

---

For questions about this security policy, contact security@nmox.org.
