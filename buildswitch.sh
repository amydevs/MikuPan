#!/bin/bash

ninja="/usr/bin/ninja"
bash="/usr/bin/bash"
make="/usr/bin/make"

cmake -S . -B "cmake-build-switch-arm64" -G "Ninja" \
   -DCMAKE_MAKE_PROGRAM="$ninja" \
   -DBASH_EXECUTABLE="$bash" \
   -DMAKE_EXECUTABLE="$make" \
   -DCMAKE_TOOLCHAIN_FILE="/opt/devkitpro/cmake/Switch.cmake" \
   -DCMAKE_BUILD_TYPE="Release"