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
dconf write "${profile_path}/visible-name" "'Grayscale (dark) '"
dconf write "${profile_path}/background-color" "'#101010'"
dconf write "${profile_path}/foreground-color" "'#b9b9b9'"
dconf write "${profile_path}/bold-color" "'#b9b9b9'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#101010', '#7c7c7c', '#8e8e8e', '#a0a0a0', '#686868', '#747474', '#868686', '#b9b9b9', '#525252', '#7c7c7c', '#8e8e8e', '#a0a0a0', '#686868', '#747474', '#868686', '#f7f7f7']"
