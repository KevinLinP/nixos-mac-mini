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
  systemd.services.key-server = {
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
      # CapabilityBoundingSet = "";
      # InaccessiblePaths = [ "/root" ];  # Block access to sensitive directories
      LockPersonality = true;
      MemoryDenyWriteExecute = true; # probably does nothing on arm64
      NoNewPrivileges = true;
      # ProcSubset = "pid";               # Restrict /proc access to minimum
      ProtectClock = true;
      ProtectControlGroups = true;
      ProtectHome = true;
      ProtectKernelLogs = true;
      ProtectKernelModules = true;
      ProtectKernelTunables = true;
      # ProtectProc = "invisible";
      ProtectSystem = true;
      PrivateDevices = true;
      PrivateTmp = "disconnected";
      # ReadOnlyPaths = [ "/home/kevin/key-server/target/release/keys" ];  # Make binary read-only
      RestrictAddressFamilies = [ "AF_INET" "AF_INET6" ];
      RestrictNamespaces = true;
      RestrictRealtime = true;
      RestrictSUIDSGID = true;

      # further options at https://www.freedesktop.org/software/systemd/man/latest/systemd.service.html
      # and its subpages
    };
  };
}