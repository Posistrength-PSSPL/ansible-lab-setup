install
lang en_GB.UTF-8
keyboard gb
timezone Europe/London
auth --useshadow --enablemd5
selinux --disabled
firewall --disabled
services --enabled=NetworkManager,sshd
eula --agreed
ignoredisk --only-use=vda
reboot

bootloader --location=mbr
zerombr
clearpart --all --initlabel
part swap --asprimary --fstype="swap" --size=1024
part /boot --fstype xfs --size=200
part pv.01 --size=1 --grow
volgroup rootvg01 pv.01
logvol / --fstype xfs --name=lv01 --vgname=rootvg01 --size=1 --grow

rootpw --iscrypted $1$X/10t/eV$D.GvqWoWImRWGlCdI/L.t1

# repo --name=base --baseurl=https://www.mirrorservice.org/sites/mirror.centos.org/7/os/x86_64/
# url --url="https://www.mirrorservice.org/sites/mirror.centos.org/7/os/x86_64/"

%packages --nobase --ignoremissing
@core
%end

%post
mkdir ~root/.ssh && chmod 700 ~root/.ssh
cat <<EOF > ~root/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKmNGClhHO7aprRBeMVOTqXkQJqE1sCSyjrI4pnYT2cXOLwH1qOmsXu3TamvXBIuHf9V4DnXR6wzderoHJpjUceRrZmMwY9uIj0mmZdT1bqwzjqdniLk4ZRhI61WyBSR7Pjf2ieyLuxwWmfAFrdDeq6CY3G9G/eFUW3cW6XJRSCudsBKOr2YLI34qVrHAXtYWFARoNtPVSnith7dm8ohhNv7pohGEEugH8GhU+o7yF1QKzAjTnapc2VWe7Q7WWoMDr/9pJxZ9nK3mXPtFVQU5SOLs5CSRuy194K60N8eFxy0+J9Ei7YddnyFBe1yWga/bj2SW4c6oU0z0bNV+yfbp9 wmcdonald@gmail.com-2016
EOF
chmod 600 ~root/.ssh/authorized_keys
%end
