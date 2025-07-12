{ config, pkgs, lib, home-manager, ... }:

{
  networking.hostName = "media"; # Define your hostname.

  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = false;

  networking.defaultGateway = {
    address = "192.168.0.1";
  };

  networking.nameservers = [
    "92.168.0.1"
    "8.8.8.8"
    "8.8.4.4"
  ];

  networking.interfaces.wlp1s0 = {
    useDHCP = false;
    ipv4.addresses = [
      {
        address = "192.168.0.155";
        prefixLength = 24;
      }
    ];

    # wpaSupplicant.networks = [
    #   {
    #     ssid = "Bash Chalet";
    #     psk = "LandRover1960";
    #   }
    # ];
  };

  networking.wireless.networks = {
    "Bash Chalet" = {
      psk = "LandRover1960";
    };
  };

  # networking.interfaces.enp3s0 = {
  #   useDHCP = false;
  #   ipv4.addresses = [
  #     {
  #       address = "192.168.0.155";
  #       prefixLength = 24;
  #     }
  #   ];
  # };
}  
