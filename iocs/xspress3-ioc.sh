#/bin/bash
EPICS_HOST_ARCH=`/usr/lib/epics/lib/host`
if [ -z "$XSPRESS3_CHANNELS" ]; then
    XSPRESS3_CHANNELS=1
fi

# Use mini specific IOCs
if [[ $XSPRESS3_MINI -eq 1 ]]; then
    XSPRESS3_MINI_PREFIX=Mini
fi

# Can use the default ones for n chans < 3 (single card)
if [[ $XSPRESS3_CHANNELS -lt 3 && $XSPRESS3_MINI -eq 1 ]]; then
	XSPRESS3_MINI_PREFIX=
fi

rm -rf /dev/shm/xsp*
/usr/lib/epics/iocBoot/xspress3/example${XSPRESS3_CHANNELS}Channel${XSPRESS3_MINI_PREFIX}/bin/${EPICS_HOST_ARCH}/stexample${XSPRESS3_CHANNELS}Channel.sh
