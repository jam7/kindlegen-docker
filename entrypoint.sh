#!/bin/sh

# This is the entrypoint script for the dockerfile. Executed in the
# container at runtime.  Based on dockcross.

if [[ $# == 0 ]]; then
    # Presumably the image has been run directly, so help the user get
    # started by outputting the dockcross script
    cat /kindlegen/kindlegen.sh
    exit 0
fi

# If we are running docker natively, we want to create a user in the container
# with the same UID and GID as the user on the host machine, so that any files
# created are owned by that user. Without this they are all owned by root.
# The dockcross script sets the KINDLEGEN_UID and KINDLEGEN_GID vars.
if [[ -n "$KINDLEGEN_UID" ]] && [[ -n "$KINDLEGEN_GID" ]] && [[ -n "$KINDLEGEN_GROUP" ]]; then

    addgroup -g $KINDLEGEN_GID $KINDLEGEN_GROUP
    adduser -g "" -D -G $KINDLEGEN_GROUP -u $KINDLEGEN_UID $KINDLEGEN_USER
    export HOME=/home/${KINDLEGEN_USER}
    chown -R $KINDLEGEN_UID:$KINDLEGEN_GID $HOME

    # Enable passwordless sudo capabilities for the user
    chown root:$KINDLEGEN_GID $(which su-exec)
    chmod +s $(which su-exec); sync

    # Run the command as the specified user/group.
    exec su-exec $KINDLEGEN_UID:$KINDLEGEN_GID "$@"
else
    # Just run the command as root.
    exec "$@"
fi
