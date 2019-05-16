#!/bin/bash

if ! pushd "$CACHE" ; then exit 1; fi

    if [ ! -d "dejavu-fonts-ttf-2.37" ] ; then
        wget -nc -O "dejavu-fonts-ttf-2.37.tar.bz2" "https://sourceforge.net/projects/dejavu/files/dejavu/2.37/dejavu-fonts-ttf-2.37.tar.bz2/download"
        if ! tar xjf "dejavu-fonts-ttf-2.37.tar.bz2" ; then
            
            echo ""
            echo "    QtMaker: UNABLE TO DOWNLOAD FONTS"
            echo ""
            
            exit 1
        fi
    fi

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

    if [ ! -d "$SYSROOT$Qt_DIR/lib/fonts" ] ; then
        cmd2root mkdir "$SYSROOT$Qt_DIR/lib/fonts"
    fi

    if ! cmd2root cp "dejavu-fonts-ttf-2.37/ttf/*" "$SYSROOT$Qt_DIR/lib/fonts/" ; then
        
        echo ""
        echo "    QtMaker: UNABLE TO INSTALL FONTS"
        echo ""
        
        exit 2 ;
    fi

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

popd

echo ""
echo "    QtMaker: fonts were sucessfully installed"
echo ""

exit 0
