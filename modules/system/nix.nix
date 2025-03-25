{ ... }:
{
  system = {
    stateVersion = "24.11";
    autoUpgrade = {
      enable = true;
      dates = "weekly";
    };
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command flakes" ];
      auto-optimise-store = true;
      allowed-users = [ "luca" ];
      max-jobs = 32;
      download-buffer-size = 1000000000000;
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 5d";
    };
  };
}
