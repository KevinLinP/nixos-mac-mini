{ config, lib, pkgs, ... }:

{
  services.caddy = {
    enable = true;
    virtualHosts."4fde013c-d34d-4485-b276-e242e981c5e3.giize.com:317" = {
      useACMEHost = "4fde013c-d34d-4485-b276-e242e981c5e3.giize.com";
      extraConfig = ''
        reverse_proxy localhost:1317
      '';
    };
    # virtualHosts."cookie-mirror.kevinlinp.org:443" = {
    #   useACMEHost = "cookie-mirror.kevinlinp.org";
    #   extraConfig = ''
    #     reverse_proxy localhost:1317
    #   '';
    # };
  };
} 