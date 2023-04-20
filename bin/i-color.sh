#!/bin/bash

BASE_DIR="${0%bin/*}"

for i in "$@"; do
	iwyu \
		-D_ALL_SOURCE=1 \
		-D_GNU_SOURCE=1 \
		-D__EXTENSIONS__ \
		-DNCURSES_WIDECHAR \
		-DDEBUG \
		-DUSE_DEBUG_COLOR \
		-I . \
		-I color \
		-I /usr/lib/gcc/x86_64-redhat-linux/13/include \
		-Xiwyu --mapping_file="$BASE_DIR/imp/color.imp" \
		-Xiwyu --no_comments \
		-Xiwyu --pch_in_code \
		"$i"
done
