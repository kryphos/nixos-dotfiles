{ ... }:
{
  home.file.".config/wofi" = {
    source = ../wofi;
    recursive = true;
  };
}
