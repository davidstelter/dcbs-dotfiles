#xrandr --setprovideroutputsource modesetting NVIDIA-0
#xrandr --auto
#
xscreensaver --no-splash &
xsetroot -cursor_name left_ptr
setxkbmap -option "ctrl:nocaps"
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
eval `ssh-agent -s`
exec xmonad
