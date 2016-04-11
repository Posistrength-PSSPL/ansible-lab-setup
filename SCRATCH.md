```

virt-install 	--name demo \
		--os-type linux \
  		--memory 2048 \ 
		--disk size=8 \
		--location /tmp/CentOS-7-x86_64-Minimal-1511.iso \
		--graphics none \
		--extra-args 'console=ttyS0 ks=http://192.168.0.8/el7.ks'

Above fails on: dracut-initqueue[534]: Warning: dracut-initqueue timeout - starting timeout scripts


virt-install --name demo --memory 2048 --disk size=8 --location /tmp/CentOS-7-x86_64-Minimal-1511.iso --graphics none --extra-args 'console=ttyS0,115200 serial' --os-type linux

Manual install results in:

localhost login: root
Password:
[root@localhost ~]# ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: ens2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT qlen 1000
    link/ether 52:54:00:4c:af:7d brd ff:ff:ff:ff:ff:ff




# This works, just need to pass in a working kickstart and resolve networking:
# virt-install --name demo --memory 2048 --disk size=8 --location /tmp/CentOS-7-x86_64-Minimal-1511.iso --graphics none --extra-args 'console=ttyS0,115200 serial' --os-type linux

# Will need to append: --extra-args='ks=ftp://192.168.0.43/pub/centos/ks.cfg ksdevice=ens3 ip=192.168.122.90 netmask=255.255.255.0 gateway=192.168.122.1 dns=8.8.8.8'




# [root@wmcdonal-x230 ~]# virt-install --name demo --memory 2048 --disk size=8 --cdrom /home/wmcdonal/ansible-lab-setup/files/CentOS-7-x86_64-Minimal-1511.iso --graphics none
#
#
## virt-install CentOS from network
## https://raymii.org/s/articles/virt-install_introduction_and_copy_paste_distro_install_commands.html#CentOS_7
#
#virt-install \
#--name rhel \
#--ram 1024 \
#--disk path=/var/lib/libvirt/images/target1.qcow2,size=8 \
#--vcpus 1 \
#--os-type linux \
#--os-variant rhel \
#--network bridge=virbr0 \
#--graphics none \
#--console pty,target_type=serial \
#--location 'https://www.mirrorservice.org/sites/mirror.centos.org/7/os/x86_64/' \
#--extra-args 'console=ttyS0,115200n8 serial'
#
#
#[root@wmcdonal-x1 ~]# virt-install --name rhel7 --ram 1024 --disk path=/var/lib/libvirt/images/target1.qcow2,size=8 --vcpus 1 --os-type linux --os-variant rhel7 --network bridge=virbr0 --graphics none --console pty,target_type=serial --location 'https://www.mirrorservice.org/sites/mirror.centos.org/7/os/x86_64/' --extra-args 'console=ttyS0,115200 serial'
#
```
