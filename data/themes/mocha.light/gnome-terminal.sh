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
dconf write "${profile_path}/visible-name" "'Mocha (light) '"
dconf write "${profile_path}/background-color" "'#f5eeeb'"
dconf write "${profile_path}/foreground-color" "'#645240'"
dconf write "${profile_path}/bold-color" "'#645240'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#3b3228', '#cb6077', '#beb55b', '#f4bc87', '#8ab3b5', '#a89bb9', '#7bbda4', '#d0c8c6', '#7e705a', '#cb6077', '#beb55b', '#f4bc87', '#8ab3b5', '#a89bb9', '#7bbda4', '#f5eeeb']"
