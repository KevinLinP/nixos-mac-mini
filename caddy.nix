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

    virtualHosts."cmd.kevinlinp.org:31717" = {
      useACMEHost = "cmd.kevinlinp.org";
      extraConfig = ''
        reverse_proxy localhost:1317
      '';
    };

    virtualHosts."localhost:31713" = {
      useACMEHost = "cm.kevinlinp.org";
      extraConfig = ''
        reverse_proxy localhost:1317
      '';
    };
  };
} 