#!/usr/bin/env bash

CMAKE_VERSION='3.15.0'

CMAKE_INSTALLER="cmake-${CMAKE_VERSION}-Linux-x86_64.sh"
DOWNLOAD_URL="https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/${CMAKE_INSTALLER}"

echo "Download '$DOWNLOAD_URL'"

curl -L -o ${CMAKE_INSTALLER} ${DOWNLOAD_URL}

sudo mkdir -p /opt/cmake
sudo ./${CMAKE_INSTALLER} --prefix=/opt/cmake  --skip-license

sudo update-alternatives \
  --install /usr/local/bin/cmake      cmake      /opt/cmake/bin/cmake  200 \
    --slave /usr/local/bin/cmake-gui  cmake-gui  /opt/cmake/bin/cmake-gui \
    --slave /usr/local/bin/cpack      cpack      /opt/cmake/bin/cpack \
    --slave /usr/local/bin/ctest      ctest      /opt/cmake/bin/ctest \
    --slave /usr/local/bin/ccmake     ccmake     /opt/cmake/bin/ccmake

rm ${CMAKE_INSTALLER}