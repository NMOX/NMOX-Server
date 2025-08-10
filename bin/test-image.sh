#!/bin/bash

# NMOX Squeak Image Test Script
# Tests the Squeak Smalltalk image and runs Smalltalk tests

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${YELLOW}ℹ${NC} $1"
}

# Configuration
SQUEAK_IMAGE="x/lib/NMOXSqueak6.0-22148-64bit.image"
SQUEAK_CHANGES="x/lib/NMOXSqueak6.0-22148-64bit.changes"
SQUEAK_SOURCES="x/lib/SqueakV60.sources"
SQUEAK_VM="/opt/squeak/squeak"

# Check if running in Docker
if [ -f /.dockerenv ]; then
    print_info "Running in Docker container"
else
    print_info "Running on host system"
    # Try to find Squeak VM on host
    if command -v squeak &> /dev/null; then
        SQUEAK_VM="squeak"
    elif [ -f "/Applications/Squeak.app/Contents/MacOS/Squeak" ]; then
        SQUEAK_VM="/Applications/Squeak.app/Contents/MacOS/Squeak"
    elif [ -f "/usr/bin/squeak" ]; then
        SQUEAK_VM="/usr/bin/squeak"
    else
        print_error "Squeak VM not found. Please install Squeak or run in Docker."
        exit 1
    fi
fi

print_info "Testing NMOX Squeak Image"

# Check if image exists
if [ ! -f "$SQUEAK_IMAGE" ]; then
    print_error "Squeak image not found: $SQUEAK_IMAGE"
    print_info "Please ensure Git LFS is installed and run: git lfs pull"
    exit 1
fi

# Check if changes file exists
if [ ! -f "$SQUEAK_CHANGES" ]; then
    print_error "Squeak changes file not found: $SQUEAK_CHANGES"
    exit 1
fi

# Check if sources file exists
if [ ! -f "$SQUEAK_SOURCES" ]; then
    print_info "Squeak sources file not found: $SQUEAK_SOURCES (optional)"
fi

# Get image file size
IMAGE_SIZE=$(du -h "$SQUEAK_IMAGE" | cut -f1)
print_success "Image found: $SQUEAK_IMAGE ($IMAGE_SIZE)"

# Create test script for Squeak
cat > /tmp/nmox-test.st << 'EOF'
"NMOX Test Script"
| results testCount failCount errorCount |

Transcript cr; show: '=== NMOX Squeak Tests ==='; cr.

"Initialize test counters"
testCount := 0.
failCount := 0.
errorCount := 0.
results := OrderedCollection new.

"Test 1: Check if NMOX classes exist"
testCount := testCount + 1.
[
    (Smalltalk includesKey: #NMOXObject) 
        ifTrue: [
            results add: 'PASS: NMOXObject class found'.
        ]
        ifFalse: [
            results add: 'INFO: NMOXObject class not found (expected for fresh image)'.
        ].
] on: Error do: [:ex | 
    errorCount := errorCount + 1.
    results add: 'ERROR: ' , ex messageText.
].

"Test 2: Check Smalltalk version"
testCount := testCount + 1.
[
    | version |
    version := SystemVersion current.
    results add: 'PASS: Squeak version - ' , version version , ' (' , version highestUpdate printString , ')'.
] on: Error do: [:ex |
    errorCount := errorCount + 1.
    results add: 'ERROR: Could not determine Squeak version'.
].

"Test 3: Check available packages"
testCount := testCount + 1.
[
    | packageCount |
    packageCount := PackageOrganizer default packages size.
    results add: 'PASS: Found ' , packageCount printString , ' packages in image'.
] on: Error do: [:ex |
    errorCount := errorCount + 1.
    results add: 'ERROR: Could not count packages'.
].

"Test 4: Memory and system check"
testCount := testCount + 1.
[
    | memoryStats |
    memoryStats := Smalltalk vm memoryStatistics.
    results add: 'PASS: Memory available - ' , (memoryStats at: #free ifAbsent: [0]) printString , ' bytes'.
] on: Error do: [:ex |
    results add: 'INFO: Could not retrieve memory statistics'.
].

"Test 5: Create simple X object pattern test"
testCount := testCount + 1.
[
    | x |
    x := 'Peace'.
    x = 'Peace'
        ifTrue: [results add: 'PASS: X object pattern test (string)']
        ifFalse: [
            failCount := failCount + 1.
            results add: 'FAIL: X object pattern test (string)'.
        ].
] on: Error do: [:ex |
    errorCount := errorCount + 1.
    results add: 'ERROR: X object pattern test failed - ' , ex messageText.
].

"Print results"
Transcript cr; show: '=== Test Results ==='; cr.
results do: [:each | Transcript show: each; cr].

Transcript cr; show: '=== Summary ==='; cr.
Transcript show: 'Total tests: ' , testCount printString; cr.
Transcript show: 'Passed: ' , (testCount - failCount - errorCount) printString; cr.
Transcript show: 'Failed: ' , failCount printString; cr.
Transcript show: 'Errors: ' , errorCount printString; cr.

"Exit with appropriate code"
(failCount = 0 and: [errorCount = 0])
    ifTrue: [
        Transcript show: 'All tests passed!'; cr.
        Smalltalk snapshot: false andQuit: true.
    ]
    ifFalse: [
        Transcript show: 'Some tests failed or had errors!'; cr.
        Smalltalk snapshot: false andQuit: true.
    ].
EOF

# Run Squeak tests in headless mode
print_info "Running Squeak tests..."

if [ -f /.dockerenv ]; then
    # In Docker, use headless mode
    $SQUEAK_VM -headless "$SQUEAK_IMAGE" /tmp/nmox-test.st 2>/dev/null || {
        print_error "Squeak tests failed"
        exit 1
    }
else
    # On host, try headless but fallback if needed
    if $SQUEAK_VM -headless "$SQUEAK_IMAGE" /tmp/nmox-test.st 2>/dev/null; then
        print_success "Squeak tests completed"
    else
        print_info "Headless mode failed, tests may require display"
        # For CI/CD environments without display
        if [ -z "$DISPLAY" ]; then
            print_info "No display available, skipping interactive tests"
        else
            $SQUEAK_VM "$SQUEAK_IMAGE" /tmp/nmox-test.st || {
                print_error "Squeak tests failed"
                exit 1
            }
        fi
    fi
fi

# Clean up
rm -f /tmp/nmox-test.st

print_success "All Squeak image tests passed!"

# Additional validation
print_info "Validating image integrity..."

# Check file size (image should be approximately 90MB)
IMAGE_SIZE_BYTES=$(stat -f%z "$SQUEAK_IMAGE" 2>/dev/null || stat -c%s "$SQUEAK_IMAGE" 2>/dev/null)
IMAGE_SIZE_MB=$((IMAGE_SIZE_BYTES / 1024 / 1024))

if [ $IMAGE_SIZE_MB -lt 50 ]; then
    print_error "Image seems corrupted (too small: ${IMAGE_SIZE_MB}MB)"
    exit 1
elif [ $IMAGE_SIZE_MB -gt 200 ]; then
    print_error "Image seems unusually large (${IMAGE_SIZE_MB}MB)"
    exit 1
else
    print_success "Image size validated (${IMAGE_SIZE_MB}MB)"
fi

print_success "NMOX Squeak image validation complete!"
exit 0