#!/bin/bash
# Quick installation script for AOSP grep commands
# Usage: ./quick_install.sh [install_location]
# Default install location: /usr/local/bin (requires sudo)
# Alternative: ./quick_install.sh ~/.local/bin (no sudo needed)

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default installation directory
INSTALL_DIR="${1:-/usr/local/bin}"

echo -e "${YELLOW}AOSP Grep Commands Installation${NC}"
echo "=================================="
echo "Installation directory: $INSTALL_DIR"
echo ""

# Check if we need sudo
if [[ "$INSTALL_DIR" == "/usr/local/bin" ]] || [[ "$INSTALL_DIR" == "/usr/bin" ]]; then
    if ! sudo -n true 2>/dev/null; then
        echo -e "${YELLOW}This installation requires sudo privileges.${NC}"
        echo "Please enter your password when prompted:"
    fi
    SUDO="sudo"
else
    SUDO=""
    # Create directory if it doesn't exist
    mkdir -p "$INSTALL_DIR"
fi

# Create temporary directory for scripts
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

echo -e "${YELLOW}Creating scripts...${NC}"

# Create cgrep
cat > "$TEMP_DIR/cgrep" << 'EOF'
#!/bin/bash
find . -type f \( -name "*.c" -o -name "*.cpp" -o -name "*.cc" -o -name "*.cxx" -o -name "*.h" -o -name "*.hpp" -o -name "*.hh" \) -print0 | xargs -0 grep --color -n "$@"
EOF

# Create jgrep
cat > "$TEMP_DIR/jgrep" << 'EOF'
#!/bin/bash
find . -type f -name "*.java" -print0 | xargs -0 grep --color -n "$@"
EOF

# Create resgrep
cat > "$TEMP_DIR/resgrep" << 'EOF'
#!/bin/bash
for dir in $(find . -name res -type d); do 
    find "$dir" -type f -name '*.xml' -print0 | xargs -0 grep --color -n "$@"
done
EOF

# Create mgrep
cat > "$TEMP_DIR/mgrep" << 'EOF'
#!/bin/bash
find . -type f \( -name "Makefile" -o -name "Makefile.*" -o -name "*.make" -o -name "*.mak" -o -name "*.mk" \) -print0 | xargs -0 grep --color -n "$@"
EOF

# Create treegrep
cat > "$TEMP_DIR/treegrep" << 'EOF'
#!/bin/bash
find . -type f \( -name "*.c" -o -name "*.h" -o -name "*.cpp" -o -name "*.hpp" -o -name "*.S" -o -name "*.java" -o -name "*.xml" \) -print0 | xargs -0 grep --color -n -i "$@"
EOF

# Make scripts executable
chmod +x "$TEMP_DIR"/{cgrep,jgrep,resgrep,mgrep,treegrep}

echo -e "${YELLOW}Installing scripts to $INSTALL_DIR...${NC}"

# Copy scripts to installation directory
$SUDO cp "$TEMP_DIR/cgrep" "$INSTALL_DIR/"
$SUDO cp "$TEMP_DIR/jgrep" "$INSTALL_DIR/"
$SUDO cp "$TEMP_DIR/resgrep" "$INSTALL_DIR/"
$SUDO cp "$TEMP_DIR/mgrep" "$INSTALL_DIR/"
$SUDO cp "$TEMP_DIR/treegrep" "$INSTALL_DIR/"

# Verify installation
echo -e "${YELLOW}Verifying installation...${NC}"

if command -v cgrep &> /dev/null; then
    echo -e "${GREEN}✓ Installation successful!${NC}"
    echo ""
    echo "Installed commands:"
    echo "  - cgrep      : Search in C/C++ files"
    echo "  - jgrep      : Search in Java files"
    echo "  - resgrep    : Search in resource XML files"
    echo "  - mgrep      : Search in Makefile and build files"
    echo "  - treegrep   : Search in all common source types"
    echo ""
    echo "Usage examples:"
    echo "  cgrep \"my_function\""
    echo "  jgrep \"MyClass\""
    echo "  resgrep \"android:id\""
else
    echo -e "${RED}✗ Installation may have failed.${NC}"
    echo "Please check if $INSTALL_DIR is in your PATH:"
    echo "  echo \$PATH"
    echo ""
    echo "If not, add it to your ~/.bashrc or ~/.zshrc:"
    echo "  export PATH=\"\$PATH:$INSTALL_DIR\""
    exit 1
fi
