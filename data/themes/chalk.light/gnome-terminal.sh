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
dconf write "${profile_path}/visible-name" "'Chalk (light) '"
dconf write "${profile_path}/background-color" "'#f5f5f5'"
dconf write "${profile_path}/foreground-color" "'#303030'"
dconf write "${profile_path}/bold-color" "'#303030'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#151515', '#fb9fb1', '#acc267', '#ddb26f', '#6fc2ef', '#e1a3ee', '#12cfc0', '#d0d0d0', '#505050', '#fb9fb1', '#acc267', '#ddb26f', '#6fc2ef', '#e1a3ee', '#12cfc0', '#f5f5f5']"
