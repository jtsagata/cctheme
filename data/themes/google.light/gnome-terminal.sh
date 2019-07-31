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
dconf write "${profile_path}/visible-name" "'Google (light) '"
dconf write "${profile_path}/background-color" "'#ffffff'"
dconf write "${profile_path}/foreground-color" "'#373b41'"
dconf write "${profile_path}/bold-color" "'#373b41'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#1d1f21', '#cc342b', '#198844', '#fba922', '#3971ed', '#a36ac7', '#3971ed', '#c5c8c6', '#969896', '#cc342b', '#198844', '#fba922', '#3971ed', '#a36ac7', '#3971ed', '#ffffff']"
