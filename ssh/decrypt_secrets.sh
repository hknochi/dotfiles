#!/usr/bin/env bash

cd ~/.dotfiles/ssh

keybase decrypt id_boot2docker.asc -o id_boot2docker
keybase decrypt id_boot2docker.pub.asc -o id_boot2docker.pub

keybase decrypt mfrommhold_id_rsa.asc -o mfrommhold_id_rsa
keybase decrypt mfrommhold_id_rsa.pub.asc -o mfrommhold_id_rsa.pub

# eof