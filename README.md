# tiny-linux-system
This is a mini linux system which is built with busybox, qemu and linux with version 7.4.2.It's a test system ,so you can verify simple linux command, or  run linux execuable file and  some other interstring things.

Let's start it!
A Complete Guide to Building a Minimal Linux System from Scratch.
In this approach, we use the Linux Kernel, BusyBox, cpio, and QEMU. We will compile the kernel from source, build the user space, and finally use QEMU to launch an interactive, minimal Linux system.

# 1. Prepare the Debian build environment
Install build tools and dependencies
``` shell
sudo apt update

sudo apt install -y \
build-essential \
libncurses-dev \
bison \
flex \
libssl-dev \
libelf-dev \
bc \
git \
wget \
curl \
cpio \
rsync \
qemu-system-x86 \
qemu-utils \
fakeroot \
file \
xz-utils \
make \
gcc \
pkg-config

```

# 2. build Linux kernel
```shell

# generate x86-64 default configuration
make x86_64_defconfig

# generate default configuration
make menuconfig

# This is built file bzImage, so it's linux kernel file.
ls -lh arch/x86/boot/bzImage

# download busybox project
cd ~/linux/busybox/busybox-1.36.1

# generate default configuration
make defconfig

# open configuration UI
make menuconfig

# enable this
setting---->
        Build static binary(no shared libs)

# static build busybox, j2 means cpu core sum,num more large, run time more little.
make -j2

# install busybox, create rootfs

mkdir -p /linux/rootfs
cd ~/linux/busybox/busybox-1.36.1
make CONFIG_PREFIX=$HOME/linux/rootfs install

# create linux path
cd ~/linux/rootfs
mkdir -p dev proc sys etc tmp root home

# configure linux intilize program.

cat > etc/inittab <<'EOF'
::sysinit:/etc/init.d/rcS
::askfirst:-/bin/sh
::ctrlaltdel:/bin/umount -a -r
::shutdown:/bin/umount -a -r
EOF

# configure initilize scripts

mkdir -p etc/init.d

cat > etc/init.d/rcS <<'EOF'
#!/bin/sh

mount -t proc proc /proc
mount -t sysfs sysfs /sys
mount -t devtmpfs devtmpfs /dev

echo "================================"
echo "Welcome to My Linux System!"
echo "BusyBox initialization complete."
echo "================================"
EOF

# give execuable permissions
chmod +x etc/init.d/rcS

# make rootfs mirror
find . -print0 | cpio --null -ov --format=newc > ~/linux/rootfs.cpio

```

# 3.use QEMU start linux
```
ls -lh ~/linux-7.2.4/arch/x86/boot/bzImage

qemu-system-x86_64 --version

```

# 4. Start you custom linux system.
```
./start.sh
```

# 5. linux system UI 
When run start.sh, you can see your custom linux system, such as 

================================
Welcome to My Linux System!
BusyBox initialization complete.
================================

Please press Enter to activate this console.
~ #

# 6. END
When you finish your system, give me a star if this projectt help you to learn linux system, thank you so much! 

Love U,Bye Bye!



