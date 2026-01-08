# AOSP Grep Commands vs. Standard Linux Grep

This guide provides a comprehensive overview of the specialized `grep` commands available in the Android Open Source Project (AOSP) environment and their corresponding equivalents in a standard Linux distribution. These AOSP commands are shortcuts defined in the `build/envsetup.sh` script to streamline searching within the AOSP source code.

## Understanding the AOSP Grep Commands

The AOSP `grep` commands are essentially wrappers around the standard `find` and `grep` utilities, tailored to search specific file types commonly found in the Android source tree. Below is a table detailing these commands and their Linux equivalents.

| AOSP Command | Description                               | Standard Linux Equivalent                                                                                                                                                                                             |
| :----------- | :---------------------------------------- | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `cgrep`      | Greps on all local C/C++ files.           | `find . -type f \( -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" \) -print0 \| xargs -0 grep --color -n`                                                                                                      |
| `jgrep`      | Greps on all local Java files.            | `find . -type f -name "*.java" -print0 \| xargs -0 grep --color -n`                                                                                                                                                           |
| `resgrep`    | Greps on all local `res/*.xml` files.     | `find . -path "*/res/*.xml" -type f -print0 \| xargs -0 grep --color -n`                                                                                                                                                       |
| `mgrep`      | Greps on all local Makefiles.             | `find . -type f \( -name "Makefile" -o -name "Makefile.*" -o -name "*.make" -o -name "*.mak" -o -name "*.mk" \) -print0 \| xargs -0 grep --color -n`                                                                         |
| `treegrep`   | Greps on a tree of common source files.   | `find . -type f \( -name "*.c" -o -name "*.h" -o -name "*.cpp" -o -name "*.S" -o -name "*.java" -o -name "*.xml" \) -print0 \| xargs -0 grep --color -n -i`                                                                   |

## Practical Examples

Here are some practical examples of how to use these commands to search for a specific string, such as `my_function`, within your project.

### `cgrep` Example

To search for `my_function` in all C and C++ source and header files:

**AOSP:**
```bash
cgrep "my_function"
```

**Standard Linux:**
```bash
find . -type f \( -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" \) -print0 | xargs -0 grep --color -n "my_function"
```

This command will search for the string `my_function` in all files with the extensions `.c`, `.cpp`, `.h`, and `.hpp` within the current directory and its subdirectories.

### Creating a Reusable Script

For convenience, you can create a shell script to replicate the AOSP `cgrep` functionality in your standard Linux environment. Create a file named `cgrep.sh` with the following content:

```bash
#!/bin/bash
find . -type f \( -name "*.c" -o -name "*.cpp" -o -name "*.h" -o -name "*.hpp" \) -print0 | xargs -0 grep --color -n "$@"
```

Make the script executable:

```bash
chmod +x cgrep.sh
```

You can now use it just like the AOSP command:

```bash
./cgrep.sh "my_function"
```

This guide should help your team understand and utilize the power of AOSP's specialized `grep` commands, and replicate their functionality in a standard Linux environment for more efficient code searching.
