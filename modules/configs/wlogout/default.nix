{ ... }:
{
  home.file.".config/wlogout" = {
    source = ../wlogout;
    recursive = true;
  };
}
