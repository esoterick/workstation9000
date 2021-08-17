{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
    ./host.nix

    ./machines/current.nix
    ./homes/current.nix
  ];

  boot.cleanTmpDir = true;
  networking.hostName = "rlambert-wk";
  networking.firewall.allowPing = true;
  services.openssh.enable = true;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE0y63gYBa2F+lBNISfNvCsDQPeHNyPIFgWWji2kC3hO rl@Roberts-MBP.hyrule.local"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEhT5xDOtpRXYZQlebper6c0ZwC3JvTEOAcXb7j2+bp5 rl@rl-mbp"
  ];
}  



