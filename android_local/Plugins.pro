TEMPLATE = subdirs

SUBDIRS += \
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

for(c,SUBDIRS){
        $${c}.file    = projects/$${c}.pro
	
#        !equals(c,"Main"){
#                $${c}.depends = Main
#        }
}

# plugin's ui fail when 5.12.10
