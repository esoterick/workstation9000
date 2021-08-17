{ config, pkgs, ... }:
let
  keys = import ../keys.nix;
in {
  imports = [
    ./common.nix
  ]; 

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  virtualisation.docker.enable = true;

  users.mutableUsers = false;
  users.users.rlambert = {
    isNormalUser = true;
    home = "/home/rlambert";
    description = "Robert J. Lambert III";
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE0y63gYBa2F+lBNISfNvCsDQPeHNyPIFgWWji2kC3hO rl@Roberts-MBP.hyrule.local"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEhT5xDOtpRXYZQlebper6c0ZwC3JvTEOAcXb7j2+bp5 rl@rl-mbp"
    ];
  };
}
