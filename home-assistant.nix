# https://nixos.wiki/wiki/Home_Assistant
{
  services.home-assistant = {
    enable = true;
    extraComponents = [
      # Components required to complete the onboarding
      # "esphome"
      "met" # weather
      # "radio_browser"
    ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = {};
      zeroconf = {};
      homekit = {};
    };
  };
}