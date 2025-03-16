{ pkgs, ... }:
{
  boot = {
    tmp.cleanOnBoot = true;
    loader.timeout = 2;
    loader.efi.canTouchEfiVariables = true;

    consoleLogLevel = 0;
    initrd.systemd.enable = true;
    initrd.verbose = false;
    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = [ ];
    kernelParams = [
      "quiet"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd Hyprland --time --remember --asterisks";
        user = "greeter";
      };
    };
  };
}
