# AOSP Grep Commands - Usage Examples

This file contains practical examples of how to use each grep command in real-world scenarios.

## Basic Usage

### cgrep - Search in C/C++ Files

```bash
# Find a function definition
cgrep "void my_function"

# Find all references to a variable
cgrep "global_variable"

# Case-insensitive search
cgrep -i "TODO"

# Show line numbers and filenames
cgrep "struct_name"
```

### jgrep - Search in Java Files

```bash
# Find a class definition
jgrep "public class MyClass"

# Find method calls
jgrep "onCreate"

# Find imports
jgrep "import android"

# Show only filenames with matches
jgrep -l "MainActivity"
```

### resgrep - Search in Resource XML Files

```bash
# Find all string resources
resgrep "string name"

# Find specific layout references
resgrep "@layout/activity_main"

# Find color definitions
resgrep "color name"

# Find all IDs
resgrep "android:id"
```

### mgrep - Search in Makefiles

```bash
# Find all LOCAL_MODULE definitions
mgrep "LOCAL_MODULE"

# Find specific module
mgrep "LOCAL_MODULE := myapp"

# Find LOCAL_SRC_FILES
mgrep "LOCAL_SRC_FILES"

# Find include statements
mgrep "include"
```

### treegrep - Search Across All Source Types

```bash
# Find all TODO comments (case-insensitive)
treegrep "TODO"

# Find all FIXME comments
treegrep "FIXME"

# Find specific function/method across all types
treegrep "initialize"

# Find deprecated API usage
treegrep "deprecated"
```

## Advanced Examples

### Combining with Other Commands

```bash
# Count occurrences in each file
cgrep "pattern" | cut -d: -f1 | sort | uniq -c

# Find files with most occurrences
cgrep "pattern" | cut -d: -f1 | sort | uniq -c | sort -rn | head -10

# Show only unique matches
cgrep "pattern" | cut -d: -f3 | sort -u

# Find matches in specific file types
cgrep "pattern" | grep "\.cpp:"

# Export results to file
cgrep "pattern" > results.txt
```

### Using grep Options

```bash
# Show context (2 lines before and after)
cgrep -B2 -A2 "pattern"

# Show only line numbers
cgrep -n "pattern"

# Invert match (show lines NOT containing pattern)
cgrep -v "pattern"

# Count total matches
cgrep "pattern" | wc -l

# Case-insensitive search
cgrep -i "Pattern"

# Match whole words only
cgrep -w "word"
```

## Real-World Scenarios

### Scenario 1: Finding a Bug in C Code

You need to find where a variable is modified:

```bash
# Search for all assignments to the variable
cgrep "my_var ="

# Search for all references
cgrep "my_var"

# Show context around matches
cgrep -B2 -A2 "my_var"
```

### Scenario 2: Refactoring Java Code

You want to rename a method across the project:

```bash
# Find all calls to the old method
jgrep "oldMethodName"

# Count how many files need updating
jgrep "oldMethodName" | cut -d: -f1 | sort -u | wc -l

# Show context for each match
jgrep -B1 -A1 "oldMethodName"
```

### Scenario 3: Finding Resource References

You want to find all uses of a specific drawable:

```bash
# Find all references to a drawable
resgrep "@drawable/my_drawable"

# Find where it's defined
resgrep "drawable name=\"my_drawable\""

# Find all drawable references
resgrep "@drawable/"
```

### Scenario 4: Build System Analysis

You want to understand module dependencies:

```bash
# Find all modules that depend on a specific library
mgrep "LOCAL_STATIC_LIBRARIES.*mylib"

# Find all modules in a specific directory
mgrep "LOCAL_PATH" | grep "frameworks"

# Find all modules with specific flags
mgrep "LOCAL_CFLAGS.*-Wall"
```

### Scenario 5: Code Quality Checks

Find potential issues across the codebase:

```bash
# Find all TODO comments
treegrep "TODO"

# Find all FIXME comments
treegrep "FIXME"

# Find all XXX comments
treegrep "XXX"

# Find deprecated API usage
treegrep "deprecated"

# Find potential security issues
treegrep "TODO.*security"
```

## Performance Tips

### For Large Codebases

```bash
# Exclude specific directories
find . -not -path "*/build/*" -not -path "*/.git/*" -type f -name "*.java" -print0 | xargs -0 grep "pattern"

# Limit search to specific directory
cd frameworks/base
cgrep "pattern"

# Use more specific patterns
cgrep "^void my_function" # Start of line
cgrep "my_function\(" # Function call
```

### Combining Multiple Patterns

```bash
# Search for multiple patterns
cgrep "pattern1\|pattern2"

# Search for pattern but exclude another
cgrep "pattern" | grep -v "exclude"

# Find lines with multiple patterns
cgrep "pattern1" | xargs grep "pattern2"
```

## Saving and Analyzing Results

```bash
# Save results to file
cgrep "pattern" > results.txt

# Save with line numbers and filenames
cgrep -n "pattern" > results.txt

# Create a report
{
  echo "Search Results for: pattern"
  echo "Date: $(date)"
  echo "Total matches: $(cgrep 'pattern' | wc -l)"
  echo "Files affected: $(cgrep 'pattern' | cut -d: -f1 | sort -u | wc -l)"
  echo ""
  echo "Detailed results:"
  cgrep "pattern"
} > report.txt
```

## Troubleshooting Examples

### No Results Found

```bash
# Check if you're in the right directory
pwd

# Verify files exist
find . -name "*.java" | head

# Try a simpler pattern
cgrep "class"

# Check for typos
cgrep "MyClass"  # vs cgrep "myclass"
```

### Too Many Results

```bash
# Narrow down the search
cgrep "^void my_function"  # More specific

# Exclude noise
cgrep "pattern" | grep -v "test"

# Limit to specific directory
cd src
cgrep "pattern"

# Show only filenames
cgrep -l "pattern"
```

### Performance Issues

```bash
# Check current directory
pwd

# Exclude large directories
find . -not -path "*/node_modules/*" -not -path "*/.git/*" -type f -name "*.java" -print0 | xargs -0 grep "pattern"

# Search in specific subdirectory
cd frameworks
cgrep "pattern"

# Use more specific pattern
cgrep "^public class"  # Instead of just "class"
```

## Tips for Team Collaboration

### Sharing Search Results

```bash
# Create a readable report
{
  echo "=== Search Results ==="
  echo "Pattern: my_pattern"
  echo "Date: $(date)"
  echo ""
  cgrep "my_pattern" | sort
} > team_report.txt
```

### Documenting Findings

```bash
# Create a searchable index
cgrep "TODO" > todos.txt
cgrep "FIXME" > fixmes.txt
cgrep "XXX" > xxx.txt

# Share with team
git add todos.txt fixmes.txt xxx.txt
git commit -m "Update code issues index"
```

### Creating Search Aliases

Add to your `~/.bashrc`:

```bash
# Quick searches
alias find_todos="treegrep 'TODO'"
alias find_fixmes="treegrep 'FIXME'"
alias find_deprecations="treegrep 'deprecated'"
```

Then use:
```bash
find_todos
find_fixmes
find_deprecations
```
