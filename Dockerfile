###############################################################################
#        Copyright (C) 2020        Sebastian Francisco Colomar Bauza          #
#        Copyright (C) 2020        Alejandro Colomar Andrés                   #
#        SPDX-License-Identifier:  GPL-2.0-only                               #
###############################################################################

FROM									\
	alpine/git@sha256:3640856b23fc294757fd1d0d8b6aaecd689e8f234df8513e7b789f04c99ac600 \
			AS git

RUN									\
	git clone							\
	    --single-branch						\
	    --branch master						\
	    https://github.com/alejandro-colomar/dns.alejandro-colomar.es.git \
	    /repo

###############################################################################

FROM									\
	debian@sha256:aa1db351593d2849034c0395bc604dd65aa80ae4471da4a37a0c38e30aed3ab8 \
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
COPY	--from=git	/repo/etc/bind/named.d/zones.conf		\
			/etc/bind/named.d/zones.conf
COPY	--from=git	/repo/etc/bind/named.d/forward.local.db	\
			/etc/bind/named.d/forward.local.db
COPY	--from=git	/repo/etc/bind/named.d/reverse.local.db	\
			/etc/bind/named.d/reverse.local.db
RUN									\
	mkdir -p /etc/bind/named.d					&& \
	echo 'include "/etc/bind/named.d/zones.conf";'		\
			>> /etc/bind/named.conf.local

###############################################################################
