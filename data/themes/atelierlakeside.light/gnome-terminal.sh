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
dconf write "${profile_path}/visible-name" "'Atelierlakeside (light) '"
dconf write "${profile_path}/background-color" "'#ebf8ff'"
dconf write "${profile_path}/foreground-color" "'#516d7b'"
dconf write "${profile_path}/bold-color" "'#516d7b'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#161b1d', '#d22d72', '#568c3b', '#8a8a0f', '#257fad', '#5d5db1', '#2d8f6f', '#7ea2b4', '#5a7b8c', '#d22d72', '#568c3b', '#8a8a0f', '#257fad', '#5d5db1', '#2d8f6f', '#ebf8ff']"
