{ config, pkgs, ... }:
let
  keys = import ../keys.nix;
in {
  time.timeZone = "America/New_York";

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  networking.firewall = {
    allowPing = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  environment.systemPackages = with pkgs; [
    asciinema
    bpytop
    cachix
    cloc
    curl
    direnv
    dive
    dnsutils
    docker
    docker-compose
    doctl
    file
    fish
    fzf
    gcc
    gh
    git
    gnumake
    gnupg
    go
    gopls
    htop
    inetutils
    inotify-tools
    jq
    keychain
    mosh
    nix-index
    openssl
    patchelf
    pinentry
    pinentry-curses
    ripgrep
    sqlite
    starship
    syncthing
    tmux
    tree
    unzip
    wget
    z-lua
  ];

  programs = {
    fish.enable = true;
    mosh.enable = true;
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
  };
}

