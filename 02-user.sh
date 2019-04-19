#!/bin/bash -xe

dir=$(dirname $0)

pacman -S --noconfirm sudo zsh

useradd -m -g users -s /bin/zsh raoni
passwd raoni

echo "raoni ALL=(ALL) ALL" > /etc/sudoers.d/raoni

cp -r $dir /home/raoni
chown -R raoni:users /home/raoni/archinit
