################################################################################
##      Copyright (C) 2020        Alejandro Colomar Andrés                    ##
##      SPDX-License-Identifier:  GPL-2.0-only                                ##
################################################################################
##
## Generate the config maps and secrets
## ====================================
##
################################################################################


################################################################################
##	source								      ##
################################################################################


################################################################################
##	definitions							      ##
################################################################################


################################################################################
##	functions							      ##
################################################################################
## sudo
function kube_create_configmaps()
{
	local	namespace="$1";

	kubectl create configmap "etc-bind-cm"				\
		--from-file "/run/configs/dns/etc/bind/named.conf"	\
		-n "${namespace}";
}

## sudo
function kube_delete_configmaps()
{
	local	namespace="$1";

	kubectl delete configmap "etc-bind-cm" -n "${namespace}";
}

## FIXME
## sudo
function kube_create_secrets()
{
	local	namespace="$1";

	kubectl create secret generic "var-bind-master-sec"		\
		--from-file "/run/secrets/dns/var/bind/master/10.168"	\
		--from-file "/run/secrets/dns/var/bind/master/alejandro-colomar.es" \
		-n "${namespace}";
}

## FIXME
## sudo
function kube_delete_secrets()
{
	local	namespace="$1";

	kubectl delete secret generic "var-bind-master-sec" -n "${namespace}";
}


################################################################################
##	end of file							      ##
################################################################################
