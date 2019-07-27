#!/usr/bin/env bash
#
# ctheme - ctheme color generator and switcher
# Copyright (C) 2019 Ioannis Tsagkatakis
#
# This file is part of ctheme.
#
# ctheme is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# ctheme is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with ctheme.  If not, see <http://www.gnu.org/licenses/>.
#

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