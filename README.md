# CMake toolchain files for embedded

Hierarchy

```
.
└── <compiler>
    ├── <target>
    │   └── <processor>.cmake
    └── <target>.cmake
```

## Ways to use toolchain file

### a. With FetchContent (recommended)

1. Import toolchain file to your project with _FetchContent_

    Add following codes prior to `project()` command:

    ```cmake
    # The CMAKE_TOOLCHAIN_FILE variable is not used until the project() command is reached, at which point CMake looks for
    # the named toolchain file relative to the build directory.
    include(FetchContent)
    FetchContent_Declare(toolchains URL https://codeload.github.com/cmake-embedded/toolchains/zip/refs/heads/main)
    FetchContent_MakeAvailable(toolchains)
    ```

    > 💡 Get dependency version locked is usually considered a better practice to prevent dependency been broken, instead of always pointing to head version.

2. Specify toolchain file with path relative to the build directory

    ```shell
    $ cmake --toolchain _deps/toolchains-src/gcc/arm-none-eabi/cortex-m0.cmake /path/to/src
    ```

    > 💡 `--toolchain` is equivalent to setting `CMAKE_TOOLCHAIN_FILE` variable, introduced since v3.21, which is easier to type correctly.

    > 💡 `toolchains-src` is the dependent name specified in FetchContent_Declare with `-src` suffix.

    🤔 How does it work? According to documentation of CMake:
    > When CMake processes the CMakeLists.txt file, it will download and unpack the tarball into _deps/toolchains-src relative to the build directory. The CMAKE_TOOLCHAIN_FILE variable is not used until the project() command is reached, at which point CMake looks for the named toolchain file relative to the build directory. Because the tarball has already been downloaded and unpacked by then, the toolchain file will be in place, even the very first time that cmake is run in the build directory.

### b. With git submodule

1. Add this repo as submodule

    ```shell
    $ git submodule add https://github.com/cmake-embedded/toolchains
    ```

2. Specify toolchain file with path relative to the source directory

    ```shell
    $ cmake --toolchain toolchains/gcc/arm-none-eabi/cortex-m0.cmake /path/to/src
    ```

    > 💡 `--toolchain` is equivalent to setting `CMAKE_TOOLCHAIN_FILE` variable, introduced since v3.21, which is easier to type correctly.

    > 💡 Relative paths are allowed and are interpreted first as relative to the build directory, and if not found, relative to the source directory.
