# nixos/containers/jellyfin.nix
{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers.jellyfin = {
    autoStart = true;
    image = "linuxserver/jellyfin:10.10.7";

    ports = [
      "8096:8096"
      "8920:8920"
      "7359:7359/udp"
      "1900:1900/udp"
    ];
    volumes = [
      "/home/kevin/media/volumes/jellyfin_config:/config"
      "/data/media/Serve/Movies:/movies"
      "/data/media/Serve/Series:/series"
    ];
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "Africa/Johannesburg";
    };
    devices = [
      "/dev/dri:/dev/dri" # For Intel QSV hardware transcoding
    ];
  };
}