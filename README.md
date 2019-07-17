# ansible
A set of ansible roles that I found useful over the years



## Includes the following roles
1. Oracle 11g (11.2.0.4)
2. Project Harbor
3. Apache NiFi
4. Apache Zookeeper
5. User creation



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
    $ ansible all -i inventory/dev -m ping
    ```


## Playbooks

### User

### Oracle

### Apache Zookeeper

### Apache NiFi

### Project Harbor



## Common errors encountered

1. ```sftp transfer mechanism failed```

    Add the following in ```/etc/ssh/sshd_config```

    ```
    Subsystem sftp /usr/libexec/openssh/sftp-server
    ```
