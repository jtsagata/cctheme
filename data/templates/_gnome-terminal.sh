#!/usr/bin/env bash

if [[ "$1" == "reset" ]]; then
    dconf reset -f /org/gnome/terminal/legacy/profiles:/
    exit
fi

dset() {
    local key="$1"; shift
    local val="$1"; shift

    if [[ "$type" == "string" ]]; then
        val="'$val'"
    fi

    dconf write "$PROFILE_KEY/$key" "$val"
}


profile=$(gsettings get org.gnome.Terminal.ProfilesList default)
profile_id=${profile:1:-1}

dconfdir=/org/gnome/terminal/legacy/profiles:
profile_path="$dconfdir/:$profile_id"

# update profile values with theme options
dconf write "${profile_path}/visible-name" "'{{ name }} '"
dconf write "${profile_path}/palette" "['#002b36', '#dc322f', '#859900', '#b58900', '#268bd2', '#6c71c4', '#2aa198', '#93a1a1', '#657b83', '#dc322f', '#859900', '#b58900', '#268bd2', '#6c71c4', '#2aa198', '#fdf6e3']"
dconf write "${profile_path}/background-color" "'{{ background }}'"
dconf write "${profile_path}/foreground-color" "'#586e75'"
dconf write "${profile_path}/bold-color" "'#586e75'"
dconf write "${profile_path}/bold-color-same-as-fg" "true"
dconf write "${profile_path}/use-theme-colors" "false"
dconf write "${profile_path}/use-theme-background" "false"
