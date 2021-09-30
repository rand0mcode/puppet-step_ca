Vagrant.configure("2") do |config|
  config.vm.box = "centos/8"

  config.vbguest.installer_options = { allow_kernel_upgrade: true }
  config.vm.synced_folder ".", "/etc/puppetlabs/code/environments/production/modules/step_ca", type: "virtualbox"
  config.vm.provision "shell", inline: "yum install -y https://yum.puppet.com/puppet7-release-el-8.noarch.rpm"
  config.vm.provision "shell", inline: "yum install -y glibc-langpack-de puppet-agent"
  config.vm.provision "shell", inline: "puppet module install puppet-archive"
  config.vm.provision "shell", inline: "puppet module install puppet-systemd"
end
