# Include What You Use

- [https://include-what-you-use.org/](https://include-what-you-use.org/)

**iwyu** is a tool for deciding which `#include`s are needed, or not.
Including the right files, and no more, can speed up builds.
It also helps to show the dependencies of a file.

**iwyu** uses [clang](https://clang.llvm.org/) to create an
[AST](https://en.wikipedia.org/wiki/Abstract_syntax_tree) for the code.

This repo contains some crude scripts and config files for NeoMutt.

The scripts contain a lot of references that are probably only valid for me,
using Fedora 35.  Improvements are welcome.

## Running

To check the project, first configure NeoMutt, then the main script:

```sh
./configure
iwyu.sh
```

## Known Limitations

Out of nearly 300 header files, most are correctly handled.
The exceptions are the curses and ssl headers.
