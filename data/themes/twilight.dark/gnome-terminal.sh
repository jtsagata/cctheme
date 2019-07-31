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
dconf write "${profile_path}/visible-name" "'Twilight (dark) '"
dconf write "${profile_path}/background-color" "'#1e1e1e'"
dconf write "${profile_path}/foreground-color" "'#a7a7a7'"
dconf write "${profile_path}/bold-color" "'#a7a7a7'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#1e1e1e', '#cf6a4c', '#8f9d6a', '#f9ee98', '#7587a6', '#9b859d', '#afc4db', '#a7a7a7', '#5f5a60', '#cf6a4c', '#8f9d6a', '#f9ee98', '#7587a6', '#9b859d', '#afc4db', '#ffffff']"
