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
dconf write "${profile_path}/visible-name" "'Atelierdune (light) '"
dconf write "${profile_path}/background-color" "'#fefbec'"
dconf write "${profile_path}/foreground-color" "'#6e6b5e'"
dconf write "${profile_path}/bold-color" "'#6e6b5e'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#20201d', '#d73737', '#60ac39', '#cfb017', '#6684e1', '#b854d4', '#1fad83', '#a6a28c', '#7d7a68', '#d73737', '#60ac39', '#cfb017', '#6684e1', '#b854d4', '#1fad83', '#fefbec']"
