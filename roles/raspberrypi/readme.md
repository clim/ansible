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

1. JDK 1.8 32-bit (Raspbian Buster is only available in 32-bit. Ubuntu Core has a
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

1. Download Java 1.8 32-bit from [Oracle](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)

    The file to download is:

    ```
   jdk-8u231-linux-arm32-vfp-hflt.tar.gz
    ```

    NOTE: This will require a valid Oracle account before it can be downloaded

2. Try to ping via Ansible

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

3. Execute Ansible

    ```
    $ ansible-playbook -i inventory/raspberrypi site.yml --tags raspberrypi
    ```


## Post Configuration

### Java

To change between version use update-alternatives command.


## Future packages to install
1. docker and docker-compose
2. kubectl
3. Samba file sharing
