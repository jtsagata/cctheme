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
dconf write "${profile_path}/visible-name" "'Greenscreen (dark) '"
dconf write "${profile_path}/background-color" "'#001100'"
dconf write "${profile_path}/foreground-color" "'#00bb00'"
dconf write "${profile_path}/bold-color" "'#00bb00'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#001100', '#007700', '#00bb00', '#007700', '#009900', '#00bb00', '#005500', '#00bb00', '#007700', '#007700', '#00bb00', '#007700', '#009900', '#00bb00', '#005500', '#00ff00']"
