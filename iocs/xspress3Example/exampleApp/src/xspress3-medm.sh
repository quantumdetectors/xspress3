#!/bin/bash

prefix=$(XSPRESS3_PREFIX)

declare -A locations
locations[XSPRESS3]=$(EPICS_BASE)
locations[AREA_DETECTOR]=$(EPICS_BASE)
locations[DEVIOCSTATS]=$(EPICS_BASE)
locations[ASYN]=$(EPICS_BASE)
locations[SPECTRAPLUGINS]=$(EPICS_BASE)

# Default edl display locations in source tree
declare -A adls
adls[XSPRESS3]=op/adl/xspress3.adl
adls[AREA_DETECTOR]=op/adl/ADBase.adl
adls[DEVIOCSTATS]=op/adl/ioc_stats_soft.adl
adls[ASYN]=op/adl/asynRecord.adl
adls[SPECTRAPLUGINS]=op/adl/NDAttribute.adl

# The $ escapes the MSI macro substitution
for module in "\${!locations[@]}" ; do
    if [ -f \${locations[\$module]}/data/\$(basename \${adls[\$module]}) ] ; then
        EPICS_DISPLAY_PATH=\$EPICS_DISPLAY_PATH:\${locations[\$module]}/data
    else
        EPICS_DISPLAY_PATH=\$EPICS_DISPLAY_PATH:\${locations[\$module]}/\$(dirname \${adls[\$module]})
    fi
done

EPICS_DISPLAY_PATH=\${EPICS_DISPLAY_PATH#:}
export EPICS_DISPLAY_PATH

medm -x -macro "P=\$prefix" xspress3.adl &
medm -x -macro "ioc=\$prefix" ioc_stats_soft.adl &
echo \$EPICS_DISPLAY_PATH
