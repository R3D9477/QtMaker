#!/bin/bash

source ./setEnv.sh

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

pushd "$CACHE"

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

function mk_inst() {
    if cd $1*; then
        if [ -f "./autogen.sh" ]; then
            CFG="./autogen.sh"
        elif [ -f "./configure" ]; then
            CFG="./configure"
        else
            CFG="$SDK_PATH_TARGET$Qt_DIR/bin/qmake"
        fi
        if [[ "$PWD" =~ "qt" ]]; then
            rm "config.log"
            rm "config.cache"
        fi
        echo "${CFG} ${@:2}"
        if eval "${CFG} ${@:2}"; then
            unset Qt_AC
            if [ "$Qt_ACCEPT_CONFIG" == "y" ] || [ "$Qt_ACCEPT_CONFIG" == "n" ]; then
                Qt_AC="$Qt_ACCEPT_CONFIG"
            else
                read -p "ACCEPT Qt CONFIG? (y/Y/n): " Qt_AC
                if [ "Qt_AC" == "Y" ] ; then
                    export $Qt_ACCEPT_CONFIG="y"
                fi
            fi
            if [ "$Qt_AC" == "y" ] || [ "$Qt_AC" == "Y" ]; then
                ERR=0
                if [[ "$PWD" =~ "qt" ]]; then
                    if ! eval "make $NJ"; then
                        ERR=1
                    fi
                fi
                if [ $ERR == 0 ]; then
                    if eval "$SU make $NJ install"; then
                        cd ..
                        return 0
                    fi
                fi
            fi
        fi
        cd ..
    fi
    echo ""
    echo "mk_inst FAILED: $1"
    echo ""
    exit 1
}

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

if [ ! -f "qtbase/mkspecs/devices/linux-imx6-g++/imx6-qmake.conf" ]; then
    echo "FIX: imx6_qmake.conf"
    
    mv "qtbase/mkspecs/devices/linux-imx6-g++/qmake.conf" "qtbase/mkspecs/devices/linux-imx6-g++/imx6-qmake.conf"
    echo "include(./imx6-qmake.conf)" > "qtbase/mkspecs/devices/linux-imx6-g++/qmake.conf"
    echo "QMAKE_RPATHDIR += $SDK_PATH_TARGET/lib/arm-linux-gnueabihf" >> "qtbase/mkspecs/devices/linux-imx6-g++/qmake.conf"
    echo "QMAKE_RPATHDIR += $SDK_PATH_TARGET/usr/lib/arm-linux-gnueabihf" >> "qtbase/mkspecs/devices/linux-imx6-g++/qmake.conf"
fi

mk_inst qtbase                                          \
    -opensource -confirm-license                        \
    -developer-build                                    \
    -device imx6                                        \
    -device-option CROSS_COMPILE="$TOOLCHAIN_PREFIX"    \
    -sysroot "$SDK_PATH_TARGET"                         \
    -prefix "$Qt_DIR"                                   \
    -nomake tools                                       \
    -nomake tests                                       \
    -nomake examples                                    \
    -no-use-gold-linker                                 \
    -recheck                                            \
    -verbose                                            \
    -qt-zlib                                            \
    -opengl es2

mk_inst qtmultimedia

mk_inst qtdeclarative
mk_inst qtquickcontrols2

mk_inst qtserialport

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

popd

exit 0
