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
dconf write "${profile_path}/visible-name" "'Embers (light) '"
dconf write "${profile_path}/background-color" "'#dbd6d1'"
dconf write "${profile_path}/foreground-color" "'#433b32'"
dconf write "${profile_path}/bold-color" "'#433b32'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#16130f', '#826d57', '#57826d', '#6d8257', '#6d5782', '#82576d', '#576d82', '#a39a90', '#5a5047', '#826d57', '#57826d', '#6d8257', '#6d5782', '#82576d', '#576d82', '#dbd6d1']"
