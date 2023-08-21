#!/bin/bash

set -o nounset	# set -u

: "${IWYU:=iwyu}"
if ! command -v "${IWYU}" &> /dev/null
then
    echo "iwyu command not found in PATH. You can specify an alternate location with IWYU=/path/to/iwyu."
    exit 1
fi

if [ ! -f config.h ]; then
	echo "config.h is missing"
	exit 1
fi

if [ ! -f hcache/hcversion.h ]; then
	echo "hcache/hcversion.h is missing"
	exit 1
fi

OPTS=()
OPTS+=("-D_ALL_SOURCE=1")
OPTS+=("-D_GNU_SOURCE=1")
OPTS+=("-D__EXTENSIONS__")
OPTS+=("-DNCURSES_WIDECHAR")
OPTS+=("-DDEBUG")
OPTS+=("-I .")
OPTS+=("-I /usr/include/qdbm")
OPTS+=("-I /usr/lib/gcc/x86_64-redhat-linux/13/include")
OPTS+=("-Xiwyu --pch_in_code")
OPTS+=("-Xiwyu --no_comments")

COMMON_OPTS="${OPTS[@]}"
BASE_DIR="${0%bin/*}"
BASE_DIR="${BASE_DIR%/}"

for i in "$@"; do
	case "$i" in
		address/*.[ch])    source "$BASE_DIR/bin/i-address"   "$i";;
		alias/*.[ch])      source "$BASE_DIR/bin/i-alias"     "$i";;
		attach/*.[ch])     source "$BASE_DIR/bin/i-attach"    "$i";;
		autocrypt/*.[ch])  source "$BASE_DIR/bin/i-autocrypt" "$i";;
		bcache/*.[ch])     source "$BASE_DIR/bin/i-bcache"    "$i";;
		browser/*.[ch])    source "$BASE_DIR/bin/i-browser"   "$i";;
		color/*.[ch])      source "$BASE_DIR/bin/i-color"     "$i";;
		complete/*.[ch])   source "$BASE_DIR/bin/i-complete"  "$i";;
		compmbox/*.[ch])   source "$BASE_DIR/bin/i-compmbox"  "$i";;
		compose/*.[ch])    source "$BASE_DIR/bin/i-compose"   "$i";;
		compress/*.[ch])   source "$BASE_DIR/bin/i-compress"  "$i";;
		config/*.[ch])     source "$BASE_DIR/bin/i-config"    "$i";;
		conn/*.[ch])       source "$BASE_DIR/bin/i-conn"      "$i";;
		convert/*.[ch])    source "$BASE_DIR/bin/i-convert"   "$i";;
		core/*.[ch])       source "$BASE_DIR/bin/i-core"      "$i";;
		debug/*.[ch])      source "$BASE_DIR/bin/i-debug"     "$i";;
		email/*.[ch])      source "$BASE_DIR/bin/i-email"     "$i";;
		enter/*.[ch])      source "$BASE_DIR/bin/i-enter"     "$i";;
		envelope/*.[ch])   source "$BASE_DIR/bin/i-envelope"  "$i";;
		expando/*.[ch])    source "$BASE_DIR/bin/i-expando"   "$i";;
		gui/*.[ch])        source "$BASE_DIR/bin/i-gui"       "$i";;
		hcache/*.[ch])     source "$BASE_DIR/bin/i-hcache"    "$i";;
		helpbar/*.[ch])    source "$BASE_DIR/bin/i-helpbar"   "$i";;
		history/*.[ch])    source "$BASE_DIR/bin/i-history"   "$i";;
		imap/*.[ch])       source "$BASE_DIR/bin/i-imap"      "$i";;
		index/*.[ch])      source "$BASE_DIR/bin/i-index"     "$i";;
		maildir/*.[ch])    source "$BASE_DIR/bin/i-maildir"   "$i";;
		mbox/*.[ch])       source "$BASE_DIR/bin/i-mbox"      "$i";;
		menu/*.[ch])       source "$BASE_DIR/bin/i-menu"      "$i";;
		mixmaster/*.[ch])  source "$BASE_DIR/bin/i-mixmaster" "$i";;
		mutt/*.[ch])       source "$BASE_DIR/bin/i-mutt"      "$i";;
		ncrypt/*.[ch])     source "$BASE_DIR/bin/i-ncrypt"    "$i";;
		nntp/*.[ch])       source "$BASE_DIR/bin/i-nntp"      "$i";;
		notmuch/*.[ch])    source "$BASE_DIR/bin/i-notmuch"   "$i";;
		pager/*.[ch])      source "$BASE_DIR/bin/i-pager"     "$i";;
		parse/*.[ch])      source "$BASE_DIR/bin/i-parse"     "$i";;
		pattern/*.[ch])    source "$BASE_DIR/bin/i-pattern"   "$i";;
		pop/*.[ch])        source "$BASE_DIR/bin/i-pop"       "$i";;
		postpone/*.[ch])   source "$BASE_DIR/bin/i-postpone"  "$i";;
		progress/*.[ch])   source "$BASE_DIR/bin/i-progress"  "$i";;
		question/*.[ch])   source "$BASE_DIR/bin/i-question"  "$i";;
		send/*.[ch])       source "$BASE_DIR/bin/i-send"      "$i";;
		sidebar/*.[ch])    source "$BASE_DIR/bin/i-sidebar"   "$i";;
		store/*.[ch])      source "$BASE_DIR/bin/i-store"     "$i";;
		*.[ch])            source "$BASE_DIR/bin/i-main"      "$i";;
		*)                 echo "unknown: $i";;
	esac
done

