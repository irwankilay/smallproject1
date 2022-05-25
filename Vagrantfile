Vagrant.configure("2") do |config|

  config.vm.define "svr01" do |svr01|
    svr01.vm.box = "ubuntu/focal64"
    svr01.vm.hostname = "svr01"
    svr01.vm.network "private_network", ip: "192.168.56.11"
    svr01.vm.provision "shell", path: "landingpage.sh"

  end

  config.vm.define "svr03" do |svr03|
    svr03.vm.box = "ubuntu/focal64"
    svr03.vm.hostname = "svr03"
    svr03.vm.network "private_network", ip: "192.168.56.13"
    svr03.vm.provision "shell", path: "pesbuk.sh"

  end
end
