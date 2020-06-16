
________________________________________________________________________________

All scripts in this repository are set up so that they have to be run
from the root directory of this repository.


________________________________________________________________________________

Versioning
==========

Start working in a new branch
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: BASH

	git checkout -b <branch>;
	./bin/release/port.sh 32053;
	git commit -a -m "Branch $(git branch --show-current)";

Pre-release an experimental version
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Experimental pre-releases are named ending with ``-aX`` or ``-bX``.

.. code-block:: BASH

	exp_version=<exp-version>;
	./bin/release/port.sh 32053;
	git commit -a -m "Pre-release ${exp_version}";
	git tag ${exp_version};

Pre-release a release-critical version
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Release-critical pre-releases are named ending with ``-rcX``.

.. code-block:: BASH

	rc_version=<rc-version>;
	./bin/release/port.sh 31053;
	git commit -a -m "Pre-release ${rc_version}";
	git tag -a ${rc_version} -m "";

Release a stable version
^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: BASH

	version=<version>;
	./bin/release/port.sh 30053;
	git commit -a -m "Release ${version}";
	git tag -a ${version} -m "";

Continue working in the current branch after a release
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: BASH

	./bin/release/port.sh 32053;
	git commit -a -m "Branch $(git branch --show-current)";


________________________________________________________________________________

Local deployment
================

This repository assumes a docker swarm is already running.  See
the `parent repository`_ to know how to prepare the machines for docker
swarm.

_`parent repository`: https://github.com/alejandro-colomar/alejandro-colomar.git

Releases use port 30053.
Release-critical pre-releases use port 31053.
Experimental deployments use ports 3x053 (x >= 2).

For a seamless deployment, the following steps need to be done:

- Assuming there is an old stack deployed at port 30053.

- Release a release-critical pre-release (see
  `Pre-release a release-critical version`_).

- Deploy the release-critical pre-release at port 31053:

.. code-block:: BASH

	sudo ./bin/deploy/deploy.sh;


- If the pre-release isn't good engough, that deployment has to be
  removed (see following command), and then work continues in the
  current branch (see
  `Continue working in the current branch after a release`_).  The
  current stable deployment is left untouched.

.. code-block:: BASH

	## Normally rc_version should match $(git describe --tags)
	rc_version=<rc-version>;
	docker stack rm dns_${rc_version};


- Else, if the pre-release passes the tests, the published port will
  be forwarded to 31053 (this is done in the parent repository).

- Release a new stable version (see `Release a stable version`_).

- Deploy the stable release at port 30053:

.. code-block:: BASH

	sudo ./bin/deploy/deploy.sh;

- The published port will be forwarded back to 30053 (this is done in
  the parent repository).

- Remove the deployment at port 31053:

.. code-block:: BASH

	## rc_version should end in ``-rcX``
	rc_version=<rc-version>;
	docker stack rm dns_${rc_version};


________________________________________________________________________________
