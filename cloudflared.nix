{
  services.cloudflared = {
    enable = true;
    tunnels = {
      "a58d5af7-e83c-475b-abc8-58e5f70604ec" = {
        credentialsFile = "/var/lib/cloudflared/a58d5af7-e83c-475b-abc8-58e5f70604ec.json";
        default = "http_status:404";
      };
    };
  };
}