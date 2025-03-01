{
  networking.hostName = "nixpad";

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  services.libinput = {
    enable = true;
    touchpad.scrollButton = 3;
  };


    
  boot.kernel.sysctl."kernel.sysrq" = 1; # all functions
    # h: Print help to the system log.
    # f: Trigger the kernel oom killer.
    # s: Sync data to disk before triggering the reset options below.
    # e: SIGTERM all processes except PID 0.
    # i: SIGKILL all processes except PID 0.
    # b: Reboot the system.


}
