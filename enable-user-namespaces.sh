#!/usr/bin/env bash

# Borrowed from
# * https://github.com/procszoo/procszoo/wiki/How-to-enable-%22user%22-namespace-in-RHEL7-and-CentOS7%3F
# * https://gist.github.com/dpneumo/279d6bc5dcbe5609cfcb8ec48499701a
# * https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux_atomic_host/7/html-single/getting_started_with_containers/index

enable-user-namespaces () {

  # Add the namespace.unpriv_enable=1 option to the kernel (vmlinuz*) command line.
  grubby --args="user_namespace.enable=1" --update-kernel="$(grubby --default-kernel)"

  # Add a value to the user.max_user_namespaces kernel tuneable so it is set permanently as follows:
  echo "user.max_user_namespaces=15076" >> /etc/sysctl.conf

  # Assign users and groups to be mapped by user namespaces. 
  echo dockremap:808080:1000 >> /etc/subuid
  echo dockremap:808080:1000 >> /etc/subgid

  # Copy daemon.json which enables User Namespaces
  # TODO: What if daemon.json already exists?
  cp -v /vagrant/daemon.json /etc/docker/daemon.json
}

enable-user-namespaces

echo "Reboot the system"

echo "After reboot, check that User Namespaces are enabled per https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux_atomic_host/7/html-single/getting_started_with_containers/index." 
