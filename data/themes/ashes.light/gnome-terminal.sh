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
dconf write "${profile_path}/visible-name" "'Ashes (light) '"
dconf write "${profile_path}/background-color" "'#f3f4f5'"
dconf write "${profile_path}/foreground-color" "'#565e65'"
dconf write "${profile_path}/bold-color" "'#565e65'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#1c2023', '#c7ae95', '#95c7ae', '#aec795', '#ae95c7', '#c795ae', '#95aec7', '#c7ccd1', '#747c84', '#c7ae95', '#95c7ae', '#aec795', '#ae95c7', '#c795ae', '#95aec7', '#f3f4f5']"
