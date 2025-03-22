{ lib, pkgs, ... }:
let
  libraries = with pkgs; [
    libcxx
    libgcc
    libz
    openssl
    postgresql.lib
    stdenv.cc.cc
    stdenv.cc.cc.lib
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
  environment.sessionVariables.LD_LIBRARY_PATH = "${lib.makeLibraryPath libraries}";

  environment.defaultPackages = [ ];
  environment.systemPackages = with pkgs; [
    act
    aircrack-ng
    awscli2
    bat
    btop
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
    coreutils
    curl
    dconf
    diesel-cli
    direnv
    docker
    docker-buildx
    docker-compose
    dust
    emscripten
    entr
    eza
    fastfetch
    fcrackzip
    fd
    ffmpeg-full
    file
    fzf
    gcc
    gdb
    gitFull
    glib
    gnumake
    gnuplot
    gnutar
    go
    graphviz
    grub2
    hashcat
    headsetcontrol
    hyperfine
    imagemagickBig
    irust
    john
    jq
    jupyter-all
    killall
    kubectl
    lazydocker
    lazygit
    lcov
    llvmPackages.bintools
    lolcat
    lua51Packages.lua
    lua51Packages.luarocks
    lutris
    man-db
    man-pages
    meson
    metasploit
    minikube
    mold
    mpg123
    nasm
    neofetch
    neovim
    ninja
    nmap
    nodejs
    ntfs3g
    nushell
    oh-my-zsh
    onefetch
    opam
    pdftk
    perf-tools
    pkg-config
    poetry
    postgresql
    python312Full
    python312Packages.black
    python312Packages.debugpy
    python312Packages.ipython
    python312Packages.isort
    qmk
    ranger
    raylib
    ripgrep
    rsync
    rustup
    sox
    sqlite
    sqlx-cli
    starship
    terraform
    texliveFull
    thc-hydra
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
    wget
    wireplumber
    wl-clipboard
    wofi
    xorg.xhost
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
    git.config = {
      credential.helper = "libsecret";
    };
    zsh = {
      enable = true;
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
  };

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
