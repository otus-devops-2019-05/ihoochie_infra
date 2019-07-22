#!/bin/bash
set -e

sudo cp /tmp/mongod.conf /etc/mongod.conf

sudo systemctl restart mongod
