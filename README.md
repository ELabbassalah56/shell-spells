# AOSP Grep Tools - Complete Package

A complete set of AOSP-style grep commands for efficient code searching in your projects. These commands replicate the functionality of the Android Open Source Project's specialized grep tools.

## 📦 Package Contents

```
aosp-grep-tools/
├── README.md                 # This file
├── quick_install.sh          # Automated installation script
├── bin/                      # Executable scripts
│   ├── cgrep                 # C/C++ file search
│   ├── jgrep                 # Java file search
│   ├── resgrep               # Resource XML search
│   ├── mgrep                 # Makefile search
│   └── treegrep              # All source types search
├── docs/                     # Documentation
│   ├── README_SETUP.md       # Quick setup guide
│   ├── INSTALLATION_GUIDE.md # Detailed installation methods
│   └── aosp_grep_guide.md    # Command reference
└── examples/                 # Usage examples
    └── EXAMPLES.md           # Real-world usage scenarios
```

## 🚀 Quick Start

### Option 1: Automated Installation (Recommended)

```bash
# Extract the package
unzip aosp-grep-tools.zip
cd aosp-grep-tools

# Run the installation script
./quick_install.sh ~/.local/bin
```

That's it! The commands are now available in your terminal.

### Option 2: Manual Installation

```bash
# Copy scripts to your bin directory
cp bin/* ~/.local/bin/

# Make them executable
chmod +x ~/.local/bin/{cgrep,jgrep,resgrep,mgrep,treegrep}

# Add to PATH (if not already there)
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Option 3: System-Wide Installation (Requires sudo)

```bash
sudo cp bin/* /usr/local/bin/
```

## 📖 Commands Overview

| Command | Purpose | File Types |
|---------|---------|-----------|
| **cgrep** | Search in C/C++ files | `.c`, `.cpp`, `.cc`, `.cxx`, `.h`, `.hpp`, `.hh` |
| **jgrep** | Search in Java files | `.java` |
| **resgrep** | Search in resource XML files | `res/*.xml` |
| **mgrep** | Search in Makefile and build files | `Makefile`, `*.make`, `*.mak`, `*.mk` |
| **treegrep** | Search across all common source types | `.c`, `.h`, `.cpp`, `.hpp`, `.S`, `.java`, `.xml` |

## 💡 Usage Examples

```bash
# Search for a function in C/C++ files
cgrep "my_function"

# Search for a class in Java files
jgrep "MyClass"

# Search in resource files
resgrep "android:id"

# Search in Makefiles
mgrep "LOCAL_MODULE"

# Search across all source types (case-insensitive)
treegrep "TODO"

# Use grep options
cgrep -i "pattern"        # Case-insensitive
cgrep -l "pattern"        # Show only filenames
cgrep -c "pattern"        # Count matches
cgrep -B2 -A2 "pattern"   # Show context
```

For more examples, see `examples/EXAMPLES.md`.

## 📚 Documentation

- **README_SETUP.md** - Quick start guide for your team
- **INSTALLATION_GUIDE.md** - Detailed installation instructions with 4 methods
- **aosp_grep_guide.md** - Complete command reference and Linux equivalents
- **EXAMPLES.md** - Real-world usage scenarios and advanced tips

## ✅ System Requirements

- Linux or macOS
- Bash shell
- `find`, `xargs`, and `grep` commands (standard on most systems)

## 🔧 Installation Troubleshooting

### Commands not found after installation

1. Verify the installation directory is in your PATH:
   ```bash
   echo $PATH
   ```

2. If using `~/.local/bin`, ensure it's in your PATH:
   ```bash
   echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
   source ~/.bashrc
   ```

3. Verify scripts are executable:
   ```bash
   ls -la ~/.local/bin/cgrep
   ```

### Permission denied

Make sure scripts are executable:
```bash
chmod +x ~/.local/bin/{cgrep,jgrep,resgrep,mgrep,treegrep}
```

### Scripts not finding files

Ensure you're running from within your project directory:
```bash
cd /path/to/your/project
cgrep "search_pattern"
```

## 🗑️ Uninstalling

```bash
# If installed to ~/.local/bin
rm ~/.local/bin/{cgrep,jgrep,resgrep,mgrep,treegrep}

# If installed to /usr/local/bin
sudo rm /usr/local/bin/{cgrep,jgrep,resgrep,mgrep,treegrep}
```
## 🎯 Key Features

- ✅ **Fast** - Optimized find and grep commands
- ✅ **Reliable** - Based on AOSP's proven approach
- ✅ **Easy to Install** - Automated installation script
- ✅ **Well Documented** - Comprehensive guides and examples
- ✅ **Team Friendly** - Easy to distribute and maintain
- ✅ **Cross-Platform** - Works on Linux and macOS
- ✅ **No Dependencies** - Uses only standard Unix tools

## 📝 Notes

- These commands are wrappers around standard `find` and `grep` utilities
- They search recursively from the current directory
- All commands support standard grep options
- For best results, run from your project root directory

## 🤝 Support

For issues or questions:

1. Check the `docs/INSTALLATION_GUIDE.md` for troubleshooting
2. Review `examples/EXAMPLES.md` for usage patterns
3. Verify all system requirements are met
4. Ensure you have read/execute permissions on script files

## 📄 License

These scripts are based on the Android Open Source Project's build system utilities and are provided as-is for development purposes.

## 🔗 Related Resources

- [Android Open Source Project](https://source.android.com/)
- [GNU grep documentation](https://www.gnu.org/software/grep/)
- [Find command documentation](https://www.gnu.org/software/findutils/)

---

**Version:** 1.0  
**Last Updated:** January 2026  
**Maintainer:** Your Team
