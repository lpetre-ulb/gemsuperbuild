# CMake superbuild for the GEM DAQ software

The superbuild aims to ease the compilation of the GEM DAQ software during development.
It is based on CMake and can build sofwares for the DAQ machine, the CTP7 and the GLIB on `lxplus7`.

## Quick start

In order to compile this superbuild, you need to launch `cmake` in a build tree.
Note that in-source builds are disallowed.

Once you have recursively cloned this Git repository, you can use the following commands to trigger a build on `lxplus7`.
``` bash
cmake3 -S . -B build # The CMake 3 command is named `cmake3` on CentOS
scl enable devtoolset-7 -- cmake3 --build build/
```

## Requirements

The minimal build toolchain is :
* CMake 3.6
* g++ 7

## Options

* `CTP7_BUILD` : Build the software for the CTP7 (default: OFF)
  * `CTP7_SYSROOT` : Sysroot of the CTP7 (required when `CTP7_BUILD=ON`)
* `GLIB_BUILD` : Build the software for the GLIB (default: OFF)
* `PC_BUILD` : Build the software for the DAQ machine (default : ON)

### Advanced

* `SUPERBUILD_CACHE_DIR` : Defines the cache path for the archives. If you frequently delete your build directory, this avoid re-downloading the archives.
* `EXPERIMENTAL_BUILD` : Build experimental projects which could fail the build (e.g. cmsgemos) (default: OFF)

