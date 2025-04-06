{
  networking = {
    hosts = {
        "127.0.0.1" = [ "www.goldpharma.lan" ];
        "192.168.1.200" = [ "intergold.lan" ];
        "192.168.1.110" = [ "goldpharma.local" ];
        "192.168.1.111" = [ "uat.goldpharma.local" ];
    };

    networkmanager.enable = true;
    wireguard.enable = true;
    firewall = {
      enable = true;
      checkReversePath = false;
      allowedTCPPorts = [ 1337 ];
    };
  };

}
