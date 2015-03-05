#!/bin/bash

# sed -i 's/^mesg n$/tty -s \&\& mesg n/g' /root/.profile

if [[ -d /vagrant/vagrant-ansible.pub ]] ; then
  cat /vagrant/vagrant-ansible.pub >> ~/.ssh/authorized_keys
fi
