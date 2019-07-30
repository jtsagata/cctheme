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


awk -f \
<(cat - <<-'EOD'
  BEGIN { print "#include \"colors.h\"\n"; \
          print "const named_colors_map named_colors = {" }
  END   { print "};\n" }

  $1 !~ /^!/ { printf "\t{%-22s,rgb_color{%-3d,%-3d,%-3d,255} }, // #%02X%02X%02X\n", sprintf("\"%s\"", tolower($4)), $1,$2,$3, $1,$2,$3 }
EOD
) < rgb.txt > $(dirname "$0")/../src/ccthemegen/named_colors.cpp
