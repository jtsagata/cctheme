#!/usr/bin/env bash

reset=$(tput sgr0)
red=$(tput sgr0; tput setaf 1)
green=$(tput sgr0; tput setaf 2)

if [[ "$1" == "clean" ]]; then
  rm -r cmake-build-*
  exit
fi

build_type=${1:-Debug}
echo "Build type: ${green}${build_type}${reset}"

build_dir=cmake-build-${build_type,,}
echo "Build dir : ${green}${build_dir}${reset}"

GENERATOR="CodeBlocks - Unix Makefiles"
if [ ! -d "${build_dir}" ]; then
  mkdir -p "${build_dir}"
  pushd "${build_dir}" > /dev/null || exit

  # Use CLion compatible builder for cmake
  cmake .. \
      -DCMAKE_BUILD_TYPE="${build_type}" -G "${GENERATOR}" \
      -DCMAKE_TOOLCHAIN_FILE=clang-toolchain.cmake

  res=$?
  if [ $res -eq 0 ]; then
      echo "${green}Configure OK${reset}"
  else
      echo "${red}Configure FAILED${reset}"
      exit $res
  fi
  popd > /dev/null || exit
fi

use_verbose=0
pushd "${build_dir}" || exit
pwd
if [[ "$use_verbose" == "1" ]]; then
  # Use all cores
  make -j "$(nproc)"  VERBOSE=1
else
  make -j "$(nproc)"
fi

res=$?
if [ $res -eq 0 ]; then
    echo "${green}Build OK${reset}"
else
    echo "${red}Build FAILED${reset}"
    exit $res
fi

popd > /dev/null || exit