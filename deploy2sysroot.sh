#!/bin/bash

source ./setEnv.sh

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

function deploy() {
    if [ ! -d "$Qt_EXPORT" ]; then
       echo " EXPORT $Qt_EXPORT DOESN'T EXIST"
       return 1
    fi
    
    if [ ! -d "$SYSROOT$Qt_DIR" ] ; then
       echo " DEST $SYSROOT$Qt_DIR DOESN'T EXIST"
       return 2
    fi
    
    if ! eval "$SU cp -r \"$Qt_EXPORT\" \"$SYSROOT$Qt_DIR/\" " ; then
       echo " FIALED TO COPY EXPORT"
       return 3
    fi
    
    return 0
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
