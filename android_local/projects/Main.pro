include(_common.pri)

TEMPLATE = lib

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
        $$files( $$STEL/src/main.cpp ) \
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

#HEADERS += \
#    ../../../TRACK/stellarium/src/StelQuickStelItem.hpp \
#    ../../../TRACK/stellarium/src/StelQuickView.hpp \
#    ../../../TRACK/stellarium/src/config.h \
#    ../../../TRACK/stellarium/src/core/modules/GPSMgr.hpp

#SOURCES += \
#    ../../../TRACK/stellarium/src/StelQuickStelItem.cpp \
#    ../../../TRACK/stellarium/src/StelQuickView.cpp \
#    ../../../TRACK/stellarium/src/core/modules/GPSMgr.cpp



#OTHER_FILES += \
#        data/qml/AboutDialog.qml \
#        data/qml/ImageButton.qml \
#        data/qml/InfoPanel.qml \
#        data/qml/LandscapesDialog.qml \
#        data/qml/LocationCityPicker.qml \
#        data/qml/LocationDialog.qml \
#        data/qml/LocationMap.qml \
#        data/qml/main.qml \
#        data/qml/QuickBar.qml \
#        data/qml/SearchInput.qml \
#        data/qml/Splash.qml \
#        data/qml/StarloreDialog.qml \
#        data/qml/SettingsPanel.qml \
#        data/qml/StelButton.qml \
#        data/qml/StelCheckBox.qml \
#        data/qml/StelDialog.qml \
#        data/qml/StelListItem.qml \
#        data/qml/StelMessage.qml \
#        data/qml/StelSpinBox.qml \
#        data/qml/StelTimeSpinBox.qml \
#        data/qml/TimeBar.qml \
#        data/qml/TimeDialog.qml \
#        data/qml/TouchPinchArea.qml \
#        data/qml/AdvancedDialog.qml \
#        data/qml/AnglePicker.qml \
#        data/qml/ValuePicker.qml \

#message($$DESTDIR)
