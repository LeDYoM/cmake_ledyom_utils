# cmake_ledyom_utils
Small repo containing cmake utility scripts as general as possible to be used
in different projects. There are basically tailored for me (LeDYoM) and
configured with sensible defaults for my common use cases, that do not mean
that they cannot be used either directly or modified to be used by you or to
learn. Use at your own risk.

## Files:
main.cmake: Include all other files.
compiling.cmake: Scripts and functions related to compilation.
documenting.cmake: Scripts and functions related to generating documentation

## Usage:

The normal usage would be to, first include the files in your project. It can be done directly with CMake Fetch...

```cmake
    # Start common part to get CMake common scripts
    include(FetchContent)

    # Fetch my cmake utils package
    FetchContent_Declare(
        cmake_ledyom_utils
        GIT_REPOSITORY https://github.com/LeDYoM/cmake_ledyom_utils.git
        # GIT_TAG master
    )

    FetchContent_MakeAvailable(cmake_ledyom_utils)
    list(APPEND CMAKE_MODULE_PATH ${cmake_ledyom_utils_SOURCE_DIR})

    include(documenting)
    include(compiling)
    ...
    # Finish common part
```

You can add modules using include(module), or you can use

```cmake
    # Include all modules (cmake_ledyom_utils_all)
    include(c_l_u_a)
```
