#!/bin/bash
export EPICS_BASE="/usr/lib/epics"
export EPICS_HOST_ARCH=`${EPICS_BASE}/startup/EpicsHostArch`

export EPICS_CA_AUTO_ADDR_LIST=NO
export EPICS_CA_ADDR_LIST=localhost
export EPICS_CAS_INTF_ADDR_LIST=localhost
