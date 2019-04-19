#!/bin/bash

sudo pacman -S --noconfirm base-devel fakeroot make gcc

tmpdir=$(mktemp -d)
cd $tmpdir

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
