###############################################################################
#        Copyright (C) 2020        Sebastian Francisco Colomar Bauza          #
#        Copyright (C) 2020        Alejandro Colomar Andrés                   #
#        SPDX-License-Identifier:  GPL-2.0-only                               #
###############################################################################

FROM									\
	alpine@sha256:b28e271d721b3f6377cb5bae6cd4506d2736e77ef6f70ed9b0c4716da8bdf17c \
			AS dns

RUN	apk add bind

###############################################################################
