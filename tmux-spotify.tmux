#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PATH="/usr/local/bin:$PATH:/usr/sbin"

main() {
default_binding_key="S-s"  # Shift + S default to show the menu
binding_option="@spotifybinding"

get_tmux_option() {
	local option="$1"
	local default_value="$2"
	local option_value=$(tmux show-option -gqv "$option")
	if [ -z "$option_value" ]; then
		echo "$default_value"
	else
		echo "$option_value"
	fi
}

main() {
	local key_bindings=$(get_tmux_option "$binding_option" "$default_binding_key")
	local key

	for key in $key_bindings; do
    tmux bind-key -T popup "$key" run -b "source $CURRENT_DIR/scripts/spotify.sh && show_menu"
  done
}

main
