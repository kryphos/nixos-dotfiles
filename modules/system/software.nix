{ pkgs, spicetify-nix, ... }:
let
  libraries = with pkgs; [
    glibc.static
    libcxx
    libgcc
    libiconv
    libz
    openssl
    postgresql.lib
    stdenv.cc.cc
    stdenv.cc.cc.lib
    wayland
    waylandpp
    xorg.libX11
    xorg.libX11.dev
  ];
in
{
  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
  };

  programs.nix-ld.dev = {
    enable = true;
    inherit libraries;
  };

  environment.variables = {
    OPENSSL_DEV = pkgs.openssl.dev;
    PKG_CONFIG_PATH = "\$PKG_CONFIG_PATH:${pkgs.openssl.dev}/lib/pkgconfig";
  };

  environment.defaultPackages = [ ];
  environment.systemPackages = with pkgs; [
    act
    adwaita-icon-theme
    aircrack-ng
    alacritty
    ani-cli
    armitage
    audacity
    autoPatchelfHook
    awscli2
    bat
    bemenu
    betterdiscordctl
    blender
    brightnessctl
    btop
    candy-icons
    cargo-bootimage
    cargo-cross
    cargo-deny
    cargo-edit
    cargo-expand
    cargo-flamegraph
    cargo-fuzz
    cargo-info
    cargo-machete
    cargo-make
    cargo-shuttle
    cargo-watch
    cgdb
    clang
    clang-tools
    cloc
    cmake
    cmatrix
    copyq
    coreutils
    cups
    curl
    cutter
    dconf
    diesel-cli
    direnv
    discord
    docker
    docker-buildx
    docker-compose
    dust
    emacs
    emscripten
    entr
    eza
    fastfetch
    fcrackzip
    fd
    feh
    ffmpeg-full
    file
    firefox
    flat-remix-gtk
    font-manager
    fzf
    gamemode
    gamescope
    gcc
    gdb
    gf
    ghidra
    ghostty
    gimp
    gitFull
    glib
    gnumake
    gnuplot
    gnutar
    go
    gparted
    graphviz
    grim
    grub2
    gtk4
    hashcat
    headsetcontrol
    hyperfine
    hyprcursor
    hypridle
    hyprland
    hyprlock
    hyprpaper
    hyprpicker
    hyprsunset
    imagemagickBig
    irust
    john
    jq
    jupyter-all
    kdePackages.okular
    killall
    kitty
    krita
    kubectl
    lapce
    lazydocker
    lazygit
    lcov
    libnotify
    llvmPackages.bintools
    lolcat
    lua51Packages.lua
    lua51Packages.luarocks
    lutris
    mako
    man-db
    man-pages
    mangohud
    meson
    metasploit
    minecraft
    minikube
    mold
    mpg123
    mpv
    nasm
    nemo
    neofetch
    neovim
    neovim-qt
    ninja
    nmap
    nmapsi4
    nodejs
    ntfs3g
    nushell
    nwg-look
    obs-studio
    oh-my-zsh
    onefetch
    onlyoffice-desktopeditors
    opam
    osmium-tool
    path-of-building
    pavucontrol
    pdftk
    perf-tools
    pipewire
    pitivi
    pkg-config
    poetry
    postgresql
    protonup
    pulseaudio
    python312Full
    python312Packages.black
    python312Packages.debugpy
    python312Packages.ipython
    python312Packages.isort
    qemu_full
    qmk
    r2modman
    ranger
    raylib
    ripgrep
    rose-pine-cursor
    rose-pine-hyprcursor
    rsync
    rustup
    sfxr
    slurp
    sox
    sqlite
    sqlx-cli
    starship
    steam
    system-config-printer
    terraform
    texliveFull
    thc-hydra
    thunderbird
    tldr
    tmux
    tmux-sessionizer
    tokei
    tparted
    trash-cli
    unzip
    valgrind
    ventoy-full
    vim
    virt-manager
    vscode
    waybar
    wezterm
    wget
    whatsapp-for-linux
    wineWowPackages.unstableFull
    wineWowPackages.waylandFull
    winetricks
    wireplumber
    wireshark
    wl-clipboard
    wlogout
    wofi
    wofi
    xorg.xeyes
    xorg.xhost
    xournalpp
    xwayland
    zed-editor
    zig
    zip
    zoxide
    zsh
  ];

  fonts = {
    enableDefaultPackages = true;
    enableGhostscriptFonts = true;
    fontDir.enable = true;
    fontconfig = {
      defaultFonts = {
        monospace = [ "Terminus (TTF)" ];
        sansSerif = [ "Terminus (TTF)" ];
        serif = [ "Terminus (TTF)" ];
      };
    };
    packages = with pkgs; [
      caladea
      fira-code
      hack-font
      hanazono
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nerd-fonts.open-dyslexic
      nerd-fonts.profont
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-emoji-blob-bin
      powerline-fonts
      terminus_font_ttf
    ];
  };

  # some software needs to do more things than just be installed
  programs = {
    gamemode.enable = true;
    git.config = {
      credential.helper = "libsecret";
    };
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
    zsh = {
      enable = true;
      shellInit = ''
        export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${pkgs.lib.makeLibraryPath libraries}"
      '';
      ohMyZsh = {
        enable = true;
        plugins = [
          "aws"
          "direnv"
          "docker"
          "docker-compose"
          "fzf"
          "git"
          "kubectl"
          "rust"
          "sudo"
          "terraform"
        ];
      };
    };
  };

  services = {
    openssh.enable = true;
    printing.enable = true;
  };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    autoPrune.dates = "weekly";
    autoPrune.enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    #storageDriver = "btrfs";
  };
}
