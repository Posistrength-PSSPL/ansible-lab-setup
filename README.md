# Getting started

1. Clone the repo

``` git clone git@github.com:wmcdonald404/ansible-lab-setup.git```

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
