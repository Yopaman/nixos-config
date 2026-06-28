{
  networking = {
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
