{ config, pkgs, ... }:

{
  virtualisation.oci-containers.containers.sonarr = {
    image = "linuxserver/sonarr:4.0.15";

    volumes = [
      "/data/media:/media"
      "/home/kevin/media/volumes/sonarr_config:/config"
    ];

    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "Africa/Johannesburg";
    };

    ports = [
      "8989:8989"
    ];
  };

  virtualisation.oci-containers.containers.radarr = {
    image = "linuxserver/radarr:5.26.2";

    volumes = [
      "/data/media:/media"
      "/home/kevin/media/volumes/radarr_config:/config"
    ];

    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "Africa/Johannesburg";
    };

    ports = [
      "7878:7878"
    ];
  };

  virtualisation.oci-containers.containers.prowlarr = {
    image = "linuxserver/prowlarr:1.37.0";

    volumes = [
      "/data/media:/media"
      "/home/kevin/media/volumes/prowlarr_config:/config"
    ];

    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "Africa/Johannesburg";
    };

    ports = [
      "9696:9696"
    ];
  };
}