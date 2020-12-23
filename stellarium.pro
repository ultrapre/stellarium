include(assets.pri)

TEMPLATE = app

TARGET = Stellarium

BUILD_VER_TRUNK=203
STEL=.
DESTDIR     = ../High/dest$$BUILD_VER_TRUNK

android{
#DEFINES += Q_OS_ANDROID
#DESTDIR     = $${DESTDIR}_android
}
msvc{
DESTDIR     = $${DESTDIR}_msvc
LIBS += -lAdvAPI32
}
mingw{
DESTDIR     = $${DESTDIR}_mingw
}
if(ios){}
else{if(macos){}}


static{
DESTDIR     = $${DESTDIR}_static
}
CONFIG(debug, debug|release){
DESTDIR     = $${DESTDIR}_Debug
}
CONFIG(release, debug|release){
DESTDIR     = $${DESTDIR}_Release
}

#message(Qt version: $$[QT_VERSION])
#message(Qt is installed in $$[QT_INSTALL_PREFIX])
#message(Qt resources can be found in the following locations:)
#message(Documentation: $$[QT_INSTALL_DOCS])
#message(Header files: $$[QT_INSTALL_HEADERS])
#message(Libraries: $$[QT_INSTALL_LIBS])
#message(Binary files (executables): $$[QT_INSTALL_BINS])
#message(Plugins: $$[QT_INSTALL_PLUGINS])
#message(Data files: $$[QT_INSTALL_DATA])
#message(Translation files: $$[QT_INSTALL_TRANSLATIONS])
#message(Settings: $$[QT_INSTALL_CONFIGURATION])
#message(Examples: $$[QT_INSTALL_EXAMPLES])


DEFINES += \
STELLARIUM_SOURCE_DIR=\\\"\\\.\\\" \
STELLARIUM_URL=\\\"https://stellarium.org/\\\" \
        COPYRIGHT_YEARS=\\\"2000-2019\\\" \
        PACKAGE_VERSION=\\\"0.20.3\\\" \
        STELLARIUM_MAJOR=0 \
        STELLARIUM_MINOR=20 \
        STELLARIUM_PATCH=3

#DEFINES += \
#	ENABLE_GPS \
#	ENABLE_MEDIA \
#	ENABLE_NLS \
#	ENABLE_SCRIPT_CONSOLE \
#	INSTALL_DATADIR=\\\".\\\" \
#	INSTALL_DATADIR_FOR_DEBUG=\\\".\\\"

#DEFINES += DISABLE_SCRIPTING
#DEFINES += PACKAGE_VERSION_NOSTR=$${VERSION}
#DEFINES += MOBILE_GUI_VERSION_NOSTR=$${MOBILE_VERSION}
#DEFINES += INSTALL_DATADIR_NOSTR=
#DEFINES += USE_QUICKVIEW

#VERSION = 0.12.3
#MOBILE_VERSION = 1.29.6

CONFIG  += qt thread c++11

QT += network gui sensors qml quick positioning concurrent \
        core \
        gui \
        widgets \
        concurrent \
        script \
        multimedia \
        multimediawidgets \
        positioning \
        serialport \
        printsupport \
        network \
        opengl \
        sensors

ios{
QT -= serialport
}

INCLUDEPATH += \
$$STEL/src \
$$STEL/src/core \
$$STEL/src/core/modules \
$$STEL/src/core/planetsephems \
$$STEL/src/external \
$$STEL/src/external/glues_stel \
$$STEL/src/external/glues_stel/source \
$$STEL/src/external/glues_stel/source/libtess \
$$STEL/src/external/libindi \
$$STEL/src/external/libindi/libs \
$$STEL/src/external/libindi/libs/indibase \
$$STEL/src/external/libindi/libs/indibase/connectionplugins \
$$STEL/src/external/libindi/libs/lx \
$$STEL/src/external/qcustomplot \
$$STEL/src/external/qtcompress \
$$STEL/src/external/qxlsx \
$$STEL/src/external/zlib \
$$STEL/src/gui \
$$STEL/src/scripting \
$$STEL/src/tests \

android{
LIBS += -L$$DESTDIR -lz
}

