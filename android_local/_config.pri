# Recommendations:
#	- use NDK v10e
#	- set "Android build SDK" option to "android-21"
#	- set environment variable "ANDROID_NDK_PLATFORM" to "android-21"
#	- override "make" to any other than from NDK
#     (e.g. D:\Dev\Qt\5.11.0\Tools\mingw530_32\bin\mingw32-make.exe )
#   - disable "Make install" and "Build Android APK" steps
#   - make sure there are no spaces in tool paths
#   - don't use project dependencies, only Stellarium project needs deployment


BUILD_VER_TRUNK=203

STEL=G:\Stellarium\TRACK\stellarium
STEL_ASSETS = G:\Stellarium\assets$$BUILD_VER_TRUNK
DESTDIR     = G:\Stellarium\High\dest$$BUILD_VER_TRUNK



windows{
WIN = Win
DESTDIR = $$DESTDIR$$WIN
}

CONFIG(debug, debug|release){
}
CONFIG(release, debug|release){
relese_mark = _release
DESTDIR     = $$DESTDIR$$relese_mark
}


DEFINES += \
STELLARIUM_SOURCE_DIR=\\\"G:\\\\Stellarium\\\\TRACK\\\\stellarium\\\" \
STELLARIUM_URL=\\\"https://stellarium.org/\\\" \
#INSTALL_DATADIR=\\\"assets:\\\" \



### Android fix

#DEFINES += DISABLE_SCRIPTING
#DEFINES += ENABLE_NLS
#DEFINES += PACKAGE_VERSION_NOSTR=$${VERSION}
#DEFINES += MOBILE_GUI_VERSION_NOSTR=$${MOBILE_VERSION}
#DEFINES += INSTALL_DATADIR_NOSTR=
#DEFINES += USE_QUICKVIEW

#VERSION = 0.12.3
#MOBILE_VERSION = 1.29.6
