#!/bin/bash

FDIR=$(dirname $(readlink ${0})) >/dev/null 2>&1 || FDIR=$(dirname ${0})

source ${FDIR}/secops/secops-alias.sh
source ${FDIR}/voices/voices-alias.sh
