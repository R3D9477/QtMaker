#!/bin/bash

source ./setEnv.sh

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

if [ ! -d "$Qt_SDK" ]; then
    if ! cp -r "$SYSROOT/$Qt_DIR" "$Qt_SDK"; then
        
        echo ""
        echo "    QtMaker: UNABLE TO CREATE Qt $Qt_VER SDK"
        echo ""
        
        exit 1
    fi
fi

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

echo ""
echo "    QtMaker: Qt $Qt_VER SDK was placed to $Qt_SDK"
echo ""

exit 0
