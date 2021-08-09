#!/bin/sh

CMD="/opt/kindlegen/kindlegen"
TTY=""

case .$1 in
.*sh|.*bash) CMD=""; TTY="-ti";;
esac

exec docker run $TTY --rm \
    -v "$PWD":/work \
    -e KINDLEGEN_UID="$( id -u )" \
    -e KINDLEGEN_GID="$( id -g )" \
    -e KINDLEGEN_USER="$( id -un )" \
    -e KINDLEGEN_GROUP="$( id -gn )" \
    jam7/kindlegen "$CMD" "$@"
