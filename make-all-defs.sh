#!/bin/bash

if [ ! -z "$CACHE" ] && [ ! -z "$SYSROOT" ] ; then
    
    export Qt_VER="5.9"
    export Qt_DIR="/opt/Qt$Qt_VER"
    export Qt_ACCEPT_CONFIG="a"
    export Qt_TEST=$(realpath "test")
    export Qt_EXPORT="$CACHE/qtest_$(date '+%Y%m%d%H%M%S')"
    
fi

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

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
    return 1
}

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

if ! bash get.sh; then
    echo "Qt FAILED: get"
    exit 1
fi

if ! bash make.sh; then
    echo "Qt FAILED: make"
    exit 1
fi

if ! qbuild "$Qt_TEST/qt_c"; then
    echo "Qt FAILED: qbuild test apps (Console App)"
    exit 1
fi

if ! qbuild "$Qt_TEST/qt_w"; then
    echo "Qt FAILED: qbuild test apps (Widgets App)"
    exit 1
fi

if ! qbuild "$Qt_TEST/qt_qc"; then
    echo "Qt FAILED: qbuild test apps (Quick Controls App)"
    exit 1
fi

if ! bash export.sh; then
    echo "Qt FAILED: export"
    exit 1
fi

if ! bash deploy2sysroot.sh; then
    echo "Qt FAILED: deploy2sysroot"
    exit 1
fi

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

exit 0
