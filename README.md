# arch_installation
My personal Arch installation notes

  Suitable for systems with intel processors/integrated graphics
  
  "create file" means copy from repository

- `loadkeys fi` - load finnish keyboard layout
- `timedatectl set-ntp true` - NTP on
- 
- Create and mount the partitions.
  - `systemd-boot` requires EFI to be mounted at `/boot`!!
- Install system base with `pacstrap`:

```pacstrap -i /mnt base linux-zen linux-firmware base-devel git vim man dosfstools ntfs-3g ufw tlp tlp-rdw gnome```

- `genfstab -U /mnt >> /mnt/etc/fstab` - generate `fstab`
  - If using bind mounts, remove `/mnt` from mountpoint!!
- `arch-chroot /mnt` - Change root in to the new installation
- `timedatectl set-timezone Europe/Helsinki` - set time zone
- `hwclock --systohc` - syncronize HW clock with system clock
- (optional) enable swapfile:
  - `fallocate -l 8G /swapfile`
  - `mkswap /swapfile`
  - `swapon /swapfile`
  - Add entry for swapfile to `fstab` <br> (`/swapfile none swap defaults 0 0`)
- Locale generation:
  - `echo "fi_FI.UTF-8 UTF-8" >> /etc/locale.gen` - set locale to generate
  - `locale-gen`
- `echo -e "LANG=fi_FI.UTF-8\nLC_COLLATE=C" >> /etc/locale.conf"` - set system default locale
- `echo "KEYMAP=fi" >> /etc/vconsole.conf` - set persistent TTY keyboard layout
- create `/etc/hostname` and `/etc/hosts`
- modify `/etc/mkinitcpio.conf`, add `i915` kernel module and replace `udev`-hook with `systemd`-hook (file included)
- recreate `initramfs`:
  - `mkinitcpio -P`
- Install `systemd-boot` bootloader:
  - `bootctl install`
  - add `/boot/loader/entries/arch.conf`
  - set default entry in `/boot/loader/loader.conf`
  - create pacman hook for updating systemd-boot: `/etc/pacman.d/hooks/100-systemd-boot.hook`
  - run `bootctl update`
- edit `/etc/sudoers` with `visudo`:
  - uncomment `wheel` group
- edit `/etc/pacman.conf`
- set root password: `passwd`
- create administrator user:
  - `useradd -m -G wheel,storage,power,uucp,tty <user>`
  - `passwd <user>`
- enable `NetworkManager` and `gdm`

- reboot

- After rebooting, create file `/var/lib/gdm/.config/pulse/default.pa`
  - Fixes gdm issue with bluetooth headset

- Enable SSD periodic trimming:
  `sudo systemctl enable --now fstrim.timer`
