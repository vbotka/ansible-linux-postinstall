#!/bin/sh

(cd annotation && ansible-playbook pb-annotations.yml)
ansible-playbook playbook.yml
make html
