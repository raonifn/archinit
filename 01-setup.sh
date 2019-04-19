#!/bin/bash -xe

dir=$(dirname $0)

ln -sf /usr/share/zoneinfo/Brazil/East /etc/localtime
hwclock --systohc

sed -i "s/#en_US.UTF-8/en_US.UTF8/g" /etc/locale.gen
locale-gen
echo 'LANG=EN_US.UTF-8' > /etc/locale.conf
echo 'export LANG=en_US.UTF-8' >> /etc/profile

echo 'KEYMAP=br-abnt2' > /etc/vconsole.conf

echo 'icedearth' > /etc/hostname

cat > /etc/hosts  <<END
127.0.0.1	localhost
::1		localhost
127.0.1.1	icedearth.localdomain icedearth
END

cp /etc/mkinitcpio.conf /etc/mkinitcpio.conf.bk
cp $dir/mkinitcpio.conf /etc/mkinitcpio.conf
mkinitcpio -p linux

pacman -S --noconfirm vim openssh grub efibootmgr net-tools networkmanager

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

UUID=6e4af0f6-95bd-4235-83b5-8fec313782f9
sed -i "s/GRUB_CMDLINE_LINUX=\"\"/GRUB_CMDLINE_LINUX=\"cryptdevice=UUID=$UUID:cryptroot root=\/dev\/mapper\/cryptroot\"/g" /etc/default/grub

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager.service
systemctl start NetworkManager.service

