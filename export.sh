#!/bin/bash

source ./setEnv.sh

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

function export_app() {
    APPDIR=$Qt_DIR/$(basename $Qt_EXPORT)
    
    if rsync -a -r "$Qt_TEST/$1/$1" "$Qt_EXPORT/" ; then
        if rsync -a -r "$Qt_TEST/launcher.sh" "$Qt_EXPORT/$1.sh" ; then
            sed -i "s/Qt_DIR=./Qt_DIR=${Qt_DIR//\//\\/}/g" "$Qt_EXPORT/$1.sh"
            sed -i "s/APPDIR=./APPDIR=${APPDIR//\//\\/}/g" "$Qt_EXPORT/$1.sh"
            
            echo "    EXPORTED: $(basename $Qt_EXPORT/$1)"
            
            return 0
        fi
    fi
    
    echo "    FAILED TO EXPORT $Qt_EXPORT/$1"
    return 1
}

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

export_app "qt_c"
export_app "qt_w"
export_app "qt_qc"

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

exit 0
