# Purpose

This reository is intended to show the steps required to:

1. Prepare a Fedora system to create and run libvirt VMs
2. Automatically create and configure multiple VMs via Kickstart
3. Perform any required post-install configuration

It's also intended to show the evolving path a user is likely to take from an intial monolithic task-by-task playbook to get something done rapdily, through to more modular, role structures suitable for reuse/wider distribution.

# Manual steps

Before automating any set of tasks, it's necessary to understand the individual technical steps to achieve the end-goal.

In order to prepare a vanilla Fedora system to support a small, self-contained lab it is necessary to:

1. Install the libvirt Yum/DNF group to provide hypervisor support
2. Enable the libvirt service
3. Install virt-install to support command-line installation of VMs

In order to provision VMs it's necessary to:

1. Install Apache to serve Kickstart files via HTTP
2. Enable the Apache service
3. Allow HTTP traffic through the firewall
4. Create an appropriate Kickstart file available via HTTP
5. Have media available to boot and install VMs

In order to install an operating system into the VMs it is necessary to:

1. Run virt-install with the appropriate command line parameters
2. Wait for virt-install to complete
3. Start the VM

In total, these steps would involve the following:

```
# dnf groupinstall virtualization
# systemctl enable libvirtd.service
# systemctl start libvirtd.service
# dnf install virt-install

# dnf install httpd
# systemctl enable httpd.service
# systemctl start httpd.service
# firewall-cmd --add-service=http --permanent 
# firewall-cmd --reload
# cat <<EOF > /var/www/html/el7.ks
install
lang en_GB.UTF-8
keyboard gb
timezone Europe/London
auth --useshadow --enablemd5
selinux --disabled
firewall --disabled
services --enabled=NetworkManager,sshd
eula --agreed
ignoredisk --only-use=sda
reboot
bootloader --location=mbr
zerombr
clearpart --all --initlabel
part swap --asprimary --fstype="swap" --size=1024
part /boot --fstype xfs --size=200
part pv.01 --size=1 --grow
volgroup rootvg01 pv.01
logvol / --fstype xfs --name=lv01 --vgname=rootvg01 --size=1 --grow
rootpw --iscrypted CRYPTEDPASS
%packages --nobase --ignoremissing
@core
%end
EOF

# curl https://www.mirrorservice.org/sites/mirror.centos.org/7/isos/x86_64/CentOS-7-x86_64-Minimal-1511.iso -o /tmp/CentOS-7-x86_64-Minimal-1511.iso

# export VMNAME=demovm
# export KICKSERVER=192.168.122.1
# virt-install --name ${VMNAME} \
--memory 2048 \
--disk size=8,pool=images \
--location /tmp/CentOS-7-x86_64-Minimal-1511.iso \
--graphics none \
--extra-args "console=ttyS0,115200 serial ks=http://${KICKSERVER}/el7.ks' \
--os-type linux 

# virsh list --all | grep ${VMNAME}
# virsh start ${VMNAME}
```

# Using the repository

1. Clone the repo

``` git clone git@github.com:wmcdonald404/ansible-lab-setup.git```

##  Monolithic Playbook

1. Check out the first version of the repository

# What does the playbook do

1. play #1 (install libvirt)
  1. install libvirt virtualisation group
  1. install qemu-img
  1. install virt-install
1. play #2 (prepare server for kickstart)
  1. install apache httpd
  1. configure the apache service
  1. permit http traffic
  1. create a kickstart file
  1. copy boot media
1. play #3 (create virtual machines)
  1. create the virtual machine(s)


```
[wmcdonal@wmcdonal-x1 ansible-lab-setup]$ ansible-playbook setup.yml --list-tasks

playbook: setup.yml

  play #1 (install libvirt):	TAGS: [libvirt,prereqs]
    install libvirt virtualisation group	TAGS: [libvirt, packages, prereqs]
    install qemu-img	TAGS: [libvirt, packages, prereqs]
    install virt-install	TAGS: [libvirt, packages, prereqs]

  play #2 (prepare server for kickstart):	TAGS: []
    install apache httpd	TAGS: [apache, packages]
    configure the apache service	TAGS: [apache, services]
    permit http traffic	TAGS: [firewall]
    create a kickstart file	TAGS: [apache, content]
    copy boot media	TAGS: [content, iso]

  play #3 (create virtual machines):	TAGS: []
    create the virtual machine(s)	TAGS: [vmcreate]
```

# Resources

https://fedoraproject.org/wiki/Getting_started_with_virtualization

https://github.com/hicknhack-software/ansible-libvirt Roles that help create and manage multiple libvirt virtual machines.

http://docs.ansible.com/ansible/playbooks_loops.html#using-register-with-a-loop

http://thinkansible.com/waiting-on-tasks/

https://github.com/ansible-provisioning/workshop-provisioning
