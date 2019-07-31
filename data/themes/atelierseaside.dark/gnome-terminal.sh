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
dconf write "${profile_path}/visible-name" "'Atelierseaside (dark) '"
dconf write "${profile_path}/background-color" "'#131513'"
dconf write "${profile_path}/foreground-color" "'#8ca68c'"
dconf write "${profile_path}/bold-color" "'#8ca68c'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#131513', '#e6193c', '#29a329', '#c3c322', '#3d62f5', '#ad2bee', '#1999b3', '#8ca68c', '#687d68', '#e6193c', '#29a329', '#c3c322', '#3d62f5', '#ad2bee', '#1999b3', '#f0fff0']"
