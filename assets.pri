
android{
INSTALL_PREFIX = /assets
}
macx{
INSTALL_PREFIX = /Resources
}

sdata0.path = $${INSTALL_PREFIX}/data
tmplis = ssystem_major.ini ssystem_minor.ini ssystem_1000comets.ini base_locations.bin.gz \
DejaVuSans.ttf default_cfg.ini DejaVuSansMono.ttf iso639-1.utf8 iso3166.tab countryCodes.dat \
constellation_boundaries.dat constellations_spans.dat nomenclature.dat shaders

for(c,tmplis){
sdata0.files = data/$$c
}

sdata1.path = $${INSTALL_PREFIX}
sdata1.files += landscapes models nebulae scripts skycultures stars textures

INSTALLS += sdata0 sdata1
