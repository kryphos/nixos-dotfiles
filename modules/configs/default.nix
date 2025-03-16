{ ... }:
{
  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
  systemd.user.startServices = "sd-switch";

  imports = [
    ./cgdb
    ./discord
    ./fastfetch
    ./ghostty
    ./gtk
    ./hyprland
    ./kitty
    ./mako
    ./nvim
    ./ranger
    ./secrets
    ./starship
    ./systemd
    ./tmux
    ./wallpapers
    ./waybar
    ./wlogout
    ./wofi
    ./xdg
    ./zsh
  ];
}
