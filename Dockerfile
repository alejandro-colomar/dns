###############################################################################
#        Copyright (C) 2020        Sebastian Francisco Colomar Bauza          #
#        Copyright (C) 2020        Alejandro Colomar Andrés                   #
#        SPDX-License-Identifier:  GPL-2.0-only                               #
###############################################################################

FROM									\
	debian@sha256:aa1db351593d2849034c0395bc604dd65aa80ae4471da4a37a0c38e30aed3ab8 \
			AS dns

RUN									\
	apt-get update							&& \
	apt-get install -y bind9					&& \
	apt-get autoremove --purge -y

RUN									\
	mkdir -p /etc/bind/named.d					&& \
	echo 'include "/etc/bind/named.d/zones.conf";'		\
			>> /etc/bind/named.conf.local

###############################################################################
