include(../_config.pri)
include(../_version.pri)

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


windows{
	DEFINES += _USE_MATH_DEFINES NOMINMAX _WINDOWS
	LIBS    += -lWinmm
}


android {
#        !equals(ANDROID_PLATFORM,"android-21"){
#                error("Requires android-21 platform to work!")
#	}
	
	DEFINES += \
                __ANDROID_API__=$$replace(ANDROID_PLATFORM,"android-","")

#silas
        QMAKE_CXXFLAGS += -Wno-unused-parameter -Wno-unused-variable
}
