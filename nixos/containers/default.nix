# nixos/containers/default.nix
{ config, pkgs, ... }:

{
  # Global Docker daemon settings
  virtualisation.docker = {
    enable = true;
  };

  # Enable the OCI containers module globally
  virtualisation.oci-containers.backend = "docker";

  # Import individual container configurations
  imports = [
    ./jellyfin.nix
    ./qbittorrent.nix
  ];

  # # Add docker-compose to system packages, accessible globally from command line
  # environment.systemPackages = with pkgs; [
  #   docker-compose
  # ];
}