# QtMaker
build your Qt from sources automatically

Script provides:
* downloading and packing (for future re-usage) needed sources
* building from sources 
  * QtBase
  * QtMultimedia
  * QtDeclarative
  * QtQuick2
  * QtSerialport

#### Install and Run

1. install all needed dependencies (bash, wget, git, opengl, gstreamer)
2. set your toolchain _(example you can see in [LIMaker](https://github.com/r3d9u11/LIMaker/blob/master/03-set_tc`#L1))_
3. be sure that you have a free space on your local storage
4. run `git clone --recursive https://github.com/r3d9u11/QtMaker.git`
5. checkout needed branch _(according to needed version of Qt)_
6. check configuration in `make-all-defs``
7. run `make-all-imx6``
8. wait until process will be completed

#### Variables

* `CACHE` - directory which contains Qt sources and other packages
* `SYSROOT` - target root filesystem
* `PASS` - password to grant root privileges on host machine
* `Qt_VER` - numeric version of Qt
* `Qt_DIR` - Qt directory on target root filesystem
* `Qt_DEVICE` - target device _(from `qtbase/mkspecs/devices`)_
* `Qt_ARCH` - target hardware architecture (usually uses value from `ARCH`)
* `Qt_ACCEPT_CONFIG` - autoaccept Qt configuration
  * `a` - ask everytime (when you want to check Qt configuration)
  * `y` - always accept configuration (without your review)
  * `n` - configuration will not be accepted, installation process will be terminated on first package.
* `Qt_TEST` - directory with sources of test applications
* `Qt_EXPORT` - result directory with compiled test applications (will be exported to targer root filesystem)
* `Qt_SDK` - copy of Qt binaries on the host machine (for applications development)

#### Scripts

* `make-all-imx6` - cross-comples Qt and test-applications for imx.6 and installs it to destication root filesystem
* `make` - compiles and installs Qt libs
* `get` - downloads Qt libs
* `setEnv` - sets [Qt variables](#variables)
* `export` - compiles Qt test-applications and create the export directory with binary files
* `deploy2sysroot` - deploys the export directory with test-applciations  to the destination root filesystem
* `createSDK` - copies the result directory with Qt binaries to the host machine (for application development)
