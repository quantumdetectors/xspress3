#/bin/bash
EPICS_HOST_ARCH=`/usr/lib/epics/lib/host`
if [ -z "$XSPRESS3_CHANNELS" ]; then
    XSPRESS3_CHANNELS=1
fi

rm -rf /dev/shm/xsp*
/usr/lib/epics/iocBoot/xspress3/example${XSPRESS3_CHANNELS}Channel/bin/${EPICS_HOST_ARCH}/stexample${XSPRESS3_CHANNELS}Channel.sh
