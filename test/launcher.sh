#!/bin/sh

Qt_DIR=.
APPDIR=.

export LD_LIBRARY_PATH=$(realpath $Qt_DIR)/lib
export QT_QPA_PLATFORM_PLUGIN_PATH=$(realpath $Qt_DIR)/plugins

setsid sh -c "$($APPDIR/$(basename $0 | sed s,\.sh$,,) -platform eglfs) <> /dev/tty1 >&0 2>&1"
