#!/bin/bash
set -e
apt update -y
apt install -y software-properties-common
add-apt-repository --yes --update ppa:ansible/ansible
apt install -y ansible
