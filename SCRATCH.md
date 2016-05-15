OK, this one definitely works. It needs http enabled on the libvirt host obviously so be sure that's done
```

# virt-install --name demo --memory 2048 --disk size=8,pool=images --location /tmp/CentOS-7-x86_64-Minimal-1511.iso --graphics none --extra-args 'console=ttyS0,115200 serial ks=http://192.168.122.1/el7.ks' --os-type linux


- ID default firewalld zone
- ID default libvirt storage pool
- ID libvirt bridged network & appropriate VM interface(s) (?)
- firewalld rule for bridged network (?)

```

  783  virsh destroy centos01.example.com; virsh undefine centos01.example.com

