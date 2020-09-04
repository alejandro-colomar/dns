################################################################################
##      Copyright (C) 2020        Alejandro Colomar Andrés                    ##
##      SPDX-License-Identifier:  GPL-2.0-only                                ##
################################################################################
##
## Deploy stack
## ============
##
################################################################################


################################################################################
##	source								      ##
################################################################################
source	etc/dns/config.sh;
source	lib/dns/deploy/common/config.sh;
source	lib/dns/deploy/kubernetes/config.sh;


################################################################################
##	definitions							      ##
################################################################################


################################################################################
##	functions							      ##
################################################################################
## sudo
function kube_deploy()
{
	local	namespace="dns";

	kubectl create namespace "${namespace}";
	kube_create_configmaps	"${namespace}";
	kubectl apply -f "etc/docker/kubernetes/deployment.yaml" -n "${namespace}";
	kubectl apply -f "etc/docker/kubernetes/network-policy.yaml" -n "${namespace}";
	kubectl apply -f "etc/docker/kubernetes/service.yaml" -n "${namespace}";
}


################################################################################
##	end of file							      ##
################################################################################
