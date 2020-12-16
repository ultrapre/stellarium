
#build dir is on build/ (translations dir need)
#build .so with cmakelists.txt and copy libstelMain_armeabi-v7a.so into ../libsShare
#build this


STEL=../..
DESTDIR     = ../libsShare


DEFINES += \
#STELLARIUM_SOURCE_DIR=\\\"G:\\\\Stellarium\\\\TRACK\\\\stellarium\\\" \
STELLARIUM_URL=\\\"https://stellarium.org/\\\" \
COPYRIGHT_YEARS=\\\"2000-2020\\\" \
PACKAGE_VERSION=\\\"0.20.3\\\" \
#        STELLARIUM_MAJOR=0 \
#        STELLARIUM_MINOR=20 \
#        STELLARIUM_PATCH=3

###################

TEMPLATE = app

#TARGET = stellarium

CONFIG  += c++11 qt thread

QT += core network gui sensors qml quick positioning concurrent \
        widgets script multimedia multimediawidgets serialport printsupport opengl

LIBS += -L$$DESTDIR -lz

android {
        QT += androidextras
        ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
        ANDROID_PACKAGE            = org.stellarium.LTS
        ANDROID_APP_NAME           = Stellarium LTS
        assets.path    = /assets/
        assets.files   = \
        $$STEL/data \
        $$STEL/guide \
        $$STEL/landscapes \
        $$STEL/models \
        $$STEL/nebulae \
        $$STEL/scenery3d \
        $$STEL/scripts \
        $$STEL/skycultures \
        $$STEL/stars \
        $$STEL/textures \
        $$STEL/build/translations
        INSTALLS += assets
        LIBS += -lstelMain_armeabi-v7a
        ANDROID_EXTRA_LIBS += $$files( $$DESTDIR/*.so , true )
        ANDROID_ABIS = armeabi-v7a
}

###################

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

SOURCES += \
        $$STEL/src/main.cpp

RESOURCES += \
    $$STEL/data/gui/guiRes.qrc \
    $$STEL/data/locationsEditor.qrc \
    $$STEL/data/mainRes.qrc


