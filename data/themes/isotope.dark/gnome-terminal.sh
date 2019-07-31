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
dconf write "${profile_path}/visible-name" "'Isotope (dark) '"
dconf write "${profile_path}/background-color" "'#000000'"
dconf write "${profile_path}/foreground-color" "'#d0d0d0'"
dconf write "${profile_path}/bold-color" "'#d0d0d0'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#000000', '#ff0000', '#33ff00', '#ff0099', '#0066ff', '#cc00ff', '#00ffff', '#d0d0d0', '#808080', '#ff0000', '#33ff00', '#ff0099', '#0066ff', '#cc00ff', '#00ffff', '#ffffff']"
