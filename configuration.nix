# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports = [ 
    # hardware
    ./hardware-configuration.nix
    ./apple-silicon-support
    # cookie-mirror server
    ./ddclient.nix
    ./lets-encrypt.nix
    ./caddy.nix
    ./cookie-mirror.nix
    # internal services
    ./home-assistant.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  networking.hostName = "mac-mini-nixos"; # Define your hostname.

  networking = {
    useDHCP = true;
    
    # shouldn't be necessary?
    # Configure interfaces
    # interfaces.end0.useDHCP = true;  # Replace enp1s0 with your interface name
  };

  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
    settings.Settings.AutoConnect = true;
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.kevin = {
    isNormalUser = true;
    extraGroups = [ "wheel" "cookie-mirror" ]; # Enable 'sudo' for the user.
  };

  security.sudo.wheelNeedsPassword = false;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      AllowUsers = ["kevin"];
      PermitRootLogin = "no";
    };
  };
  services.fail2ban.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 
      22 # SSH
      8123 # Home Assistant
      21063 # Home Assistant - HomeKit Bridge
      8443 # Unifi Controller
      317 # Dynu cookie-mirror
      # 443 # Cloudflare cookie-mirror
    ];
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
  ];

  users.users.kevin.packages = with pkgs; [
    git
    gh
    # Rust
    rustc
    cargo
    clang
    pkg-config
  ];

  # Add this section to enable the UniFi Controller service
  services.unifi = {
    enable = true;
    unifiPackage = pkgs.unifi;
    mongodbPackage = pkgs.mongodb-ce;
    openFirewall = true;  # Opens required ports in firewall
  };

  programs.nix-ld.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}

