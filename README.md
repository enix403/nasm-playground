# Nasm Playground

Tiny Nasm programs to learn assembly.

## Programs

It contains the following programs

| No.   | Name          | Description |
| :---: | ---           | --- |
| 01    | hello-world   | Prints 'Hello World!' to stdout. |
| 02    | user-input    | Inputs a number from user and prints is back. |
| 03    | fib-loop      | Calculates N'th fibonacci number and displays it (using loops) |
| 04    | fib-recursive | Calculates N'th fibonacci number and displays it (using recursion) |

*Note: More programs are being continually added*

## Building Instructions

1. Install the required dependencies.
   
   - **Arch Linux / Manjaro**

     First, make sure to [enable multilib repository][arch-enable-multilib]. After that run the following commands.
     ```sh
     pacman -S nasm binutils make gcc # If you don't already have
     ```

   - **Ubuntu / Debian**

     ```sh
     apt-get update
     apt-get install nasm build-essential binutils # If you don't already have
     ```
   - **Other Distros**

     Use your distro's package manager to install the following dependencies.

     - NASM
     - GCC
     - Make
     - LD linker

2. Compile the sources:

   ```sh
   make
   ```

3. Run a program:

    ```sh
    ./build/01-hello-world
    ```



[arch-enable-multilib]: https://wiki.archlinux.org/title/official_repositories