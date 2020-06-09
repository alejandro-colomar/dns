###############################################################################
#        Copyright (C) 2020        Sebastian Francisco Colomar Bauza          #
#        Copyright (C) 2020        Alejandro Colomar Andrés                   #
#        SPDX-License-Identifier:  GPL-2.0-only                               #
###############################################################################

FROM	alpine/git:v2.24.3@sha256:8d2aedf3898243892d170f033603b40a55e0b0a8ab68ba9762f9c0dae40b5c8d \
			AS git

RUN									\
	git clone							\
	    --single-branch						\
	    --branch master						\
	    https://github.com/alejandro-colomar/dns.alejandro-colomar.es.git \
	    /repo

###############################################################################

FROM	alpine:3.12.0@sha256:3b3f647d2d99cac772ed64c4791e5d9b750dd5fe0b25db653ec4976f7b72837c \
			AS dns

RUN	apk add	--no-cache bind

## configure dns server
COPY	--from=git	/repo/etc/bind/named.conf			\
			/etc/bind/named.conf
COPY	--from=git	/repo/etc/bind/named.d/				\
			/etc/bind/named.d

CMD	["named", "-c", "/etc/bind/named.conf", "-g", "-u", "named"]

###############################################################################
