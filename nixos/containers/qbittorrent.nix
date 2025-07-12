{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers.qbittorrent = {
    image = "linuxserver/qbittorrent:5.1.2";

    volumes = [
      "/home/kevin/media/volumes/qbittorrent_config:/config"
      "/data/media/Downloads:/downloads"
    ];
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "Africa/Johannesburg";
      WEBUI_PORT = "8080";
      TORRENTING_PORT = "6881";
    };
    dependsOn = [ "gluetun" ];
    networks = [ "container:gluetun" ];
  };

  virtualisation.oci-containers.containers.gluetun = {
    image = "qmcgaw/gluetun:v3.40";

    ports = [ # qbittorrent ports
      "8080:8080"
      "6881:6881"
      "6881:6881/udp"
    ];
    
    capabilities = {
      NET_ADMIN = true;
    };
    devices = [
      "/dev/net/tun:/dev/net/tun"
    ];
    volumes = [
      "/home/media/media/volumes/gluetun:/gluetun"
    ];
    environment = {
      VPN_SERVICE_PROVIDER = "private internet access";
      OPENVPN_USER = "p7423841";
      OPENVPN_PASSWORD = "nyZkoq-2focdu-runrus";
      SERVER_REGIONS = "South Africa";
    };
  };
}