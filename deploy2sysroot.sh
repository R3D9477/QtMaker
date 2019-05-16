#!/bin/bash

source ./setEnv.sh

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

function deploy() {
    
    if [ ! -d "$Qt_EXPORT" ]; then
        
        echo ""
        echo "    QtMaker: DIRECTORY $Qt_EXPORT DOESN'T EXIST"
        echo ""
        
        return 1
    fi
    
    if [ ! -d "$SYSROOT$Qt_DIR" ] ; then
        
        echo ""
        echo "    QtMaker: DESTINATION $SYSROOT$Qt_DIR DOESN'T EXIST"
        echo ""
        
        return 2
    fi
    
    if ! eval "$SU cp -r \"$Qt_EXPORT\" \"$SYSROOT$Qt_DIR/\" " ; then
        
        echo ""
        echo "    QtMaker: UNABLE TO DEPLOY TEST APPS"
        echo ""
        
        return 3
    fi
    
    return 0
}

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

if ! deploy ; then exit 1 ; fi

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

echo ""
echo "    QtMaker: Qt $Qt_VER test apps were deployed to $Qt_EXPORT"
echo ""

exit 0
