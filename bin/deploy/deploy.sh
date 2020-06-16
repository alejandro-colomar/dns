#!/bin/bash -x
##	./bin/deploy.sh
################################################################################
##	Copyright (C) 2020	  Alejandro Colomar Andrés		      ##
##	SPDX-License-Identifier:  GPL-2.0-only				      ##
################################################################################
##
## Deploy stack
## ============
##
################################################################################


################################################################################
##	source								      ##
################################################################################
source	lib/libalx/sh/sysexits.sh;


################################################################################
##	definitions							      ##
################################################################################
ARGC=0;

COMPOSE_FNAME="etc/docker/swarm/docker-compose.yaml";


################################################################################
##	functions							      ##
################################################################################
function deploy_stack()
{
	local	version="$(dit describe --tags)";
	local	stack_name="dns_${version}";

	docker deploy -c "${COMPOSE_FNAME}" ${stack_name}
}


################################################################################
##	main								      ##
################################################################################
function main()
{

	./bin/deploy/config.sh;
	deploy_stack;
}


################################################################################
##	run								      ##
################################################################################
argc=$#;
if [ ${argc} -ne ${ARGC} ]; then
	echo	"Illegal number of parameters (Requires ${ARGC})";
	exit	${EX_USAGE};
fi

main;


################################################################################
##	end of file							      ##
################################################################################
