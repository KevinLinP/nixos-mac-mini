{ config, lib, pkgs, ... }:

{
  services.caddy = {
    enable = true;
    # virtualHosts."4fde013c-d34d-4485-b276-e242e981c5e3.giize.com:317" = {
    #   useACMEHost = "4fde013c-d34d-4485-b276-e242e981c5e3.giize.com";
    #   extraConfig = ''
    #     header Access-Control-Allow-Origin "*"
    #     header Access-Control-Allow-Credentials "true"
    #     reverse_proxy localhost:1317 
    #   '';
    # };

    virtualHosts."cm.klptos.org:31717" = {
      useACMEHost = "cm.klptos.org";
      extraConfig = ''
        reverse_proxy localhost:1317
      '';
    };

    # virtualHosts."localhost:31713" = {
    #   listenAddresses = [ "127.0.0.1" ];
    #   useACMEHost = "cm.kevinlinp.org";
    #   extraConfig = ''
    #     reverse_proxy localhost:1317
    #   '';
    # };
  };
} 