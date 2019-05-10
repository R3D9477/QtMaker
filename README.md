# QtMaker
build your Qt from sources automatically

Script provides:
* downloading and packing (for future re-usage) needed sources
* build from sources 
  * QtBase
  * QtMultimedia
  * QtDeclarative
  * QtQuick2
  * QtSerialport

#### Install and Run

1. install all needed dependencies (bash, wget, git, opengl, gstreamer)
2. set your toolchain _(example you can see in [LIMaker](https://github.com/r3d9u11/LIMaker/blob/master/03-set_tc.sh#L1))_
3. be sure that you have a free space on your local storage
4. run `git clone --recursive https://github.com/r3d9u11/QtMaker.git`
5. check configuration in `make-all-defs.sh`
6. run `make-all-defs.sh`
7. wait until process will be completed

#### Variables

`CACHE` - directory which contains Qt sources and other packages
`SYSROOT` - target root filesystem
`PASS` - password to grant root privileges on host machine

`Qt_VER` - numeric version of Qt
`Qt_DIR` - Qt directory on target root filesystem

`Qt_ACCEPT_CONFIG` - autoaccept Qt configuration
* `a` - ask everytime (when you want to check Qt configuration)
* `y` - always accept configuration (without your review)
* `n` - configuration will not be accepted, installation process will be terminated on first package.

`Qt_TEST` - directory with sources of test applications
`Qt_EXPORT` - result directory with compiled test applications (will be exported to targer root filesystem)
