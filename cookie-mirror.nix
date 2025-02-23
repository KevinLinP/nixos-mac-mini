{
  # Define a system user for the keys server
  users.users.cookie-mirror-user = {
    isSystemUser = true;
    group = "cookie-mirror";
    home = "/dev/null";  # Explicitly disable home directory
    createHome = false;
  };

  users.groups.cookie-mirror = {};

  # service configuration
  systemd.services.cookie-mirror = {
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      User = "cookie-mirror-user";
      Group = "cookie-mirror";

      Type = "simple";
      ExecStart = "/srv/cookie-mirror/cookie-mirror";
      Restart = "on-failure";
      RestartSec = "10s";

      # capabilities
      CapabilityBoundingSet = []; 
      AmbientCapabilities = [];
      
      # system calls
      KeyringMode = "private";
      LockPersonality = true;
      MemoryDenyWriteExecute = true; # probably does nothing on arm64
      NoNewPrivileges = true;
      ProcSubset = "pid";               # Restrict /proc access to minimum
      ProtectClock = true;
      ProtectControlGroups = true;
      ProtectHome = true;
      ProtectHostname = true;
      ProtectKernelLogs = true;
      ProtectKernelModules = true;
      ProtectKernelTunables = true;
      ProtectProc = "invisible";
      ProtectSystem = "strict";
      PrivateDevices = true;
      PrivateTmp = "disconnected";
      RestrictAddressFamilies = [ "AF_INET" "AF_INET6" ];
      RestrictNamespaces = true;
      RestrictRealtime = true;
      RestrictSUIDSGID = true;
      SystemCallFilter = [ "@system-service" "@network-io" ];

      # further options at https://www.freedesktop.org/software/systemd/man/latest/systemd.service.html
      # and its subpages
    };
  };
}