include(_common.pri)

TEMPLATE = app

android {
        QT += androidextras
}

DEFINES += \
	ENABLE_GPS \
	ENABLE_MEDIA \
	ENABLE_NLS \
	ENABLE_SCRIPT_CONSOLE \
	INSTALL_DATADIR=\\\".\\\" \
	INSTALL_DATADIR_FOR_DEBUG=\\\".\\\"

MainSRC += \
/src \

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
#        $$files( $$STEL/src/main.cpp ) \
        $$files( $$STEL/src/tests/*.cpp ) \
        $$files( $$STEL/src/core/modules/GeodesicGridDrawer.cpp ) \
        $$files( $$STEL/src/external/libindi/*.cpp , true) \
        $$files( $$STEL/src/external/libindi/*.c , true) \
        $$files( $$STEL/src/core/SpoutSender.cpp  , true) \
        $$files( $$STEL/src/core/external/glues_stel/source/glues_error.c , true )

HEADERS -= \
        $$files( $$STEL/src/tests/*.hpp ,true) \
        $$files( $$STEL/src/core/SpoutSender.hpp, true ) \
        $$files( $$STEL/src/core/modules/GeodesicGridDrawer.hpp ) \
        $$files( $$STEL/src/external/SpoutLibrary.h  , true) \
        $$files( $$STEL/src/external/libindi/*.hpp , true) \
        $$files( $$STEL/src/external/libindi/*.h , true) \
        $$files( $$STEL/src/core/external/glues_stel/source/glues_error.h , true )

#message($$INCLUDEPATH)


android {
        QT += androidextras

        ANDROID_PACKAGE_SOURCE_DIR = $$PWD/../android
        ANDROID_PACKAGE            = org.stellarium.LTS
        ANDROID_MINIMUM_VERSION    = 21
        ANDROID_TARGET_VERSION     = 21
        ANDROID_APP_NAME           = Stellarium LTS

        DISTFILES += \
                $$ANDROID_PACKAGE_SOURCE_DIR/AndroidManifest.xml \

        assets.path    = /assets/
        assets.files   = $$STEL_ASSETS/*  $$_PRO_FILE_PWD_/../data/*
        INSTALLS += assets

        ANDROID_EXTRA_LIBS += $$files( $$DESTDIR/*.so , true )
}

