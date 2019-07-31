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
dconf write "${profile_path}/visible-name" "'Londontube (dark) '"
dconf write "${profile_path}/background-color" "'#231f20'"
dconf write "${profile_path}/foreground-color" "'#d9d8d8'"
dconf write "${profile_path}/bold-color" "'#d9d8d8'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#231f20', '#ee2e24', '#00853e', '#ffd204', '#009ddc', '#98005d', '#85cebc', '#d9d8d8', '#737171', '#ee2e24', '#00853e', '#ffd204', '#009ddc', '#98005d', '#85cebc', '#ffffff']"
