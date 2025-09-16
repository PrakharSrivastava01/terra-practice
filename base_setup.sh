#!/bin/bash
set -e
apt update -y
# Common packages for all nodes
apt install -y git unzip curl
