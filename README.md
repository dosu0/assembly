# Assembly Programs

## Table Of Contents

-   [Assembly Programs](#assembly-programs)
    -   [Table Of Contents](#table-of-contents)
    -   [About](#about)
        -   [Directory Structure](#directory-structure)
    -   [Assembling](#assembling)
    -   [Resources](#resources)
        -   [x32](#x32)
        -   [x64](#x64)

## About

This repository contains miscellaneous programs written in assembly that can be
assembled using [nasm](https://nasm.us). By no means is my code efficient or
follow reccomended practices.

## Directory Structure

-   `bin/`: Where the assembled and linked programs will be emitted.
-   `lib/`: Utility functions
-   `src/`: The actual source files for the programs

## Assembling

1. First of all, you need a Unix-like system to run these programs
   (assembly is not very cross-platform). Note that only macOS has been tested.

2. You will also need [nasm](https://nasm.us/). See below for installation options.

    1. From the download page
    2. Via a package manager:

    ```sh
    # macOS
    brew install nasm
    sudo port install nasm


    # Debian
    sudo apt-get install nasm

    # Arch
    sudo pacman -S nasm
    ```

3. GCC Compiler tools (for `make` and `ld`)

    1. On macOS, install [Xcode](https://developer.apple.com/xcode/) or 'the command line tools'.
    2. On Linux install gcc.
        1. Debian based systems: `sudo apt-get install gcc`

4. Finally, to assemble and link the programs, run `./build.sh`
   which just invokes the Makefile

Now in the `bin` directory, you should see various programs (depending on your
machine's architecture).

## Resources

The resources and tutorials I used to learn assembly.

[Nasm Documentation](https://www.nasm.us/xdoc/2.15.05/html/nasmdoc0.html)

### x32

-   https://asmtutor.com/
-   http://www.cs.virginia.edu/~evans/cs216/guides/x86.html)

### x64

-   https://cs.lmu.edu/~ray/notes/nasmtutorial/
-   https://www.cs.uaf.edu/2017/fall/cs301/reference/x86_64.html
-   https://www.cs.tufts.edu/comp/40/docs/x64_cheatsheet.pdf
-   https://www.cs.tufts.edu/comp/40/docs/asm64-handout.pdf
-   https://www.felixcloutier.com/x86/
-   https://github.com/HJLebbink/asm-dude/wiki
