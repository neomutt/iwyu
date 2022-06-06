#!/bin/bash

BASE_DIR="${0%bin/*}"

for i in "$@"; do
	iwyu \
		-D_ALL_SOURCE=1 \
		-D_GNU_SOURCE=1 \
		-D__EXTENSIONS__ \
		-DNCURSES_WIDECHAR \
		-DDEBUG \
		-I . \
		-I hcache \
		-I /usr/lib/gcc/x86_64-redhat-linux/12/include \
		-I /usr/include/qdbm \
		-Xiwyu --pch_in_code \
		-Xiwyu --no_comments \
		-Xiwyu --mapping_file="$BASE_DIR/imp/hcache.imp" \
		"$i"
done

