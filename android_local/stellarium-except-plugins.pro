#include(projects/_common.pri)

#DEFINES+= \
#        COPYRIGHT_YEARS=\\\"2000-2019\\\" \
#        PACKAGE_VERSION=\\\"0.20.3\\\" \
#        STELLARIUM_MAJOR=0 \
#        STELLARIUM_MINOR=20 \
#        STELLARIUM_PATCH=3


BUILD_VER_TRUNK=203

STEL=G:\Stellarium\TRACK\stellarium
STEL_ASSETS = G:\Stellarium\assets$$BUILD_VER_TRUNK
DESTDIR     = G:/Stellarium/TRACK/destdir


#windows{
#WIN = Win
#DESTDIR = $$DESTDIR$$WIN
#}

#CONFIG(debug, debug|release){
#}
#CONFIG(release, debug|release){
#relese_mark = _release
#DESTDIR     = $$DESTDIR$$relese_mark
#}


#DEFINES += \
#STELLARIUM_SOURCE_DIR=\\\"G:\\\\Stellarium\\\\TRACK\\\\stellarium\\\" \
#STELLARIUM_URL=\\\"https://stellarium.org/\\\" \

CONFIG  += c++11

QT += network gui sensors qml quick positioning concurrent

QT += \
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

CONFIG += qt thread

LIBS += -lz

INCLUDEPATH += \
$$STEL/src \
$$STEL/src\core \
$$STEL/src\core\modules \
$$STEL/src\core\planetsephems \
$$STEL/src\external \
$$STEL/src\external\glues_stel \
$$STEL/src\external\glues_stel\source \
$$STEL/src\external\glues_stel\source\libtess \
$$STEL/src\external\libindi \
$$STEL/src\external\libindi\libs \
$$STEL/src\external\libindi\libs\indibase \
$$STEL/src\external\libindi\libs\indibase\connectionplugins \
$$STEL/src\external\libindi\libs\lx \
$$STEL/src\external\qcustomplot \
$$STEL/src\external\qtcompress \
$$STEL/src\external\qxlsx \
$$STEL/src\external\zlib \
$$STEL/src\gui \
$$STEL/src\scripting \
$$STEL/src\tests \

LIBS += -L$$DESTDIR


#windows{
#        DEFINES += _USE_MATH_DEFINES NOMINMAX _WINDOWS
#        LIBS    += -lWinmm
#}


#android {
#        !equals(ANDROID_PLATFORM,"android-21"){
#                error("Requires android-21 platform to work!")
#        }

#        DEFINES += \
#                __ANDROID_API__=$$replace(ANDROID_PLATFORM,"android-","")

##silas
#        QMAKE_CXXFLAGS += -Wno-unused-parameter -Wno-unused-variable
#}




TEMPLATE = app

TARGET = Application

SOURCES += \
	$$STEL/src/main.cpp
	

android {
	QT += androidextras

	ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
        ANDROID_PACKAGE            = org.stellarium.LTS
	ANDROID_MINIMUM_VERSION    = 21
	ANDROID_TARGET_VERSION     = 21
        ANDROID_APP_NAME           = Stellarium LTS

#        DISTFILES += \
#                $$ANDROID_PACKAGE_SOURCE_DIR/AndroidManifest.xml \
#		$$ANDROID_PACKAGE_SOURCE_DIR/res/values/libs.xml \
#		$$ANDROID_PACKAGE_SOURCE_DIR/build.gradle

	assets.path    = /assets/
        assets.files   = $$STEL_ASSETS/*  $$_PRO_FILE_PWD_/data/*
	INSTALLS += assets
	
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

#silas
android{
LIBS += -lstelMain_armeabi-v7a \
#-lmodule_AngleMeasure_armeabi-v7a \
#-lmodule_ArchaeoLines_armeabi-v7a \
#-lmodule_CompassMarks_armeabi-v7a \
#-lmodule_EquationOfTime_armeabi-v7a \
#-lmodule_Exoplanets_armeabi-v7a \
#-lmodule_FOV_armeabi-v7a \
#-lmodule_MeteorShowers_armeabi-v7a \
#-lmodule_NavStars_armeabi-v7a \
#-lmodule_Novae_armeabi-v7a \
#-lmodule_Observability_armeabi-v7a \
#-lmodule_Oculars_armeabi-v7a \
#-lmodule_PointerCoordinates_armeabi-v7a \
#-lmodule_Pulsars_armeabi-v7a \
#-lmodule_Quasars_armeabi-v7a \
#-lmodule_RemoteControl_armeabi-v7a \
#-lmodule_RemoteSync_armeabi-v7a \
#-lmodule_Satellites_armeabi-v7a \
#-lmodule_Scenery3d_armeabi-v7a \
#-lmodule_SolarSystemEditor_armeabi-v7a \
#-lmodule_Supernovae_armeabi-v7a \
#-lmodule_TextUserInterface_armeabi-v7a \
#-lmodule_TelescopeControl_armeabi-v7a
}

#windows{
#LIBS += -lMain \
##-lAngleMeasure \
##-lArchaeoLines \
##-lCompassMarks \
##-lEquationOfTime \
##-lExoplanets \
##-lNavStars \
##-lNovae \
##-lObservability \
##-lOculars \
##-lPointerCoordinates \
##-lPulsars \
##-lQuasars \
##-lRemoteControl \
##-lRemoteSync \
##-lSatellites \
##-lScenery3d \
##-lSolarSystemEditor \
##-lSupernovae \
##-lTextUserInterface

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

#for(var, $$list($$enumerate_vars())) {
#    message("$${var}=$$eval($$var)")
#}

ANDROID_ABIS = armeabi-v7a

RESOURCES += \
    $$STEL/data/gui/guiRes.qrc \
    $$STEL/data/locationsEditor.qrc \
    $$STEL/data/mainRes.qrc


#message($$DESTDIR)
