#!/bin/bash

#----------------
# Name          : logs.bash
# Description   : Library of functions for printing info logs in verbose mode
#----------------

source ./utilities/time.bash
source ./constants/defaults.bash

log_arguments() {
  echo "FUNCTION: $@" >&2
}

