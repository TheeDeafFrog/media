# nixos/vpn.nix
{ config, pkgs, ... }:

{
  services.openvpn.servers = {
    pia = {
      config = "config /home/kevin/media/nixos/vpn/openvpn/south_africa.ovpn";
      authUserPass = {
        username = "p7423841";
        password = "nyZkoq-2focdu-runrus";
      };

      updateResolvConf = true;
      autoStart = true;
    };
  };
}