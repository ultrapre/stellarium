TEMPLATE = subdirs

SUBDIRS += \
        Main \
#        AngleMeasure \
#        ArchaeoLines \
#        CompassMarks \
#        EquationOfTime \
#        Exoplanets \
#        FOV \
#        MeteorShowers \
#        NavStars \
#        Novae \
#        Observability \
#        Oculars \
#        PointerCoordinates \
#        Pulsars \
#        Quasars \
#        RemoteControl \
#        RemoteSync \
#        Satellites \
#        Scenery3d \
#        SolarSystemEditor \
#        Supernovae \
#        TelescopeControl \
#        TextUserInterface

for(c,SUBDIRS){
        $${c}.file    = projects/$${c}.pro
	
#error when TUI
#        !equals(c,"Main"){
#                $${c}.depends = Main
#        }

#        equals(c,"TelescopeControl"){
#                $${c}.depends = Main
#        }

}

