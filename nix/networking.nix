{ lib, ... }: {
  # This file was populated at runtime with the networking
  # details gathered from the active system.
  networking = {
    nameservers = [ "10.74.165.35"
 "10.74.61.46"
 ];
    defaultGateway = "10.124.56.1";
    defaultGateway6 = "";
    dhcpcd.enable = false;
    usePredictableInterfaceNames = lib.mkForce false;
    interfaces = {
      eth0 = {
        ipv4.addresses = [
          { address="10.124.57.31"; prefixLength=21; }
        ];
        ipv6.addresses = [
          { address="fe80::ecce:40ff:feb0:79fc"; prefixLength=64; }
        ];
        ipv4.routes = [ { address = "10.124.56.1"; prefixLength = 32; } ];
        ipv6.routes = [ { address = ""; prefixLength = 128; } ];
      };
      
    };
  };
  services.udev.extraRules = ''
    ATTR{address}=="ee:ce:40:b0:79:fc", NAME="eth0"
    
  '';
}
