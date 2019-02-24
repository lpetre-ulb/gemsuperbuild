# gemsuperbuild
CMake superbuild for the GEM DAQ software.

## Usage

In order to compile this superbuild, you need to launch `cmake` in a build tree.
Note that in-source builds are disallowed.

The following commands launch a build without the CTP7 cross-compilation :
``` bash
mkdir build/ && cd build/
cmake3 -DARM_BUILD=OFF ..
make
```

## Options

* `ARM_BUILD` : Build the tools for the CTP7 (default: ON)
* `PETA_SYSROOT` : Sysroot of the CTP7 (required when `ARM_BUILD=ON`)
* `X86_64_BUILD` : Build the tools for the DAQ machine (default : ON)
* `BUILD_XDAQ` : Enable this option if you want to compile `xDAQ` in tree (default: OFF)

