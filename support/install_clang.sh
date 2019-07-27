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

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

source /etc/os-release

echo "Ubuntu code name: ${UBUNTU_CODENAME}"

# Install apt repository
UBUNTU_CODENAME="bionic"
tee /etc/apt/sources.list.d/llvm.list <<EOF 
deb http://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME} main
deb-src http://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME} main
# 7
deb http://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME}-7 main
deb-src http://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME}-7 main
# 8
deb http://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME}-8 main
deb-src http://apt.llvm.org/${UBUNTU_CODENAME}/ llvm-toolchain-${UBUNTU_CODENAME}-8 main
EOF

wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key| apt-key add -

apt update

apt install -y clang-9 clang-tools-9 clang-format-9 libc++-9-dev libc++abi-9-dev

BIN=/usr/local/bin
CLANG_BIN=/usr/lib/llvm-9/bin
PRIORITY=190
update-alternatives \
  --install $BIN/clang               clang                         $CLANG_BIN/clang  $PRIORITY \
    --slave $BIN/clang++               clang++                     $CLANG_BIN/clang++  \
    --slave $BIN/clang-check           clang-check                 $CLANG_BIN/clang-check \
    --slave $BIN/clang-format          clang-format                $CLANG_BIN/clang-format  \
    --slave $BIN/clang-query           clang-query                 $CLANG_BIN/clang-query \
    --slave $BIN/clang-tidy            clang-tidy                  $CLANG_BIN/clang-tidy \
    --slave $BIN/clang-rename          clang-rename                $CLANG_BIN/clang-rename \
    --slave $BIN/clang-include-fixer   clang-include-fixer         $CLANG_BIN/clang-include-fixer \
    --slave $BIN/clangd                clangd                      $CLANG_BIN/clangd  \
    --slave $BIN/lldb                  lldb                        $CLANG_BIN/lldb \
    --slave $BIN/lld                   lld                         $CLANG_BIN/lld
