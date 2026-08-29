{
  networking = {
    nameservers = [
      # "192.168.1.1"
      # "1.0.0.1"
    ];
    networkmanager = {
      enable = true;
    };
    wireguard.enable = true;
    firewall = {
      enable = true;
      checkReversePath = false;
      allowedTCPPorts = [
        8888
        11601
      ];
    };
  };

}
