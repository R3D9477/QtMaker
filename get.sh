#!/bin/bash

source ./setEnv.sh

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

function getq() {
    
    cd "$CACHE"
    
    if [ -d "$1" ]; then
        cd "$1"
        git submodule foreach --recursive "git clean -dfx"
        git clean -dfx
        git submodule foreach --recursive "git reset --hard"
        git reset --hard
        if git checkout "$Qt_VER"; then
            cd "$CACHE"
            return 0
        fi
    else
        if [ -f "$1_$Qt_VER.tar" ]; then
            if tar -xf "$1_$Qt_VER.tar"; then
                return 0
            fi
        elif git clone "git://code.qt.io/qt/$1.git"; then
            cd "$1"
            if git checkout "$Qt_VER"; then
                git submodule update --init --recursive
                if git checkout "$Qt_VER"; then
                    cd "$CACHE"
                    tar -cf "$1_$Qt_VER.tar" "$1"
                    return 0
                fi
            fi
        fi
    fi
    
    cd "$CACHE"
    
    echo ""
    echo "    QtMaker: DOWNLOADING OF $1 WAS FAILED"
    echo ""
    
    return 1
}

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

if ! getq "qtbase" ;           then exit 1 ; fi
if ! getq "qtmultimedia" ;     then exit 2 ; fi
if ! getq "qtdeclarative" ;    then exit 3 ; fi
if ! getq "qtquickcontrols2" ; then exit 4 ; fi
if ! getq "qtserialport" ;     then exit 5 ; fi

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

echo ""
echo "    QtMaker: Qt $Qt_VER libs were sucessfully got"
echo ""

exit 0