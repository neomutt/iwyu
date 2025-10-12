#!/usr/bin/env bash

set -o nounset # set -u

: "${IWYU:=iwyu}"
if ! command -v "${IWYU}" &>/dev/null; then
    echo "iwyu command not found in PATH. You can specify an alternate location with IWYU=/path/to/iwyu"
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

if [ ! -f compile_commands.json ]; then
    echo "compile_commands.json is missing"
    exit 1
fi

# here be dragons ;-)
COMPILE_OPTS=$(grep -w "main.c" compile_commands.json | sed 's/\(.*\),/[\1]/' | jq -r '.[].arguments as $args | $args | map(.=="-D" or .=="-I") | indices(true) | map($args[.] + " " + $args[.+1]) | sort | unique | join(" ")')
IWYU_OPTS="-Xiwyu --pch_in_code -Xiwyu --no_comments"

BASE_DIR="${0%bin/*}"
BASE_DIR="${BASE_DIR%/}"

for i in "$@"; do
    [ -f "$i" ] || continue
    MAPPING=""
    case "$i" in
        address/*.[ch]) MAPPING="address.imp" ;;
        alias/*.[ch]) MAPPING="alias.imp" ;;
        attach/*.[ch]) MAPPING="attach.imp" ;;
        autocrypt/*.[ch]) MAPPING="autocrypt.imp" ;;
        bcache/*.[ch]) MAPPING="bcache.imp" ;;
        browser/*.[ch]) MAPPING="browser.imp" ;;
        cli/*.[ch]) MAPPING="cli.imp" ;;
        color/*.[ch]) MAPPING="color.imp" ;;
        complete/*.[ch]) MAPPING="complete.imp" ;;
        compmbox/*.[ch]) MAPPING="compmbox.imp" ;;
        compose/*.[ch]) MAPPING="compose.imp" ;;
        compress/*.[ch]) MAPPING="compress.imp" ;;
        config/*.[ch]) MAPPING="config.imp" ;;
        conn/*.[ch]) MAPPING="conn.imp" ;;
        convert/*.[ch]) MAPPING="convert.imp" ;;
        core/*.[ch]) MAPPING="core.imp" ;;
        debug/*.[ch]) MAPPING="debug.imp" ;;
        editor/*.[ch]) MAPPING="editor.imp" ;;
        email/*.[ch]) MAPPING="email.imp" ;;
        envelope/*.[ch]) MAPPING="envelope.imp" ;;
        expando/*.[ch]) MAPPING="expando.imp" ;;
        gui/*.[ch]) MAPPING="gui.imp" ;;
        hcache/*.[ch]) MAPPING="hcache.imp" ;;
        helpbar/*.[ch]) MAPPING="helpbar.imp" ;;
        history/*.[ch]) MAPPING="history.imp" ;;
        imap/*.[ch]) MAPPING="imap.imp" ;;
        index/*.[ch]) MAPPING="index.imp" ;;
        key/*.[ch]) MAPPING="key.imp" ;;
        maildir/*.[ch]) MAPPING="maildir.imp" ;;
        mbox/*.[ch]) MAPPING="mbox.imp" ;;
        menu/*.[ch]) MAPPING="menu.imp" ;;
        mh/*.[ch]) MAPPING="mh.imp" ;;
        mutt/*.[ch]) MAPPING="mutt.imp" ;;
        ncrypt/*.[ch]) MAPPING="ncrypt.imp" ;;
        nntp/*.[ch]) MAPPING="nntp.imp" ;;
        notmuch/*.[ch]) MAPPING="notmuch.imp" ;;
        pager/*.[ch]) MAPPING="pager.imp" ;;
        parse/*.[ch]) MAPPING="parse.imp" ;;
        pattern/*.[ch]) MAPPING="pattern.imp" ;;
        pfile/*.[ch]) MAPPING="pfile.imp" ;;
        pop/*.[ch]) MAPPING="pop.imp" ;;
        postpone/*.[ch]) MAPPING="postpone.imp" ;;
        progress/*.[ch]) MAPPING="progress.imp" ;;
        question/*.[ch]) MAPPING="question.imp" ;;
        send/*.[ch]) MAPPING="send.imp" ;;
        sidebar/*.[ch]) MAPPING="sidebar.imp" ;;
        spager/*.[ch]) MAPPING="spager.imp" ;;
        store/*.[ch]) MAPPING="store.imp" ;;
        *.[ch]) MAPPING="neomutt.imp" ;;
        *) echo "unknown: $i" ;;
    esac
    $IWYU $COMPILE_OPTS $IWYU_OPTS -Xiwyu --mapping_file="$BASE_DIR/imp/$MAPPING" "$i"
done
