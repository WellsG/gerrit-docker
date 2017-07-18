#!/usr/bin/env bash
set -e

su - ${GERRIT_USER} ${GERRIT_HOME}/bin/gerrit.sh start

exec "$@";
