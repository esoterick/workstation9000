{ config, pkgs, ... }:
let
  doom-emacs = pkgs.callPackage (builtins.fetchTarball {
    url = https://github.com/vlaci/nix-doom-emacs/archive/master.tar.gz;
  }) {
    doomPrivateDir = ../../dotfiles/doom.d;
  };
in {
  programs.home-manager.enable = true;
  home.username = "rlambert";
  home.homeDirectory = "/home/rlambert";

  home.stateVersion = "21.11";

  home.file.".gitconfig".source = ../../dotfiles/gitconfig;

  home.file.".config/starship.toml".source = ../../dotfiles/starship.toml;

  home.file.".config/fish/config.fish".source = ../../dotfiles/fish/config.fish;
  home.file.".config/fish/functions/fish_user_key_bindings.fish".source = ../../dotfiles/fish/functions/fish_user_key_bindings.fish;

  home.file.".doom.d/init.el".source = ../../dotfiles/doom.d/init.el;
  home.file.".doom.d/config.el".source = ../../dotfiles/doom.d/init.el;
  home.file.".doom.d/packages.el".source = ../../dotfiles/doom.d/packages.el;

  home.packages = with pkgs; [
    doom-emacs
    pinentry-emacs
    python39
    python39Packages.pip
    python39Packages.nose
    python39Packages.poetry
    python39Packages.virtualenv
    ruby
    chruby
    chruby-fish
    bundix
  ];
  home.file.".emacs.d/init.el".text = ''
      (load "default.el")
  '';

  services.emacs = {
    enable = true;
    package = doom-emacs;
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
    extraConfig = ''
      allow-emacs-pinentry
      allow-loopback-pinentry
      pinentry-program ${pkgs.pinentry-emacs}/bin/pinentry
    '';
  };

  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    clock24 = true;
    terminal = "screen-256color";
    extraConfig = ''
      ## Status line

      set -g terminal-overrides ',xterm-256color:Tc'
      set -g default-terminal "screen-256color"
      set -as terminal-overrides ',xterm*:sitm=\E[3m'

      set -g status-bg black
      set -g status-fg white

      set -g status-left-length 50
      set -g status-left "#[fg=blue](#[fg=white]#H#[fg=blue])  "

      set -g status-right-length 50
      set -g status-right "#[fg=blue]  (#[fg=magenta]%H:%M#[fg=blue])"

      set -g status-justify left

      # set-window-option -g window-status-current-attr bold
      # set-window-option -g window-status-current-fg red

      ## Keys
      # Screen behaviour
      set -g prefix C-a

      unbind c
      bind c new-window
      bind C-c new-window

      unbind &
      bind k confirm-before kill-window
      bind C-k confirm-before kill-window

      unbind l
      bind C-a last-window

      unbind C-b
      bind a send-prefix

      unbind n
      bind n next-window
      bind C-n next-window

      unbind p
      bind p previous-window
      bind C-p previous-window

      unbind d
      bind d detach
      bind C-d detach

      set-option escape-time 0
      unbind [
      bind Escape copy-mode

      # Other useful stuff
      unbind %
      bind h split-window -h
      bind C-h split-window -h

      unbind "'"
      bind v split-window -v
      bind C-v split-window -v

      bind / command-prompt "split-window 'exec man %%'"

      # Start windows and panes at 1, not 0
      set -g base-index 1
      setw -g pane-base-index 1
    '';
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.nord
      tmuxPlugins.logging
    ];
  };
}
