# QtMaker
build your Qt from sources automatically

Script provides:
* downloading and packing (for future re-usage) needed sources
* building from sources (by default uses Qt 5.9)
  * [QtBase](https://code.qt.io/cgit/qt/qtbase.git)
  * [QtMultimedia](https://code.qt.io/cgit/qt/qtmultimedia.git)
  * [QtDeclarative](https://code.qt.io/cgit/qt/qtdeclarative.git)
  * [QtQuick2](https://code.qt.io/cgit/qt/qtdeclarative.git)
  * [QtSerialport](https://code.qt.io/cgit/qt/qtserialport.git)

#### Install and Run

1. install all needed dependencies (bash, wget, git, opengl, gstreamer)
2. set your toolchain _(example you can see in [LIMaker](https://github.com/r3d9u11/LIMaker/blob/master/03-set_tc`#L1))_
3. be sure that you have a free space on your local storage
4. run `git clone --recursive https://github.com/r3d9u11/QtMaker.git`
5. check configuration in heading of `make-all.sh` and set needed values
6. run `make-all`
7. wait until process will be completed

#### Variables

* `CACHE` - directory which contains Qt sources and other packages
* `SYSROOT` - target root filesystem
* `PASS` - password to grant root privileges on host machine
* `Qt_VER` - numeric version of Qt
* `Qt_DIR` - Qt directory on target root filesystem
* `Qt_DEVICE` - target device (from `qtbase/mkspecs/devices`)
* `Qt_ARCH` - target hardware architecture (usually uses value from `ARCH`)
* `Qt_ACCEPT_CONFIG` - autoaccept Qt configuration
  * `a` - ask everytime (when you want to check Qt configuration)
  * `y` - always accept configuration (without your review)
  * `n` - configuration will not be accepted, installation process will be terminated on first package.
* `Qt_TEST` - directory with sources of test applications
* `Qt_EXPORT` - result directory with compiled test applications (will be exported to targer root filesystem)
* `Qt_SDK` - copy of Qt binaries on the host machine (for applications development)

#### Scripts

* `make-all` - cross-compiles Qt libs and test-applications and installs them to destination root filesystem
* `make` - compiles and installs Qt libs
* `get` - downloads Qt libs
* `setEnv` - sets [Qt variables](#variables)
* `export` - compiles Qt test-applications and exports them to `Qt_EXPORT`
* `deploy2sysroot` - deploys the export directory with test-applciations to the destination root filesystem
* `createSDK` - copies the result directory with Qt binaries to the host machine (for application development)
