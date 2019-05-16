#!/bin/bash

source ./setEnv.sh

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

if ! bash get.sh            ; then exit 3; fi
if ! bash make.sh           ; then exit 4; fi
if ! bash installFonts.sh   ; then exit 5; fi
if ! bash export.sh         ; then exit 6; fi
if ! bash deploy2sysroot.sh ; then exit 7; fi
if ! bash createSDK.sh      ; then exit 8; fi

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

echo ""
echo "    QtMaker: Qt $Qt_VER was sucessfully installed"
echo ""

exit 0
