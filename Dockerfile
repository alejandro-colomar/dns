###############################################################################
#        Copyright (C) 2020        Sebastian Francisco Colomar Bauza          #
#        Copyright (C) 2020        Alejandro Colomar Andrés                   #
#        SPDX-License-Identifier:  GPL-2.0-only                               #
###############################################################################

##	alpine/git:latest
FROM	alpine/git@sha256:8d2aedf3898243892d170f033603b40a55e0b0a8ab68ba9762f9c0dae40b5c8d \
			AS git

RUN									\
	git clone							\
	    --single-branch						\
	    --branch master						\
	    https://github.com/alejandro-colomar/dns.alejandro-colomar.es.git \
	    /repo

###############################################################################

##	debian:stable-slim
FROM	debian@sha256:aa1db351593d2849034c0395bc604dd65aa80ae4471da4a37a0c38e30aed3ab8 \
			AS dns

RUN									\
	apt-get update							&& \
	apt-get install -V \
			bind9 \
			--yes						&& \
	apt-get autoremove --purge -y					&& \
	apt-get autoclean						&& \
	apt-get clean

## configure dns server
COPY	--from=git	/repo/etc/bind/named.conf			\
			/etc/bind/named.conf
COPY	--from=git	/repo/etc/bind/named.d/				\
			/etc/bind/named.d

CMD	["named", "-c", "/etc/bind/named.conf", "-g", "-u", "named"]

###############################################################################
