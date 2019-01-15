#!/bin/bash -xe

sudo pacman -S --noconfirm base-devel

tmpdir=$(mktemp -d)
cd $tmpdir

git clone https://aur.archlinux.org/package-query.git
cd package-query
makepkg -si
cd ..
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
