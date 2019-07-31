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
dconf write "${profile_path}/visible-name" "'Marrakesh (light) '"
dconf write "${profile_path}/background-color" "'#faf0a5'"
dconf write "${profile_path}/foreground-color" "'#5f5b17'"
dconf write "${profile_path}/bold-color" "'#5f5b17'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#201602', '#c35359', '#18974e', '#a88339', '#477ca1', '#8868b3', '#75a738', '#948e48', '#6c6823', '#c35359', '#18974e', '#a88339', '#477ca1', '#8868b3', '#75a738', '#faf0a5']"
