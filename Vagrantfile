Vagrant.configure("2") do |config|
  config.vm.define "docker-centos"
  config.vm.box = "centos/7"

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 443, host: 8443

  config.vm.provision :shell, path: "install-docker.sh"

  config.vm.provision :shell, path: "install-meshcentral.sh"

end

# -*- mode: ruby -*-
# vi: set ft=ruby :
