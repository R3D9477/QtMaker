#!/bin/bash

source ./setEnv.sh

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

if [ ! -d "$QT_SDK" ]; then
    if ! cp -r "$SYSROOT/$Qt_DIR" "$QT_SDK"; then
        
        echo ""
        echo "    QtMaker: UNABLE TO CREATE Qt $Qt_VER SDK"
        echo ""
        
        exit 1
    fi
fi

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

echo ""
echo "    QtMaker: Qt $Qt_VER SDK was placed to $QT_SDK"
echo ""

exit 0