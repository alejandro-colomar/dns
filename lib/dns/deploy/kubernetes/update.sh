################################################################################
##      Copyright (C) 2020        Alejandro Colomar Andrés                    ##
##      SPDX-License-Identifier:  GPL-2.0-only                                ##
################################################################################
##
## Update stack
## ============
##
################################################################################


################################################################################
##	source								      ##
################################################################################
source	lib/dns/deploy/common/config.sh;
source	lib/dns/deploy/kubernetes/config.sh;
source	lib/dns/deploy/kubernetes/delete.sh;
source	lib/dns/deploy/kubernetes/deploy.sh;


################################################################################
##	definitions							      ##
################################################################################


################################################################################
##	functions							      ##
################################################################################
function kube_update__()
{

	kubectl delete -f "etc/docker/kubernetes/service.yaml" -n "${namespace}";
	kubectl delete -f "etc/docker/kubernetes/network-policy.yaml" -n "${namespace}";
	kubectl delete -f "etc/docker/kubernetes/deployment.yaml" -n "${namespace}";
	kube_delete_configmaps	"${namespace}";

	kube_create_configmaps	"${namespace}";
	kubectl apply -f "etc/docker/kubernetes/deployment.yaml" -n "${namespace}";
	kubectl apply -f "etc/docker/kubernetes/network-policy.yaml" -n "${namespace}";
	kubectl apply -f "etc/docker/kubernetes/service.yaml" -n "${namespace}";
}

## sudo
function kube_update()
{

	prepare_configs							&& \
	kube_update__;
}

## sudo
function kube_update_hard()
{

	prepare_configs							&& \
	kube_delete							&& \
	kube_deploy;
}


################################################################################
##	end of file							      ##
################################################################################
