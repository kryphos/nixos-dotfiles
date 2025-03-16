{ ... }:
{
  security = {
    polkit.enable = true;
    protectKernelImage = true;
    rtkit.enable = true;
    sudo.extraRules = [
      {
        users = [ "luca" ];
        commands = [
          {
            command = "ALL";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };

  services.haveged.enable = true;
}
