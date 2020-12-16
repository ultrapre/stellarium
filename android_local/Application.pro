include(projects/_common.pri)

TEMPLATE = app


SOURCES += \
	$$STEL/src/main.cpp
	

android {
	QT += androidextras

	ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
        ANDROID_PACKAGE            = org.stellarium.LTS
	ANDROID_MINIMUM_VERSION    = 21
	ANDROID_TARGET_VERSION     = 21
        ANDROID_APP_NAME           = Stellarium LTS

        DISTFILES += \
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

#silas need armv7?

ANDROID_ABIS = armeabi-v7a



Plugins += \
AngleMeasure \
ArchaeoLines \
CompassMarks \
EquationOfTime \
Exoplanets \
FOV \
MeteorShowers \
NavStars \
Novae \
Observability \
Oculars \
PointerCoordinates \
Pulsars \
Quasars \
RemoteControl \
RemoteSync \
Satellites \
Scenery3d \
SolarSystemEditor \
Supernovae \
TelescopeControl \
TextUserInterface

# T*2
android{

LIBS += -lMain #_armeabi-v7a

for(c,Plugins){

LIBS += -lmodule_$${c} #_armeabi-v7a

}
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

windows{
LIBS += -lMain \
#-lAngleMeasure \
#-lArchaeoLines \
#-lCompassMarks \
#-lEquationOfTime \
#-lExoplanets \
#-lNavStars \
#-lNovae \
#-lObservability \
#-lOculars \
#-lPointerCoordinates \
#-lPulsars \
#-lQuasars \
#-lRemoteControl \
#-lRemoteSync \
#-lSatellites \
#-lScenery3d \
#-lSolarSystemEditor \
#-lSupernovae \
#-lTextUserInterface

#DEFINES += \
#        USE_STATIC_PLUGIN_ANGLEMEASURE \
#        USE_STATIC_PLUGIN_ARCHAEOLINES \
#        USE_STATIC_PLUGIN_COMPASSMARKS \
#        USE_STATIC_PLUGIN_SATELLITES \
#        USE_STATIC_PLUGIN_TEXTUSERINTERFACE \
#        USE_STATIC_PLUGIN_LOGBOOK \
#        USE_STATIC_PLUGIN_OCULARS \
#        USE_STATIC_PLUGIN_TELESCOPECONTROL \
#        USE_STATIC_PLUGIN_SOLARSYSTEMEDITOR \
#        USE_STATIC_PLUGIN_METEORSHOWERS \
#        USE_STATIC_PLUGIN_NAVSTARS \
#        USE_STATIC_PLUGIN_NOVAE \
#        USE_STATIC_PLUGIN_SUPERNOVAE \
#        USE_STATIC_PLUGIN_QUASARS \
#        USE_STATIC_PLUGIN_PULSARS \
#        USE_STATIC_PLUGIN_EXOPLANETS \
#        USE_STATIC_PLUGIN_EQUATIONOFTIME \
#        USE_STATIC_PLUGIN_FOV \
#        USE_STATIC_PLUGIN_POINTERCOORDINATES \
#        USE_STATIC_PLUGIN_OBSERVABILITY \
#        USE_STATIC_PLUGIN_SCENERY3D \
#        USE_STATIC_PLUGIN_REMOTECONTROL \
#        USE_STATIC_PLUGIN_REMOTESYNC \
#LIBS += $$files( $$DESTDIR/modules/*.lib , true )
}



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



RESOURCES += \
    $$STEL/data/gui/guiRes.qrc \
    $$STEL/data/locationsEditor.qrc \
    $$STEL/data/mainRes.qrc


#message($$DESTDIR)
