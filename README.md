# workstation9000

## Setup

1. Deploy one of the supported droplets on DO
2. Use https://github.com/elitak/nixos-infect to infect the droplet
3. Pull down the repo...

``` sh
nix-shell -p git
mkdir src; cd src
git clone https://github.com/esoterick/workstation9000
cd workstation9000
```

4. Backup current nix config

``` sh
mkdir /etc/nixos/backup
mv /etc/nixos/*.nix /etc/nixos/backup/.
```

5. Setup Symlinks

``` sh
ln -s $(pwd -P)/nix/configuration.nix /etc/nixos/configuration.nix
ln -s $(pwd -P)/nix/machines/wk.nix ./nix/machines/current.nix
```

6. Build machine

``` sh
nixos-rebuild build
# if all goes well
nixos-rebuild switch
# exit from root
exit
```

7. SSH to node as non-priv user
8. Install home-manager

``` sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

9. Setup home-manager Symlinks

``` sh
rm ~/.config/nixpkgs/home.nix
ln -s (pwd -P)/nix/homes/wk.nix ./nix/homes/current.nix
ln -s (pwd -P)/nix/homes/current.nix ~/.config/nixpkgs/home.nix
```

10. Build and switch home

``` sh
home-manager build
# if all goes well
home-manager switch
```

