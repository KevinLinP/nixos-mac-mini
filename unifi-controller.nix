{ pkgs, ... }:

{
  # UniFi Controller service configuration
  services.unifi = {
    enable = true;
    unifiPackage = pkgs.unifi;
    mongodbPackage = pkgs.mongodb-ce;
    openFirewall = true;  # Opens required ports in firewall
  };
} 