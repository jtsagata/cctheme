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
dconf write "${profile_path}/visible-name" "'Atelierheath (light) '"
dconf write "${profile_path}/background-color" "'#f7f3f7'"
dconf write "${profile_path}/foreground-color" "'#695d69'"
dconf write "${profile_path}/bold-color" "'#695d69'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#1b181b', '#ca402b', '#379a37', '#bb8a35', '#516aec', '#7b59c0', '#159393', '#ab9bab', '#776977', '#ca402b', '#379a37', '#bb8a35', '#516aec', '#7b59c0', '#159393', '#f7f3f7']"
