
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

#  let
#    tarball = builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/19.09.tar.gz";
#    pinned = import tarball {};
#  in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
test
  boot.loader.grub.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.guest.enable = false;
  virtualisation.virtualbox.host.enableExtensionPack = false;
 # virtualisation.virtualbox.host.package = pinned.virtualbox;
  
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  services.tor.enable = true;
  services.tor.client.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp5s0.useDHCP = true;
  networking.interfaces.wlp9s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.

     console.font = "cyr-sun16";
     console.keyMap = "ru";
     i18n.defaultLocale = "ru_RU.UTF-8";
   
  # Set your time zone.
    time.timeZone = "Asia/Novosibirsk";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
    environment.systemPackages = with pkgs; [
      polkit_gnome htop chromium gajim git keepassxc stow tdesktop thunderbird transmission-gtk zathura unrar lm_sensors gimp gnome3.file-roller firefox libreoffice mpv openvpn pciutils 
      unzip zip yacreader anki gparted audacious direnv atom radare2 radare2-cutter putty filezilla ghidra-bin sqlitebrowser
      wget smplayer vscode-fhs
    ];
    
    nixpkgs.config.allowUnfree = true;
    programs.iotop.enable = true;
    nixpkgs.config.permittedInsecurePackages = [
                "electron-13.6.9"
              ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
    networking.firewall.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
    sound.enable = true;
    hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
    services.xserver.autorun = true;
    services.xserver.enable = true;
    services.xserver.layout = "us, ru";
    services.xserver.xkbOptions = "grp:alt_shift_toggle";
    services.xserver.videoDrivers = [ "intel" ];
    services.picom = {
      enable = true;
      backend = "glx";
      vSync = true;
    };
    hardware.bumblebee.enable = true;

  # Autologin

    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.displayManager.autoLogin.enable = true;
    services.xserver.displayManager.autoLogin.user = "andrew";

  # Enable touchpad support.
    services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Enable the XFCE Desktop Enviroment.

    services.xserver.desktopManager.xfce.enable = true;
    services.xserver.displayManager.defaultSession = "xfce";          

  # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.andrew = {
      description = "Andrew Akhmylin";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "sudo" "docker" "vboxusers" ]; # Enable ‘sudo’ for the user.
    };
    security.sudo.wheelNeedsPassword = false;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

}

