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

supervisord