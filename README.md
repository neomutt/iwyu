# Include What You Use

- [https://include-what-you-use.org/](https://include-what-you-use.org/)

**iwyu** is a tool for deciding which `#include`s are needed, or not.
Including the right files, and no more, can speed up builds.
It also helps to show the dependencies of a file.

**iwyu** uses [clang](https://clang.llvm.org/) to create an
[AST](https://en.wikipedia.org/wiki/Abstract_syntax_tree) for the code.

## Usage

Configure + build NeoMutt with a compilation database.
```sh
./configure --compile-commands && make
```

**!** Some build systems output a `compilation_commands.json` with a trailing comma on the last line which is invalid JSON. **!**

The fix is to simply remove the trailing comma, here's a shell oneliner to do that:
```sh
tac compile_commands.json | sed '2 s/.$//' | tac > compile_commands.json.tmp && mv compile_commands.json.tmp compile_commands.json
```

Then run the main script with the source you wish to check:
```sh
iwyu.sh mutt/*.[c]
```

Or with all files in the compilation database:
```sh
cat compile_commands.json| jq -r '.[] | .file' | xargs ../iwyu/bin/iwyu.sh
```

## Known Limitations

Out of nearly 300 header files, most are correctly handled.
The exceptions are the curses and ssl headers.
