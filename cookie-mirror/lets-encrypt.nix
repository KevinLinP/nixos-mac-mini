{
  security.acme = {
    acceptTerms = true;
    defaults.email = "programming.brhiwlomtq@use.startmail.com";

    # certs."4fde013c-d34d-4485-b276-e242e981c5e3.giize.com" = {
    #   dnsProvider = "dynu";
    #   # https://go-acme.github.io/lego/dns/dynu/
    #   environmentFile = "/home/kevin/nixos/lets-encrypt.secret.conf";
    # };

    certs."cm.klptos.org" = {
      dnsProvider = "cloudflare";
      # https://go-acme.github.io/lego/dns/cloudflare/index.html
      environmentFile = "/home/kevin/nixos/lets-encrypt.secret.conf";
    };
  };
}