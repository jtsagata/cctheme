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
dconf write "${profile_path}/visible-name" "'Railscasts (dark) '"
dconf write "${profile_path}/background-color" "'#2b2b2b'"
dconf write "${profile_path}/foreground-color" "'#e6e1dc'"
dconf write "${profile_path}/bold-color" "'#e6e1dc'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#2b2b2b', '#da4939', '#a5c261', '#ffc66d', '#6d9cbe', '#b6b3eb', '#519f50', '#e6e1dc', '#5a647e', '#da4939', '#a5c261', '#ffc66d', '#6d9cbe', '#b6b3eb', '#519f50', '#f9f7f3']"
