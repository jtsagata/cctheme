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
dconf write "${profile_path}/visible-name" "'Codeschool (light) '"
dconf write "${profile_path}/background-color" "'#b5d8f6'"
dconf write "${profile_path}/foreground-color" "'#2a343a'"
dconf write "${profile_path}/bold-color" "'#2a343a'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#232c31', '#2a5491', '#237986', '#a03b1e', '#484d79', '#c59820', '#b02f30', '#9ea7a6', '#3f4944', '#2a5491', '#237986', '#a03b1e', '#484d79', '#c59820', '#b02f30', '#b5d8f6']"
