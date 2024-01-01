#cloud-config

package_upgrade: false

packages:
  - iotop
  - python3
  - qemu-guest-agent

runcmd:
${runcmd}

fqdn: ${hostname}

# disable ssh access as root.
disable_root: true

# if you want to allow SSH with password, set this to true
ssh_pwauth: false


users:
%{ if root_passwd != "" }
  - name: root
    lock_passwd: false
    hashed_passwd: ${root_passwd}
%{ endif }
  - name: ${ssh_admin}
    gecos: Kubernetes Clustorious
    lock_passwd: false
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, admin
    system: False
    ssh_authorized_keys: ${ssh_keys}
    shell: /bin/bash
    hashed_passwd: ${ssh_admin_passwd}
%{ if local_admin != "" }
  - name: ${local_admin}
    gecos: Local admin (no SSH)
    lock_passwd: false
    sudo: ALL=(ALL) ALL
    # $ mkpasswd -m SHA-512 test_password -R 4096
    hashed_passwd: ${local_admin_passwd}
    shell: /bin/bash
%{ endif }

write_files:
  - path: /etc/ssh/sshd_config
    content: |
        Port 22
        Protocol 2
        HostKey /etc/ssh/ssh_host_rsa_key
        HostKey /etc/ssh/ssh_host_dsa_key
        HostKey /etc/ssh/ssh_host_ecdsa_key
        HostKey /etc/ssh/ssh_host_ed25519_key
        UsePrivilegeSeparation yes
        KeyRegenerationInterval 3600
        ServerKeyBits 1024
        SyslogFacility AUTH
        LogLevel INFO
        LoginGraceTime 120
        PermitRootLogin no
        StrictModes yes
        RSAAuthentication yes
        PubkeyAuthentication yes
        IgnoreRhosts yes
        RhostsRSAAuthentication no
        HostbasedAuthentication no
        PermitEmptyPasswords no
        ChallengeResponseAuthentication no
        X11Forwarding yes
        X11DisplayOffset 10
        PrintMotd no
        PrintLastLog yes
        TCPKeepAlive yes
        AcceptEnv LANG LC_*
        Subsystem sftp /usr/lib/openssh/sftp-server
        UsePAM yes
        AllowUsers ${ssh_admin}

growpart:
    mode: auto
    devices:
      - "/"

resize_rootfs: true

timezone: ${time_zone}