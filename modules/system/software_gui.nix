{
  lib,
  pkgs,
  spicetify-nix,
  ...
}:
{
  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    alacritty
    ani-cli
    armitage
    audacity
    bemenu
    betterdiscordctl
    blender
    brightnessctl
    candy-icons
    copyq
    cups
    discord
    emacs
    feh
    firefox
    flat-remix-gtk
    font-manager
    gamemode
    gamescope
    gf
    ghostty
    gimp
    gparted
    grim
    gtk4
    hyprcursor
    hypridle
    hyprland
    hyprlock
    hyprpaper
    hyprpicker
    hyprsunset
    kdePackages.okular
    kitty
    krita
    lapce
    libnotify
    mako
    mangohud
    minecraft
    mpv
    nemo
    neovim-qt
    nmapsi4
    nwg-look
    obs-studio
    onlyoffice-desktopeditors
    path-of-building
    pavucontrol
    pipewire
    pitivi
    protonup
    qemu_full
    r2modman
    rose-pine-cursor
    rose-pine-hyprcursor
    sfxr
    slurp
    steam
    system-config-printer
    thunderbird
    virt-manager
    vscode
    waybar
    wezterm
    whatsapp-for-linux
    wineWowPackages.unstableFull
    wineWowPackages.waylandFull
    winetricks
    wireshark
    wlogout
    wofi
    xournalpp
    xwayland
    zed-editor
  ];

  programs = {
    gamemode.enable = true;
    hyprland.enable = true;
    hyprlock.enable = true;
    spicetify =
      let
        spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        enable = true;

        enabledExtensions = with spicePkgs.extensions; [
          betterGenres
          hidePodcasts
          oldSidebar
        ];
        enabledCustomApps = with spicePkgs.apps; [ ncsVisualizer ];
        enabledSnippets = with spicePkgs.snippets; [ pointer ];

        theme = spicePkgs.themes.sleek;
        colorScheme = "UltraBlack";
      };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };

  services = {
    printing.enable = true;
  };

  virtualisation.libvirtd.enable = true;

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };
}
