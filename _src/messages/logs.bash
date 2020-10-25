#!/bin/bash

#----------------
# Name          : logs.bash
# Description   : Library of functions for printing info logs in verbose mode
#----------------

source ./utils/time.bash
source ./utils/constants.bash

log_arguments() {
  echo "FUNCTION: $@" >&2
}

