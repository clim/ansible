# ansible
A set of ansible roles that I found useful over the years



## Includes the following roles
1. OS
2. Oracle 11g (11.2.0.4)
3. OS
4. Project Harbor
5. Java 8
6. Apache NiFi
7. Apache Zookeeper
8. User creation



## VM nodes for testing
1. Create users
2. Add sudo access to user
3. 

## Prerequisites

1. User to execute ansible must have sudo access
2. Server must be configured to have password-less sudo
    ```
    %wheel  ALL=(ALL)       NOPASSWD: ALL
    ```



## Configuration

1. Edit the inventory file to reflect the IP addresses on the target environment
2. Copy SSH private and public key to ssh_keys folder or execute generate_keys.sh
3. Test connection to the target servers
    ```
    $ ansible all -i inventory/dev -m ping -k
    ```


## Playbooks

### User
The first thing to do is to setup the ansible user which will perform all the ansible
    related tasks

    $ ansible-playbook -i inventory/dev site.yml --tags user -e "ansible_user=username" -k

Where:
* username - Refers to the initial username created by the infra team
* -k - Prompt for the password. Since an ssh key login is not yet created

To verify that a user is indeed create we can now ping the servers using the credentials
    of the new user

    $ ansible all -i inventory/dev -m ping -e "ansible_user=ansible ansible_ssh_private_key_file=./ssh_keys/id_rsa"


### OS
Install packages that are needed to conveniently access and monitor the servers. Later on
it will contain more sophisticated stuff such as default sshd configuration etc.

    $ ansible-playbook -i inventory/dev site.yml --tags os

### Java
The Java Runtime Environment needs to be manually downloaded from the
[Oracle](https://www.oracle.com/technetwork/java/javase/downloads/server-jre8-downloads-2133154.html)
website.

### Apache NiFi Single Instance

### Apache Zookeeper

### Apache NiFi


### Oracle
The Oracle installer files needs to be be manually downloaded from the Oracle website.
[Disk 1](https://download.oracle.com/otn/linux/oracle11g/R2/linux.x64_11gR2_database_1of2.zip)
[Disk2](https://download.oracle.com/otn/linux/oracle11g/R2/linux.x64_11gR2_database_2of2.zip)




### Project Harbor



## Common errors encountered

1. ```sftp transfer mechanism failed```

    Add the following in ```/etc/ssh/sshd_config```

    ```
    Subsystem sftp /usr/libexec/openssh/sftp-server
    ```
