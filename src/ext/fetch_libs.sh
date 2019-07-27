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
dir=$(dirname "$0")

curl -Ls https://github.com/pantor/inja/releases/download/v2.1.0/inja.hpp    -o "${dir}/inja.hpp"
curl -Ls https://github.com/nlohmann/json/releases/download/v3.6.1/json.hpp  -o "${dir}/json.hpp"
curl -Ls https://raw.githubusercontent.com/jarro2783/cxxopts/master/include/cxxopts.hpp -o "${dir}/cxxopts.hpp"
#curl -Ls https://raw.githubusercontent.com/agauniyal/rang/master/include/rang.hpp -o "${dir}/rang.hpp"

sed  -i "s|#include <nlohmann/json.hpp>|#include <json.hpp>|g" "${dir}/inja.hpp"

curl -Ls https://raw.githubusercontent.com/sakra/cotire/master/CMake/cotire.cmake -o "${dir}/../../cotire.cmake"