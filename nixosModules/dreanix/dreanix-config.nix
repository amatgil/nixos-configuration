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

  # https://chrisdown.name/2026/03/24/zswap-vs-zram-when-to-use-what.html
  # Meaning: zram bad {{
  # boot.kernel.sysctl = {
  #   "vm.swappiness" = 180;
  #   "vm.watermark_boost_factor" = 0;
  #   "vm.watermark_scale_factor" = 125;
  #   "vm.page-cluster" = 0;
  # };
  # zramSwap = {
  #   enable = true;
  #   algorithm = "zstd";
  #   memoryPercent = 100;
  # };
  # }}
  # And meaning: zswap good
  # Yoinked from https://wiki.nixos.org/wiki/Swap
  boot.kernelParams = [
    "zswap.enabled=1" # enables zswap
    "zswap.compressor=lz4" # compression algorithm
    "zswap.max_pool_percent=20" # maximum percentage of RAM that zswap is allowed to use
    "zswap.shrinker_enabled=1" # whether to shrink the pool proactively on high memory pressure
  ];
  boot.initrd.systemd.enable = true;

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

  #services.fail2ban.enable = true;

}
