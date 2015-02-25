VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "ubuntu/trusty64" 

    config.vm.network :private_network, ip: "192.168.33.10" 

    config.vm.provider :virtualbox do |vb|
       vb.customize ["modifyvm", :id, "--memory", "4096"]
    end

    config.vm.provision :shell, :inline => "sudo apt-get upgrade -y && sudo apt-get install -y git vim libxslt1-dev libmysqlclient-dev"
end

