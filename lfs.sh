#!/bin/bash

export lfs=/mnt/lfs
export lfsP=/dev/sda2

sudo apt install bash binutils bison coreutils diffutils findutils gawk gcc grep gzip m4 make patch perl python sed tar texinfo xz

sudo parted /dev/sda << EOF
print
resizepart 1 60GB
y
y
mkpart primary ext4 60GB 75GB
quit
EOF
sudo mkfs -v -t ext4 $lfsP
sudo mkdir -pv $lfs
sudo mount -v -t ext4 $lfsP $lfs
sudo chown $USER $lfs

mkdir -v $lfs/sources

#TODO:download
wget --input-file=wget-list-sysv --continue --directory=$LFS/sources

mkdir -pv $LFS/etc
mkdir -pv $LFS/var
mkdir -pv $LFS/usr/bin
mkdir -pv $LFS/usr/lib
mkdir -pv $LFS/usr/sbin
for i in bin lib sbin;do 
    ln -sv usr/$i $LFS/$i 
done
case $(uname -m) in 
    x86_64) mkdir -pv $LFS/lib64 ;;
esac
mkdir -pv $LFS/tools

groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs 
passwd lfs 
chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}
case $(uname -m) in 
    x86_64) chown -v lfs $LFS/lib64 
esac
su - lfs

cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash 
EOF
