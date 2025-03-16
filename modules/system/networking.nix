{ ... }:
{
  hardware.bluetooth.powerOnBoot = false;
  hardware.bluetooth.enable = false;

  networking = {
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
        80
        443
      ];
      allowedUDPPorts = [ 53 ];
      checkReversePath = false;
    };
  };
}
