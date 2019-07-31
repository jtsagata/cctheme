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

top_dir=$(git rev-parse --show-toplevel)

svg_dir="${top_dir}/data/templates"
svg_file="${top_dir}/data/themes/Solarized.light/preview.svg"
out_file="${top_dir}/data/themes/Solarized.light/preview.png"

echo "Watching ${svg_file}"
inotifywait -e close_write,moved_to,create -m "${svg_dir}" |
while read -r directory events filename; do
  if [ "$filename" = "preview.svg" ]; then
     ${top_dir}/./ct-build -- ./ccthemegen -vf Solarized.light
      inkscape -z -e "${out_file}" -w 300 -h 100 "${svg_file}"
#      cairosvg-py3 "${svg_file}" -o "${out_file}"
  fi
done