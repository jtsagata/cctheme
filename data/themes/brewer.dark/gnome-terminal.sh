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
dconf write "${profile_path}/visible-name" "'Brewer (dark) '"
dconf write "${profile_path}/background-color" "'#0c0d0e'"
dconf write "${profile_path}/foreground-color" "'#b7b8b9'"
dconf write "${profile_path}/bold-color" "'#b7b8b9'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#0c0d0e', '#e31a1c', '#31a354', '#dca060', '#3182bd', '#756bb1', '#80b1d3', '#b7b8b9', '#737475', '#e31a1c', '#31a354', '#dca060', '#3182bd', '#756bb1', '#80b1d3', '#fcfdfe']"
