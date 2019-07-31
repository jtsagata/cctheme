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
dconf write "${profile_path}/visible-name" "'Atelierforest (light) '"
dconf write "${profile_path}/background-color" "'#f1efee'"
dconf write "${profile_path}/foreground-color" "'#68615e'"
dconf write "${profile_path}/bold-color" "'#68615e'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#1b1918', '#f22c40', '#5ab738', '#d5911a', '#407ee7', '#6666ea', '#00ad9c', '#a8a19f', '#766e6b', '#f22c40', '#5ab738', '#d5911a', '#407ee7', '#6666ea', '#00ad9c', '#f1efee']"
