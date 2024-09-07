{
  networking.hostName = "dreanix";
  boot = {
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 3;
      efi.canTouchEfiVariables = true;
      #efi.efiSysMountPoint = "/boot";
    };
    kernel.sysctl."kernel.sysrq" = 1;
    supportedFilesystems = [ "ntfs" ];
  };

}
