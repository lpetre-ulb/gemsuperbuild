# gemsuperbuild
CMake superbuild for the GEM DAQ software.

## Usage

In order to compile this superbuild, you need to launch `cmake3` in a build tree.
Note that in-source builds are disallowed.

The following commands launch a build without the CTP7 cross-compilation :
``` bash
mkdir build/ && cd build/
cmake3 -DCTP7_BUILD=OFF ..
make
```

## Options

* `CTP7_BUILD` : Build the software for the CTP7 (default: ON)
  * `CTP7_SYSROOT` : Sysroot of the CTP7 (required when `ARM_BUILD=ON`)
* `GLIB_BUILD` : Build the software for the GLIB (default: OFF)
* `PC_BUILD` : Build the software for the DAQ machine (default : ON)
  * `BUILD_XDAQ` : Enable this option if you want to compile `xDAQ` in tree (default: OFF)

### Advanced

* `GEM_SUPERBUILD_CACHE_DIR` : Defines the cache path for the archives. If you frequently delete your build directory, this avoid re-downloading the archives.

