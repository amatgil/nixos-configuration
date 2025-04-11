{
  networking.hostName = "dreanix";
  boot = {
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 5;
      efi.canTouchEfiVariables = true;
      #efi.efiSysMountPoint = "/boot";
    };
    kernel.sysctl."kernel.sysrq" = 1; # all functions
        # h: Print help to the system log.
        # f: Trigger the kernel oom killer.
        # s: Sync data to disk before triggering the reset options below.
        # e: SIGTERM all processes except PID 0.
        # i: SIGKILL all processes except PID 0.
        # b: Reboot the system.

    supportedFilesystems = [ "ntfs" ];
  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  services.fail2ban.enable = true;

}