windows{
DEFINES += _USE_MATH_DEFINES NOMINMAX _WINDOWS
LIBS    += -lWinmm  -lSpoutLibrary

#    if(win32){
    LIBS    += -L$$STEL/util/spout2/Win32
#    }
#    else{
    LIBS    += -L$$STEL/util/spout2/x64
#    }
}


android {
        QT += androidextras

        ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
        ANDROID_PACKAGE            = org.stellarium.LTS
        ANDROID_MINIMUM_VERSION    = 21
        ANDROID_TARGET_VERSION     = 21
        ANDROID_APP_NAME           = Stellarium LTS

        ANDROID_ABIS = armeabi-v7a

#        DISTFILES += \
#                $$ANDROID_PACKAGE_SOURCE_DIR/AndroidManifest.xml \
#		$$ANDROID_PACKAGE_SOURCE_DIR/res/values/libs.xml \
#		$$ANDROID_PACKAGE_SOURCE_DIR/build.gradle

#STEL_ASSETS = ../ASSETS/assets$$BUILD_VER_TRUNK
#        assets.path    = /assets/
#        assets.files   = $$STEL_ASSETS/*  $$_PRO_FILE_PWD_/data/*
#        INSTALLS += assets

        #modules.path   = /libs/$$ANDROID_TARGET_ARCH/modules/plugin_
        #modules.files  = $$DESTDIR/modules/*
        #INSTALLS += assets modules

        #LIST=$$files($$DESTDIR/modules/*.so)
        #for(f , LIST ) {
        #	#T=$$replace( f , "$$DESTDIR/modules/lib" , "" )
        #	#T=$$replace( T , ".so"                   , "" )
        #	T=$$basename(f)
        #
        #	modules_$${T}.path  = /assets/modules/$$T/
        #	modules_$${T}.files = $$f
        #
        #	INSTALLS += modules_$${T}
        #}


        ANDROID_EXTRA_LIBS += $$files( $$DESTDIR/*.so , true )
}


	

#windows{

##DEFINES += \
##        USE_STATIC_PLUGIN_ANGLEMEASURE \
##        USE_STATIC_PLUGIN_ARCHAEOLINES \
##        USE_STATIC_PLUGIN_COMPASSMARKS \
##        USE_STATIC_PLUGIN_SATELLITES \
##        USE_STATIC_PLUGIN_TEXTUSERINTERFACE \
##        USE_STATIC_PLUGIN_LOGBOOK \
##        USE_STATIC_PLUGIN_OCULARS \
##        USE_STATIC_PLUGIN_TELESCOPECONTROL \
##        USE_STATIC_PLUGIN_SOLARSYSTEMEDITOR \
##        USE_STATIC_PLUGIN_METEORSHOWERS \
##        USE_STATIC_PLUGIN_NAVSTARS \
##        USE_STATIC_PLUGIN_NOVAE \
##        USE_STATIC_PLUGIN_SUPERNOVAE \
##        USE_STATIC_PLUGIN_QUASARS \
##        USE_STATIC_PLUGIN_PULSARS \
##        USE_STATIC_PLUGIN_EXOPLANETS \
##        USE_STATIC_PLUGIN_EQUATIONOFTIME \
##        USE_STATIC_PLUGIN_FOV \
##        USE_STATIC_PLUGIN_POINTERCOORDINATES \
##        USE_STATIC_PLUGIN_OBSERVABILITY \
##        USE_STATIC_PLUGIN_SCENERY3D \
##        USE_STATIC_PLUGIN_REMOTECONTROL \
##        USE_STATIC_PLUGIN_REMOTESYNC \
##LIBS += $$files( $$DESTDIR/modules/*.lib , true )
#}

# equals(USE_STATIC_PLUGINS,1){
#	DEFINES += \
#		USE_STATIC_PLUGIN_ANGLEMEASURE \
#		USE_STATIC_PLUGIN_ARCHAEOLINES \
#		USE_STATIC_PLUGIN_COMPASSMARKS \
#		USE_STATIC_PLUGIN_SATELLITES \
#		USE_STATIC_PLUGIN_TEXTUSERINTERFACE \
#		USE_STATIC_PLUGIN_LOGBOOK \
#		USE_STATIC_PLUGIN_OCULARS \
#		USE_STATIC_PLUGIN_TELESCOPECONTROL \
#		USE_STATIC_PLUGIN_SOLARSYSTEMEDITOR \
#		USE_STATIC_PLUGIN_METEORSHOWERS \
#		USE_STATIC_PLUGIN_NAVSTARS \
#		USE_STATIC_PLUGIN_NOVAE \
#		USE_STATIC_PLUGIN_SUPERNOVAE \
#		USE_STATIC_PLUGIN_QUASARS \
#		USE_STATIC_PLUGIN_PULSARS \
#		USE_STATIC_PLUGIN_EXOPLANETS \
#		USE_STATIC_PLUGIN_EQUATIONOFTIME \
#		USE_STATIC_PLUGIN_FOV \
#		USE_STATIC_PLUGIN_POINTERCOORDINATES \
#		USE_STATIC_PLUGIN_OBSERVABILITY \
#		USE_STATIC_PLUGIN_SCENERY3D \
#		USE_STATIC_PLUGIN_REMOTECONTROL \
#		USE_STATIC_PLUGIN_REMOTESYNC \
#	LIBS += $$files( $$DESTDIR/modules/lib*.a , true )
#}

RESOURCES += \
    $$STEL/data/gui/guiRes.qrc \
    $$STEL/data/locationsEditor.qrc \
    $$STEL/data/mainRes.qrc

MainSRC += \
/src \

#SOURCES += \
#        $$STEL/src/main.cpp

for(c,MainSRC){

SOURCES += \
        $$files( $$STEL$$c/*.c   , true ) \
        $$files( $$STEL$$c/*.cpp , true )

HEADERS += \
        $$files( $$STEL$$c/*.h   , true ) \
        $$files( $$STEL$$c/*.hpp , true )

FORMS += \
        $$files( $$STEL$$c/*.ui , true )

RESOURCES += \
        $$files( $$STEL$$c/*.qrc , true )
}

SOURCES -= \
        $$files( $$STEL/src/tests/*.cpp ) \
        $$files( $$STEL/src/core/modules/GeodesicGridDrawer.cpp ) \

HEADERS -= \
        $$files( $$STEL/src/tests/*.hpp ,true) \
        $$files( $$STEL/src/core/modules/GeodesicGridDrawer.hpp ) \

android{
HEADERS -= \
        $$files( $$STEL/src/external/libindi/*.hpp , true) \
        $$files( $$STEL/src/external/libindi/*.h , true) \
        $$files( $$STEL/src/core/SpoutSender.hpp, true ) \
        $$files( $$STEL/src/external/SpoutLibrary.h  , true) \
        $$files( $$STEL/src/core/external/glues_stel/source/glues_error.h , true )

SOURCES -= \
        $$files( $$STEL/src/external/libindi/*.cpp , true) \
        $$files( $$STEL/src/external/libindi/*.c , true) \
        $$files( $$STEL/src/core/SpoutSender.cpp  , true) \
        $$files( $$STEL/src/core/external/glues_stel/source/glues_error.c , true )
}

windows{

HEADERS -= \
        $$files( $$STEL/src/external/libindi/*.hpp , true) \
        $$files( $$STEL/src/external/libindi/*.h , true) \
#        $$files( $$STEL/src/core/SpoutSender.hpp, true ) \
#        $$files( $$STEL/src/external/SpoutLibrary.h  , true) \
#        $$files( $$STEL/src/core/external/glues_stel/source/glues_error.h , true )

SOURCES -= \
        $$files( $$STEL/src/external/libindi/*.cpp , true) \
        $$files( $$STEL/src/external/libindi/*.c , true) \
#        $$files( $$STEL/src/core/SpoutSender.cpp  , true) \
#        $$files( $$STEL/src/core/external/glues_stel/source/glues_error.c , true )

HEADERS -= \
        $$files( $$STEL/src/StelAndroid.hpp, true ) \

SOURCES -= \
$$files( $$STEL/src/StelAndroid.cpp, true ) \

}
