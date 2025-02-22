{
  # Define a system user for the keys server
  users.users.key-server = {
    isSystemUser = true;
    group = "key-server";
    home = "/dev/null";  # Explicitly disable home directory
    createHome = false;
  };

  users.groups.key-server = {};

  # Keys server service configuration
  systemd.services.keys-server = {
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      User = "key-server";
      Group = "key-server";
      ExecStart = "/home/kevin/key-server/target/release/keys";
      Restart = "always";
      RestartSec = "10s";
      
      # Security hardening options
      CapabilityBoundingSet = "";
      LockPersonality = true;
      MemoryDenyWriteExecute = true; # probably does nothing on arm64
      NoNewPrivileges = true;
      ProtectClock = true;
      ProtectControlGroups = true;
      ProtectHome = true;
      ProtectKernelLogs = true;
      ProtectKernelModules = true;
      ProtectKernelTunables = true;
      ProtectProc = "invisible";
      ProtectSystem = true;
      PrivateDevices = true;
      PrivateNetwork = false;
      PrivateTmp = "disconnected";
      RestrictAddressFamilies = [ "AF_INET" "AF_INET6" ];
      RestrictFileSystems = "";
      RestrictNamespaces = true;
      RestrictRealtime = true;
      RestrictSUIDSGID = true;

      # further options at https://www.freedesktop.org/software/systemd/man/latest/systemd.service.html
      # and its subpages
    };
  };
}