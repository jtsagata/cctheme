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
dconf write "${profile_path}/visible-name" "'3024 (dark) '"
dconf write "${profile_path}/background-color" "'#090300'"
dconf write "${profile_path}/foreground-color" "'#a5a2a2'"
dconf write "${profile_path}/bold-color" "'#a5a2a2'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#090300', '#db2d20', '#01a252', '#fded02', '#01a0e4', '#a16a94', '#b5e4f4', '#a5a2a2', '#5c5855', '#db2d20', '#01a252', '#fded02', '#01a0e4', '#a16a94', '#b5e4f4', '#f7f7f7']"
