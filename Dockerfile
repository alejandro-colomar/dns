###############################################################################
#        Copyright (C) 2020        Sebastian Francisco Colomar Bauza          #
#        Copyright (C) 2020        Alejandro Colomar Andrés                   #
#        SPDX-License-Identifier:  GPL-2.0-only                               #
###############################################################################

##	alpine/git:latest
FROM	alpine/git@sha256:07f99e3b565e0c6e2f447e73f4374356dd9859e343f9da2788e334a576752a14 \
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
