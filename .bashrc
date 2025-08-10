# Prompt
export PS1="\n\[\e[1;32m\][aoc-c](c) \w\n❯ \[\e[0m\]"

# Aliases
alias c-format-all="find . -path ./build -prune -o -name \"*.c\" -print -exec clang-format -i {} +"
alias c-lint-all='find src -name "*.c" -exec clang-tidy {} -header-filter=.* -system-headers=false -p build --checks=* \;'
alias c-lint-all-fix='find src -name "*.c" -exec clang-tidy {} -fix -header-filter=.* -system-headers=false -p build --checks=* \;'
