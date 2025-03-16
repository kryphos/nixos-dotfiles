{ pkgs, ... }:
{
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RoséPine";
    size = 28;
  };

  gtk = {
    enable = true;
    font.name = "Terminus (TTF) 14";
    iconTheme.name = "candy-icons";
    theme.name = "Flat-Remix-GTK-Red-Darkest";
    cursorTheme = {
      name = "BreezeX-RoséPine";
      size = 28;
    };
  };

  home.file.".config/xsettingsd/xsettingsd.conf".source = ./xsettingsd.conf;
}
