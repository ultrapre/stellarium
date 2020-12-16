
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

LIBS += -L$$DESTDIR

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
        LIBS += -lstelMain_armeabi-v7a -lz
        ANDROID_EXTRA_LIBS += $$files( $$DESTDIR/*.so , true )
        ANDROID_ABIS = armeabi-v7a
}

windows{
DEFINES += \
M_PI=3.14159265358979323846 \
M_PI_2=1.57079632679489661923
    LIBS += -lstelMain -lglues_stel -lindiclient -lqcustomplot_stel -lqtcompress_stel -lqxlsx_stel -lzlib_stel \
    -lAngleMeasure  -lArchaeoLines  -lCompassMarks  -lEquationOfTime  -lExoplanets  -lMeteorShowers  -lNavStars  -lNovae  -lObservability  -lOculars  -lPointerCoordinates  -lPulsars  -lQuasars  -lRemoteControl  -lRemoteSync  -lSatellites  -lScenery3d  -lSolarSystemEditor  -lSupernovae  -lTelescopeControl  -lTelescopeControl_ASCOM  -lTelescopeControl_common  -lTelescopeControl_gui  -lTelescopeControl_INDI  -lTelescopeControl_Lx200  -lTelescopeControl_NexStar  -lTelescopeControl_Rts2  -lTextUserInterface \
    -lSpoutLibrary
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

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    main.cpp \
    mainwindow.cpp

HEADERS += \
    mainwindow.h \
    ui_dT.h

FORMS += \
    mainwindow.ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

ANDROID_ABIS = armeabi-v7a
