#!/bin/sh

# [-t] ---SSH  key algorithm  is RSA; [-N] ---key code is null; [-f] ---specified key  file dir
rm -rf ~/.ssh/{knowm_hosts,id_rsa*}
ssh-keygen -t RSA -N '' -f ~/.ssh/id_rsa
