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
dconf write "${profile_path}/visible-name" "'Bespin (light) '"
dconf write "${profile_path}/background-color" "'#baae9e'"
dconf write "${profile_path}/foreground-color" "'#5e5d5c'"
dconf write "${profile_path}/bold-color" "'#5e5d5c'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#28211c', '#cf6a4c', '#54be0d', '#f9ee98', '#5ea6ea', '#9b859d', '#afc4db', '#8a8986', '#666666', '#cf6a4c', '#54be0d', '#f9ee98', '#5ea6ea', '#9b859d', '#afc4db', '#baae9e']"
