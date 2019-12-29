# Setup a Raspberry Pi for software development

I want to explore if I can manage to do some serious coding with just an
    iPad Mini 4 and a Raspberry Pi.

My objectives are:
* Able to develop software in Java and Python
* Able to perform software deployment and maintenance using Ansible

## Hardwares

* Raspberry Pi 3 B+
    * MicroSD Card (32GB)
    * Case
    * USB Flash Drive
    * Power cable
* iPad Mini 4
* Mobile WiFi (e.g. Huawei E5573C)
* UTP Cable (Straight)
* Desktop Computer

## Softwares

### Software Development:

1. JDK 1.8 and 11 (openjdk-8-jdk and openjdk-11-jdk)
    64-bit version but I'm not familiar with the OS configuration so I'll just
    stick with Raspbian)
2. Gradle 6.0.1
3. Maven 3.6.3

### Linux Packages:
1. git
2. tmux
3. fish
4. mosh


## Prepare the SD Card

1. Download the [Raspbian Buster Lite](bit.ly/2Q44fuo). We are setting up a
    headless Raspberry Pi so we don't need the graphical user interface
2. Use [balenaEtcher](https://www.balena.io/etcher/) to write the
    Raspbian OS the the SD card
3. Create an empty ssh file in the SD card boot partition. Initial boot-up
    of the Raspberry Pi will look for the ssh file. When it is found it
    enables sshd

    ```
   $ touch /Volumes/boot/ssh
    ```

4. Eject the SD card and transfer it to the Raspberry Pi


## Determine the IP Address

1. Boot-up the Raspberry Pi
2. Determine the IP address of the Raspberry Pi

    ```
    $ ping raspberrypi.local

    PING raspberrypi.local (10.91.145.100): 56 data bytes
    64 bytes from 10.91.145.100: icmp_seq=0 ttl=64 time=0.587 ms
    ```

    This will reveal the IP address of the Raspberry Pi.
    ***raspberrypi.local*** is the default hostname. It will be changed later on.

3. Login to the Raspberry Pi

    ```
   $ ssh pi@10.91.145.100
   
   Password is: raspberry
    ```


## Configure the Raspberry Pi via Ansible

1. Try to ping via Ansible

    ```
   $ ansible all -i inventory/raspberry -m ping

    node01 | SUCCESS => {
        "ansible_facts": {
            "discovered_interpreter_python": "/usr/bin/python"
        },
        "changed": false,
        "ping": "pong"
    }
    ```

2. Execute Ansible

    ```
    $ ansible-playbook -i inventory/raspberrypi site.yml --tags raspberrypi
    ```


## Future packages to install
1. kubectl
2. Samba still has issue with authentication
3. Transmission

## TODO:
1. Disable unattended-upgrade
    - It justs consumes additional CPU and RAM and we would like our system to be pretty stable.
      Not affected by unintentional package upgrades.

https://wiki.debian.org/UnattendedUpgrades

sudo systemctl mask unattended-upgrade.service

The functionality on unattended-upgrades is automatically enabled after the installation of 16.04 Xenial Server. I mistakenly didn't really disable it so observed the unexpected behaviors above. Method Two here I had followed is unlikely effective.

To properly disable the automatic updates, we need change the configuation on /etc/apt/apt.conf.d/20auto-upgrades from:

APT::Periodic::Unattended-Upgrade "1";
to:
APT::Periodic::Unattended-Upgrade "0"; 


2. Disable bluetooth
/boot/config.txt
dtoverlay=pi3-disable-bt

## Tips

To troubleshoot disk mounting problems

```
$ dmesg
```

To change the wifi connection:
```
$ wpa_cli -i wlan0 select_network $(wpa_cli -i wlan0 list_network | grep example_name | cut -f 1)
```
