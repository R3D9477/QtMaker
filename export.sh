#!/bin/bash

source ./setEnv.sh

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

function qbuild() {
    
    OPWD="$PWD"
    
    if cd "$1"; then
        if "$SYSROOT$Qt_DIR/bin/qmake" -spec "devices/linux-imx6-g++" CONFIG+=release; then
            make clean
            if make; then
                cd "$OPWD"
                return 0
            fi
        fi
        cd "$OPWD"
    fi
    
    echo ""
    echo "    QtMaker: UNABLE TO BUILD $1"
    echo ""
    
    return 1
}

function export_app() {
    
    APPDIR=$Qt_DIR/$(basename $Qt_EXPORT)
    
    if rsync -a -r "$Qt_TEST/$1/$1" "$Qt_EXPORT/" ; then
        if rsync -a -r "$Qt_TEST/launcher.sh" "$Qt_EXPORT/$1.sh" ; then
            sed -i "s/Qt_DIR=./Qt_DIR=${Qt_DIR//\//\\/}/g" "$Qt_EXPORT/$1.sh"
            sed -i "s/APPDIR=./APPDIR=${APPDIR//\//\\/}/g" "$Qt_EXPORT/$1.sh"
            return 0
        fi
    fi
    
    echo ""
    echo "    QtMaker: UNABLE TO EXPORT $1"
    echo ""
    
    return 1
}

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

if ! qbuild "$Qt_TEST/qt_c" ;  then exit 3; fi
if ! qbuild "$Qt_TEST/qt_w" ;  then exit 4; fi
if ! qbuild "$Qt_TEST/qt_qc" ; then exit 5; fi

if ! export_app "qt_c" ;  then exit 1; fi
if ! export_app "qt_w" ;  then exit 2; fi
if ! export_app "qt_qc" ; then exit 3; fi

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

echo ""
echo "    QtMaker: Qt $Qt_VER test apps were exported to $Qt_EXPORT"
echo ""

exit 0