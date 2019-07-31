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
dconf write "${profile_path}/visible-name" "'Paraiso (dark) '"
dconf write "${profile_path}/background-color" "'#2f1e2e'"
dconf write "${profile_path}/foreground-color" "'#a39e9b'"
dconf write "${profile_path}/bold-color" "'#a39e9b'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#2f1e2e', '#ef6155', '#48b685', '#fec418', '#06b6ef', '#815ba4', '#5bc4bf', '#a39e9b', '#776e71', '#ef6155', '#48b685', '#fec418', '#06b6ef', '#815ba4', '#5bc4bf', '#e7e9db']"
