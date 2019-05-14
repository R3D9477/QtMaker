#!/bin/bash

if [ -z "$CACHE" ] ; then
    
    echo ""
    echo "    QtMaker: CACHE CAN'T BE EMPTY!"
    echo ""
    
    exit 1
fi

if [ -z "$SYSROOT" ] ; then
    
    echo ""
    echo "    QtMaker: SYSROOT CAN'T BE EMPTY!"
    echo ""
    
    exit 2
fi

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

export Qt_VER="5.9"
export Qt_DIR="/opt/Qt$Qt_VER"
export Qt_DEVICE="imx6"
export Qt_ACCEPT_CONFIG="a"
export Qt_TEST=$(realpath "test")
export Qt_EXPORT="$CACHE/qtest_$(date '+%Y%m%d%H%M%S')"
export Qt_SDK="$CACHE/Qt${Qt_VER}_SDK"

source ./setEnv.sh

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

if ! bash get.sh            ; then exit 3; fi
if ! bash make.sh           ; then exit 4; fi
if ! bash export.sh         ; then exit 5; fi
if ! bash deploy2sysroot.sh ; then exit 6; fi
if ! bash createSDK.sh      ; then exit 7; fi

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

echo ""
echo "    QtMaker: Qt $Qt_VER was sucessfully installed"
echo ""

exit 0
