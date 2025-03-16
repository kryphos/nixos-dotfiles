{ config, pkgs, ... }:
{
  xdg = {
    enable = true;
    mimeApps.enable = true;
    mimeApps.defaultApplications = {
      "application/pdf" = "okular.desktop";
      "application/x-www-form-urlencoded" = "firefox.desktop";
      "audio/mpeg" = "mpv.desktop";
      "audio/ogg" = "mpv.desktop";
      "image/png" = "feh.desktop";
      "image/jpeg" = "feh.desktop";
      "text/plain" = "nvim-qt.desktop";
      "video/mp4" = "mpv.desktop";
      "video/x-matroska" = "mpv.desktop";
    };
    desktopEntries = {
      "okular" = {
        name = "Okular";
        exec = "${pkgs.kdePackages.okular}/bin/okular";
      };
      "firefox" = {
        name = "Firefox";
        exec = "${pkgs.firefox}/bin/firefox";
      };
      "mpv" = {
        name = "mpv";
        exec = "${pkgs.mpv}/bin/mpv";
      };
      "feh" = {
        name = "feh";
        exec = "${pkgs.feh}/bin/feh";
      };
      "nvim-qt" = {
        name = "nvim-qt";
        exec = "${pkgs.neovim-qt}/bin/nvim-qt";
      };
    };
  };

  xdg.userDirs = {
    enable = true;
    desktop = "/dev/null";
    documents = "${config.home.homeDirectory}/documents";
    download = "${config.home.homeDirectory}/downloads";
    music = "${config.home.homeDirectory}/music";
    pictures = "${config.home.homeDirectory}/pictures";
    publicShare = "/dev/null";
    templates = "/dev/null";
    videos = "${config.home.homeDirectory}/videos";
  };
}
