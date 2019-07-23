#!/usr/bin/env bash

build_type=${1:-Debug}
echo "Build type: ${build_type}"

build_dir=cmake-build-${build_type,,}
echo "Build dir : ${build_dir}"

mkdir -p "${build_dir}"
pushd "${build_dir}" || exit


# Use CLion compatible builder for cmake
cmake .. \
    -DCMAKE_BUILD_TYPE="${build_type}" -G "CodeBlocks - Unix Makefiles" \
    -DCMAKE_TOOLCHAIN_FILE=clang-toolchain.cmake

# Use all cores
time make -j "$(nproc)" VERBOSE=1
