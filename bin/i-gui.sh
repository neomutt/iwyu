#!/bin/bash

BASE_DIR="${0%bin/*}"

for i in "$@"; do
	[ "$i" = "mutt_curses.h" ] && continue

	iwyu \
		-D_ALL_SOURCE=1 \
		-D_GNU_SOURCE=1 \
		-D__EXTENSIONS__ \
		-DNCURSES_WIDECHAR \
		-DDEBUG \
		-DUSE_INOTIFY \
		-I . \
		-I gui \
		-I /usr/lib/gcc/x86_64-redhat-linux/13/include \
		-I /usr/include/qdbm \
		-Xiwyu --mapping_file="$BASE_DIR/imp/gui.imp" \
		-Xiwyu --no_comments \
		-Xiwyu --pch_in_code \
		"$i"
done

