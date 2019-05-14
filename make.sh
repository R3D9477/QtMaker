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
    echo "    QtMaker: UNABLE TO COMPILE AND(OR) INSTALL $1"
    echo ""
    
    return 1
}

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

if [ "$Qt_DEVICE" == "imx6" ] || [ "$Qt_DEVICE" == "linux-imx6-g++" ] ; then
    if [ ! -f "qtbase/mkspecs/devices/linux-imx6-g++/imx6-qmake.conf" ]; then
        echo "FIX: imx6_qmake.conf"
        
        mv "qtbase/mkspecs/devices/linux-imx6-g++/qmake.conf" "qtbase/mkspecs/devices/linux-imx6-g++/imx6-qmake.conf"
        echo "include(./imx6-qmake.conf)" > "qtbase/mkspecs/devices/linux-imx6-g++/qmake.conf"
        echo "QMAKE_RPATHDIR += $SDK_PATH_TARGET/lib/arm-linux-gnueabihf" >> "qtbase/mkspecs/devices/linux-imx6-g++/qmake.conf"
        echo "QMAKE_RPATHDIR += $SDK_PATH_TARGET/usr/lib/arm-linux-gnueabihf" >> "qtbase/mkspecs/devices/linux-imx6-g++/qmake.conf"
    fi
fi

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

if ! mk_inst qtbase                                         \
        -opensource -confirm-license                        \
        -developer-build                                    \
        -device "$Qt_DEVICE"                                \
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
        -opengl es2 ; then exit 1; fi

if ! mk_inst qtmultimedia ; then exit 2; fi

if ! mk_inst qtdeclarative ; then exit 3; fi
if ! mk_inst qtquickcontrols2 ; then exit 4; fi

if ! mk_inst qtserialport ; then exit 5; fi

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

popd

echo ""
echo "    QtMaker: Qt $Qt_VER libs were successfully built"
echo ""

exit 0
