{
  networking = {
    hosts = {
      "127.0.0.1" = [ "www.goldpharma.lan" ];
      "10.80.0.1" = [
        "www.goldpharma.lan"
        "phpmyadmin.goldpharma.fr"
      ];
      "192.168.1.200" = [ "intergold.lan" ];
      "192.168.1.50" = [ "rialto.goldpharma.lan" ];
      "192.168.1.110" = [ "goldpharma.local" ];
      "192.168.1.111" = [ "uat.goldpharma.local" ];
      "192.168.1.27" = [ "nas.goldpharma.lan" ];
      "51.77.110.239" = [ "ctfcorp.local" ];
    };

    networkmanager = {
      enable = true;
    };
    wireguard.enable = true;
    firewall = {
      enable = true;
      checkReversePath = false;
      allowedTCPPorts = [ 1337 ];
    };
  };

}
