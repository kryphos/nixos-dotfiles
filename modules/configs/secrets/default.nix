{ ... }:
{
  home.file.".secrets" = {
    source = ./secrets;
    recursive = true;
  };
}
