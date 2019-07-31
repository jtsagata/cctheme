#!/usr/bin/env bash

if [[ "$1" == "reset" ]]; then
  dconf reset -f /org/gnome/terminal/legacy/profiles:/
  exit
fi

dset() {
  local key="$1"
  shift
  local val="$1"
  shift

  #    if [[ "$type" == "string" ]]; then
  #        val="'$val'"
  #    fi

  dconf write "$PROFILE_KEY/$key" "$val"
}

profile=$(gsettings get org.gnome.Terminal.ProfilesList default)
profile_id=${profile:1:-1}

dconfdir=/org/gnome/terminal/legacy/profiles:
profile_path="$dconfdir/:$profile_id"

# update profile values with theme options
dconf write "${profile_path}/visible-name" "'Eighties (dark) '"
dconf write "${profile_path}/background-color" "'#2d2d2d'"
dconf write "${profile_path}/foreground-color" "'#d3d0c8'"
dconf write "${profile_path}/bold-color" "'#d3d0c8'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#2d2d2d', '#f2777a', '#99cc99', '#ffcc66', '#6699cc', '#cc99cc', '#66cccc', '#d3d0c8', '#747369', '#f2777a', '#99cc99', '#ffcc66', '#6699cc', '#cc99cc', '#66cccc', '#f2f0ec']"
