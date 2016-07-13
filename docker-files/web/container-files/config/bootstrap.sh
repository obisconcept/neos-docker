#!/bin/bash

set -e
set -u

source /config/variables.sh
source /config/functions.sh

if [ "$(ls /config/init/)" ]; then
  for init in /config/init/*.sh; do
    . $init
  done
fi

# We have TTY, so probably an interactive container...
if test -t 0; then
  supervisord

  if [[ $@ ]]; then
    eval $@
  else
    export PS1='[\u@\h : \w]\$ '
    /bin/bash
  fi
else
  if [[ $@ ]]; then
    eval $@
  fi

  supervisord
fi