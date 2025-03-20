{
  config,
  lib,
  ...
}:
{
  fileSystems."/" = {
    device = "/dev/sdc";
    fsType = "ext2";
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
