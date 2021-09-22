#!/bin/env bash

## Repos
repo="https://github.com/AvishekPD"
wm="dwm"
term="st"

## Misc
neovim_config="$repo/nvim"
scripts="$repo/Scripts"
fonts="$repo/fonts"

### No touch zone ###
mkdir $HOME/.srcs && cd $HOME/.srcs

clone() {
	case $1 in
		install)
			git clone $repo/$1
			cd ./$1 && \
				make clean install
			cd .. 
			;;
		*)
			git clone $1
			;;
	esac
}

aur_install() {
	case $1 in
		-paru)
			paru -S "${@:2}" --needed --noconfirm --noreviews 
			;;

		-yay)
			yay -S "${@:2}" --noconfirm --needed
			;;
	esac

}

## Installing stuffs here

aur_install -paru picom-ibhagwan-git libxft-bgra-git \
    yt-dlp yt-dlp-drop-in

# getting root access for rest of the install
sudo -s  

pacman -S \
	xorg xorg-xinit xorg-xinput \
	feh dmenu mpv maim\
	--needed --noconfirm

# -> Intalling stuffs from git <- # 
clone install $wm & \
clone install $term 

clone neovim_config && \
	mv ./nvim $HOME/.config/

clone scripts && \ 
	mv scripts ../

clone fonts && \
	mv fonts/fonts.zip $HOME/.local/share/fonts &&\
	7z e $HOME/.local/share/fonts/font.zip

exit
