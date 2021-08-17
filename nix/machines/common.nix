{ config, pkgs, ... }:
let
  keys = import ../keys.nix;
in {
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];

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
    mosh
    nix-index
    openssl
    patchelf
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

  services.emacs = {
    enable = true;
    package = (pkgs.emacsGit-nox.override { nativeComp = true; } );
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
  };
}

