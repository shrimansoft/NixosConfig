# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{xmonad-contexts, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.


programs.zsh = {
  shellAliases = {
    ll = "ls -l";
    update = "sudo nixos-rebuild switch";
  };
};


users.defaultUserShell = pkgs.zsh;





  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

networking.wireless.iwd.enable = true;

services.connman.wifi.backend = "iwd";

services.gnome.gnome-keyring.enable = true;

  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  networking.proxy.noProxy = "localhost:8080";


security.pki.certificateFiles = [
  /home/shriman/.mitmproxy/mitmproxy-ca.pem
];


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  fonts.fonts = with pkgs; [fira-code fira-mono];

  programs.zsh = {
    enable = true;
    enableCompletion = true; 
    ohMyZsh.theme = "lambda";
    ohMyZsh.enable = true;
    ohMyZsh.plugins = [ "git" ]; 
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  environment.variables.EDITOR = "vim";

  nixpkgs.config.allowUnfree = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;





  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 115 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 6"; }
      { keys = [ 114 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 6"; }
    ];
  };


# spacemacs setup




  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.shriman = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      anytype # Note taking
      logseq # Secand brain 
      brave # Broser
	mitmproxy # proxey for traking packates
      anki-bin
      publii # sebsite generater
      tlp   # battery manager
      iwgtk # wifi manager
      iwd   # wifi manager
      pciutils 
      emacs # editer
      vscode # editer
      syncthing  #for sync data. 
     wluma  # for automatic screen briness controler
pavucontrol # controling sound GUI using pluse audio
mpv # vedio player
rclone # streaming and cloud storage
leiningen # clojure project manager
 nodejs_20 # node.js
      git    # version controler
      gh     # githuc cli client 
      tealdeer # tldr written in rust ( faster then tldr) 
      zotero # citation manager
      zsh # shell 
      fzf # serach in shell 
     rofi # serach launcher 
rofi-file-browser
rofi-systemd
rofi-power-menu
rofi-pulse-select
	kodi
gnome.nautilus
mc
rofi-emoji

      fira-code  # font
      alacritty   # GPU-accelerated terminal emulator
      oh-my-zsh   # configration for zsh
	xmonadctl #
      tree   # tree command
    ];
  };

  # List packages installed in the system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
  ];

#  inputs.xmonad-contexts = {
#    url = "github:Procrat/xmonad-contexts";
#    flake = false;
#  };

  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    ghcArgs = [
      "-hidir /tmp" # place interface files in /tmp, otherwise ghc tries to write them to the nix store
      "-odir /tmp" # place object files in /tmp, otherwise ghc tries to write them to the nix store
      "-i${xmonad-contexts}" # tell ghc to search in the respective nix store path for the module
    ];
  };



#  services.rclone_mount = {
#   enable = true;
#   description = "Mount Google Drive using rclone";
# 
#   wantedBy = [ "multi-user.target" ];
# 
#   script = ''
#     #!/bin/sh
#     rclone mount google_drive: gdrive --vfs-cache-mode full
#   '';
# };



  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
