Vagrant.configure("2") do |config|

  config.vm.define "svr01" do |svr01|
    svr01.vm.box = "ubuntu/focal64"
    svr01.vm.hostname = "svr02"
    svr01.vm.network "private_network", ip: "192.168.56.11"
    svr01.vm.provision "shell", path: "landingpage.sh"

  end

  config.vm.define "svr02" do |svr02|
    svr02.vm.box = "ubuntu/focal64"
    svr02.vm.hostname = "svr02"
    svr02.vm.network "private_network", ip: "192.168.56.12"
    svr02.vm.provision "shell", path: "wordpress.sh"

  end
end
