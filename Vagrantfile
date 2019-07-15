Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.box_version = "1905.1"
  config.vm.box_check_update = false

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2000"
    vb.cpus = "2"
  end

  config.ssh.insert_key = false
  config.ssh.private_key_path = ["./ssh_keys/id_rsa", "~/.vagrant.d/insecure_private_key"]
  config.vm.provision "file", source: "./ssh_keys/id_rsa.pub", destination: "~/.ssh/authorized_keys"
  config.vm.provision "shell", inline: <<-EOC
    sudo sed -i -e "\\#PasswordAuthentication yes# s#PasswordAuthentication yes#PasswordAuthentication no#g" /etc/ssh/sshd_config
    sudo systemctl restart sshd
  EOC

  config.vm.define "node01" do |node|
    node.vm.hostname = "node01"
    node.vm.network "private_network", ip: "172.16.170.240"
    node.vm.provider "virtualbox" do |vb|
        vb.name = "node01"
    end
  end

end
