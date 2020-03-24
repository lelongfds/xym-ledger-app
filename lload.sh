#!/bin/bash -i
source ~/ledger/bin/activate
export BOLOS_ENV=~/bolos-devenv
export BOLOS_SDK=~/nanos-secure-sdk
export SCP_PRIVKEY=9a12e73419ce638eb3b497aeda3d23748d4216febec4e17e912dfb065e2b2f0c
make clean && make load