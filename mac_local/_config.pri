# Recommendations:
#	- use NDK v10e
#	- set "Android build SDK" option to "android-21"
#	- set environment variable "ANDROID_NDK_PLATFORM" to "android-21"
#	- override "make" to any other than from NDK
#     (e.g. D:\Dev\Qt\5.11.0\Tools\mingw530_32\bin\mingw32-make.exe )
#   - disable "Make install" and "Build Android APK" steps
#   - make sure there are no spaces in tool paths
#   - don't use project dependencies, only Stellarium project needs deployment


BUILD_VER_TRUNK += 180\
182\
203

android {
if(contains(BUILD_VER_TRUNK,203)){
message("Kits:203")
#STEL        = G:\Stellarium\stellarium-0.20.3
STEL        = G:\Stellarium\stellarium-android_fixes
STEL_ASSETS = G:\Stellarium\assets203
DESTDIR     = G:\Stellarium\High\dest203
}
else{
if(contains(BUILD_VER_TRUNK,182)){
message("Kits:182")
STEL        = G:\Stellarium\stellarium-0.18.2
STEL_ASSETS = G:\Stellarium\assets182
DESTDIR     = G:\Stellarium\High\dest182
}
else{
message("Kits:fix")
STEL        = G:\Stellarium\stellarium-android_fixes
STEL_ASSETS = G:\Stellarium\assets
DESTDIR     = G:\Stellarium\High\dest
}
}
}

windows{
if(contains(BUILD_VER_TRUNK,203)){
message("WinKits:203")
STEL        = G:\Stellarium\stellarium-0.20.3
STEL_ASSETS = G:\Stellarium\assets203
DESTDIR     = G:\Stellarium\High\destWin203
}
else{
if(contains(BUILD_VER_TRUNK,182)){
message("WinKits:182")
STEL        = G:\Stellarium\stellarium-0.18.2
STEL_ASSETS = G:\Stellarium\assets182
DESTDIR     = G:\Stellarium\High\destWin182
}
else{
message("WinKits:fix")
STEL        = G:\Stellarium\stellarium-android_fixes
STEL_ASSETS = G:\Stellarium\assets
DESTDIR     = G:\Stellarium\High\destWin
}
}
}

ISIOS = 0

ios {
ISIOS= 1
message("is ios!")
if(contains(BUILD_VER_TRUNK,203)){
message("Kits:203")
#STEL        = G:\Stellarium\stellarium-0.20.3
STEL        = /Users/inode/Desktop/Stellarium/PC/LTS
STEL_ASSETS = /Users/inode/Desktop/Stellarium/PC/assets203
DESTDIR     = /Users/inode/Desktop/Stellarium/PC/dest203
}
else{
if(contains(BUILD_VER_TRUNK,182)){
message("Kits:182")
STEL        = G:\Stellarium\stellarium-0.18.2
STEL_ASSETS = G:\Stellarium\assets182
DESTDIR     = G:\Stellarium\High\dest182
}
else{
message("Kits:fix")
STEL        = G:\Stellarium\stellarium-android_fixes
STEL_ASSETS = G:\Stellarium\assets
DESTDIR     = G:\Stellarium\High\dest
}
}
}

if(equals(ISIOS,0)){
message("is not ios!")
mac {
if(contains(BUILD_VER_TRUNK,203)){
message("Kits:203")
STEL        = /Users/inode/Desktop/Stellarium/PC/LTS
STEL_ASSETS = /Users/inode/Desktop/Stellarium/PC/assets203
DESTDIR     = /Users/inode/Desktop/Stellarium/PC/destosx203
}
else{
if(contains(BUILD_VER_TRUNK,182)){
message("Kits:182")
STEL        = G:\Stellarium\stellarium-0.18.2
STEL_ASSETS = G:\Stellarium\assets182
DESTDIR     = G:\Stellarium\High\dest182
}
else{
message("Kits:fix")
STEL        = G:\Stellarium\stellarium-android_fixes
STEL_ASSETS = G:\Stellarium\assets
DESTDIR     = G:\Stellarium\High\dest
}
}
}
}



DEFINES+= \
STELLARIUM_SOURCE_DIR=\\\"../../LTS\\\"

#DEFINES += \
#STELLARIUM_SOURCE_DIR=G:\\Stellarium\\stellarium-android_fixes

#silas
android{
QMAKE_CXXFLAGS += -Wno-unused-parameter -Wno-unused-variable
}
