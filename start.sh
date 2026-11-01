qemu-system-x86_64 \
    -kernel /home/fzp/linux/tiny-linux-system/bzImage \
    -initrd /home/fzp/linux/tiny-linux-system/rootfs.cpio \
    -m 512M \
    -smp 2 \
    -nographic \
    -append "console=ttyS0 rdinit=/sbin/init"
