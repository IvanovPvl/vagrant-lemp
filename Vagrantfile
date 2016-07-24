#!/usr/bin/env ruby
#^syntax detection

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true
  config.vm.synced_folder "./", "/home/ubuntu/project", create: true, group: "www-data", owner: "ubuntu"

  config.vm.provider :virtualbox do |vb|
    vb.name = "LEMP box"
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.provision :shell, path: "provision/setup.sh", privileged: false
end
