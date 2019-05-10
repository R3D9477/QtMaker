#!/bin/bash

source ./setEnv.sh

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

if [ -z "$MNTPOINT" ]; then
    export MNTPOINT="/media/$USER/$(blkid -o value -s UUID $Qt_DEVICE)"
fi

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

function deploy() {
    if [ -d "$MNTPOINT" ]; then
        eval "$SU umount $MNTPOINT" 2> /dev/null
    else
        mkdir -p "$MNTPOINT"
    fi
    if eval "$SU mount $Qt_DEVICE $MNTPOINT"; then
        rm -rf "$MNTPOINT/ta_"*
        if rsync -a -r "$Qt_EXPORT" "$MNTPOINT/"; then
            sleep 1s
            if eval "$SU umount $MNTPOINT"; then
                rm -rf "$MNTPOINT"
                return 0
            fi
        fi
        if eval "$SU umount $MNTPOINT"; then
            rm -rf "$MNTPOINT"
        fi
    fi
    return 1
}

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

if deploy; then
    echo "DEPLOYED: $(basename $Qt_EXPORT)"
    exit 0
else
    echo "FAILED DEPLOYMENT: $(basename $Qt_EXPORT)"
fi

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

exit 1
