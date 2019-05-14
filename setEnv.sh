if [ -z "$CACHE" ]; then
    read -p "CACHE: " CACHE
    if [ -z "$CACHE" ] ; then
        CACHE=$(realpath "cache")
    fi
    export CACHE
fi

if [ ! -d "$CACHE" ] ; then
    mkdir "$CACHE"
fi

if [ -z "$SYSROOT" ]; then
    read -p "SYSROOT: " SYSROOT
    if [ -z "$SYSROOT" ] ; then
        SYSROOT=$(realpath "sysroot")
    fi
    export SYSROOT
fi

if [ ! -d "$SYSROOT" ] ; then
    mkdir "$SYSROOT"
fi

if [ -z "$SU" ]; then
    if [ -z "$PASS" ]; then
        read -s -p "PASSWORD: " PASS
        echo ""
    fi
    export SU="echo $PASS | sudo -S"
fi

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

if [ -z "$Qt_VER" ]; then
    read -p "Qt VERSION: " Qt_VER
    if [ -z "$Qt_VER" ] ; then
        Qt_VER="5.9"
    fi
    export Qt_VER
fi

if [ -z "$Qt_DIR" ]; then
    read -p "Qt DIR: " Qt_DIR
    if [ -z "$Qt_DIR" ] ; then
        Qt_DIR="/opt/Qt$Qt_VER"
    fi
    export Qt_DIR
fi

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

if [ -z "$Qt_DEVICE" ]; then
    read -p "Qt DEVICE: " Qt_DEVICE
    if [ -z "$Qt_DEVICE" ] ; then
        Qt_DEVICE="generic"
    fi
    export Qt_DEVICE
fi

if [ -z "$ARCH" ]; then
    read -p "Qt ARCH: " Qt_ARCH
    if [ -z "$Qt_ARCH" ] ; then
        Qt_ARCH=$(uname -i)
    fi
    export Qt_ARCH
else
    export Qt_ARCH=$ARCH
fi

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

if [ -z "$Qt_ACCEPT_CONFIG" ]; then
    read -p "ACCEPT Qt CONFIG? (y/n/a): " Qt_ACCEPT_CONFIG
    if [ -z "$Qt_ACCEPT_CONFIG" ] ; then
        Qt_ACCEPT_CONFIG="a"
    fi
    export Qt_ACCEPT_CONFIG
fi

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

if [ -z "$Qt_TEST" ]; then
    read -p "Qt TEST: " Qt_TEST
    if [ -z "$Qt_TEST" ] ; then
        Qt_TEST=$(realpath "test")
    fi
    export Qt_TEST
fi

if [ -z "$Qt_EXPORT" ]; then
    read -p "Qt EXPORT: " Qt_EXPORT
    if [ -z "$Qt_EXPORT" ] ; then
        Qt_EXPORT="$CACHE/qtest_$(date '+%Y%m%d%H%M%S')"
    fi
    export Qt_EXPORT
fi

if [ ! -d "$Qt_EXPORT" ] ; then
    mkdir -p "$Qt_EXPORT"
fi

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

if [ -z "$Qt_SDK" ]; then
    read -p "Qt SDK: " Qt_SDK
    if [ -z "$Qt_SDK" ] ; then
        if [ -z "" ]
        Qt_SDK="$CACHE/Qt${Qt_VER}_${Qt_DEVICE}-${Qt_ARCH}_SDK"
    fi
    export Qt_SDK
fi