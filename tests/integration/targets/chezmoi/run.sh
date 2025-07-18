#!/bin/sh

set -eux

ansible-playbook -i inventory test.yml --connection=local
