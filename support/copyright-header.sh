#!/usr/bin/env bash
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