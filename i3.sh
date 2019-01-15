#!/bin/bash -xe

sudo pacman -S --noconfirm i3-wm xorg-server xorg xf86-video-intel mesa xorg-xinit dmenu feh scrot termite i3locki i3status pavucontrol arandr pulseaiudio pulseaudio-alsa awesome-terminal-fonts ttf-font-awesome dunst

cat <<END > $HOME/.xinitrc
exec i3
END
cat <<END | sudo tee /etc/X11/xorg.conf.d/00-keyboard.conf
Section "InputClass"
 	Identifier "system-keyboard"
	MatchIsKeyboard "on"
	Option "XkbLayout" "br"
	Option "XkbVariant" "abnt2"
EndSection
END

mount -o size=5G remount /tmp
yaourt -S  nerd-fonts-complete


systemctl --user enable pulseaudio
systemctl --user enable pulseaudio.socket
systemctl --user start pulseaudio
systemctl --user start pulseaudio.socket

cd $HOME
git clone https://github.com/raonifn/my-i3.git .i3
