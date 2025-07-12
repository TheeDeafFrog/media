# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, home-manager, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
      ./containers
      # ./vpn
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "media"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Johannesburg";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_ZA.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_ZA.UTF-8";
    LC_IDENTIFICATION = "en_ZA.UTF-8";
    LC_MEASUREMENT = "en_ZA.UTF-8";
    LC_MONETARY = "en_ZA.UTF-8";
    LC_NAME = "en_ZA.UTF-8";
    LC_NUMERIC = "en_ZA.UTF-8";
    LC_PAPER = "en_ZA.UTF-8";
    LC_TELEPHONE = "en_ZA.UTF-8";
    LC_TIME = "en_ZA.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  programs.firefox.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "za";
    variant = "";
  };

  users.users.kevin = {
    isNormalUser = true;
    description = "Kevin";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  home-manager.users.kevin = { pkgs, ...}: {
    home.homeDirectory = "/home/kevin";
    home.stateVersion = "25.05";

    programs.git = {
      enable = true; # This enables git integration if you're using Home Manager
      userName = "kevin";
      userEmail = "36723751+TheeDeafFrog@users.noreply.github.com";
    };
  };

  nixpkgs.config.allowUnfree = true;

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  environment.systemPackages = with pkgs; [
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        jnoortheen.nix-ide
      ];
    })
    git
    unzip
  ];

  fileSystems."/data/media" = {
    device = "/dev/disk/by-uuid/04a38060-bb43-46c0-ad2f-370aaee8b7e9"; # <-- REPLACE WITH YOUR ACTUAL UUID!
    fsType = "ext4"; # <-- REPLACE WITH YOUR ACTUAL FILESYSTEM TYPE (e.g., ext4, ntfs, xfs, btrfs)
    options = [
      "defaults"
      "nofail" # Very important! Prevents boot failure if drive isn't connected.
      "x-systemd.automount" # Optional: Mounts on access, not at boot, can speed up boot if drive is sometimes absent
      "x-systemd.idle-timeout=600" # Optional: Unmounts after 10 mins of inactivity (if automount used)
      "uid=1000" # Your kevin user's UID (e.g., from `id kevin`)
      "gid=100"  # Your kevin user's GID (e.g., from `id kevin`)
      "umask=0022" # Default permissions: directories 755, files 644
    ];
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
