#!/bin/bash
## Install git
zypper addrepo http://download.opensuse.org/repositories/devel:/tools:/scm/SLE_11_SP2/devel:tools:scm.repo
zypper --non-interactive --no-gpg-checks install git
