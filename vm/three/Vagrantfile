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

  (1..3).each do |i|
    config.vm.define "node0#{i}" do |node|
      node.vm.hostname = "node0#{i}"
      node.vm.network "private_network", ip: "192.168.1.11#{i}"
      node.vm.provider "virtualbox" do |vb|
        vb.name = "node0#{i}"
      end
    end
  end

end
