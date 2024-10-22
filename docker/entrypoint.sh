#!/bin/bash -e

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback

USER_UID=${LOCAL_UID:-1000}
USER_NAME=${LOCAL_USER_NAME:-buildbazel}
USER_HOME=${LOCAL_USER_HOME:-"/home/${USER_NAME}"}

echo "Starting this stuff (${*}) with user: $USER_UID $USER_NAME $USER_HOME"
echo "User Home = $USER_HOME"

usermod -l "$USER_NAME" -u "$USER_UID" -md "$USER_HOME"  "$DEFAULT_USER_NAME" || :

chown "$USER_NAME" "$USER_HOME"

export HOME="${USER_HOME}"

echo "Home = $HOME"

exec /usr/sbin/gosu "${USER_NAME}" "$@"
