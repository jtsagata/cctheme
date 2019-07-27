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

# sudo gem install --no-ri copyright-header

copyright-header --license AGPL3 \
                 --add-path "${dir}/../src" \
                 --remove-path "${dir}/../src/ext/fmt" \
                 --output-dir "${dir}/../" \
                 --copyright-holder 'Ioannis Tsagkatakis' \
                 --copyright-software 'ctheme' \
                 --copyright-software-description 'ctheme color generator and switcher' \
                 --copyright-year 2019

# Reset submodules
git submodule foreach git reset --hard

# Reset ext
git checkout HEAD -- src/ext

cd "${dir}/.."
git status