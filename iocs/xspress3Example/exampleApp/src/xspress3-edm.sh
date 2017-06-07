#!/bin/bash

prefix=$(XSPRESS3_PREFIX)
EPICS_CA_SERVER_PORT=5064
EPICS_CA_REPEATER_PORT=5065

declare -A locations
locations[XSPRESS3]=$(EPICS_BASE)
locations[AREA_DETECTOR]=$(EPICS_BASE)
locations[DEVIOCSTATS]=$(EPICS_BASE)
locations[ASYN]=$(EPICS_BASE)
locations[SPECTRAPLUGINS]=$(EPICS_BASE)

# Default edl display locations in source tree
declare -A edls
edls[XSPRESS3]=op/edl/xspress3.edl
edls[AREA_DETECTOR]=op/edl/ADBase.edl
edls[DEVIOCSTATS]=op/edl/ioc_stats_soft.edl
edls[ASYN]=op/edl/asynRecord.edl
edls[SPECTRAPLUGINS]=op/edl/NDAttribute.edl

# The $ escapes the MSI macro substitution
for module in "\${!locations[@]}" ; do
    if [ -f \${locations[\$module]}/data/\$(basename \${edls[\$module]}) ] ; then
        EDMDATAFILES=\$EDMDATAFILES:\${locations[\$module]}/data/
    else
        EDMDATAFILES=\$EDMDATAFILES:\${locations[\$module]}/\$(dirname \${edls[\$module]})
    fi
done
export EDMDATAFILES
export EPICS_CA_MAX_ARRAY_BYTES=6000000

edm -x -m "P=\$prefix" -port \$EPICS_CA_SERVER_PORT xspress3.edl &
edm -x -m "ioc=\$prefix" -port \$EPICS_CA_SERVER_PORT ioc_stats_soft.edl &
echo \$EDMDATAFILES
