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
dconf write "${profile_path}/visible-name" "'Shapeshifter (light) '"
dconf write "${profile_path}/background-color" "'#f9f9f9'"
dconf write "${profile_path}/foreground-color" "'#102015'"
dconf write "${profile_path}/bold-color" "'#102015'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"

dconf write "${profile_path}/palette" "['#000000', '#e92f2f', '#0ed839', '#dddd13', '#3b48e3', '#f996e2', '#23edda', '#ababab', '#343434', '#e92f2f', '#0ed839', '#dddd13', '#3b48e3', '#f996e2', '#23edda', '#f9f9f9']"
