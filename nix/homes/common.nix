{ config, pkgs, ... }:

# let
#   doom-emacs = pkgs.callPackage (builtins.fetchTarball {
#     url = https://github.com/vlaci/nix-doom-emacs/archive/master.tar.gz;
#   }) {
#     doomPrivateDir = ../../dotfiles/doom.d;
#   };
# in {
# {
#   home.packages = [ doom-emacs ];
#  home.file.".emacs.d/init.el".text = ''
#       (load "default.el")
#  '';


{
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
}
