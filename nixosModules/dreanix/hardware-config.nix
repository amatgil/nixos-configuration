# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/f589e331-2cfa-44cc-9238-7c810c8cab51";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/7836-23C4";
      fsType = "vfat";
    };

  fileSystems."/media/Endeavor" =
    { device = "/dev/disk/by-uuid/0da0cbdc-aa70-4ecc-8bf2-69182d6580ff";
      fsType = "ext4";
      options = [ "nofail" ];
    };

  fileSystems."/media/HDD" =
    { device = "/dev/disk/by-uuid/5AE6E755E6E72FC5";
      fsType = "ntfs-3g";
      options = [ "nofail" "permissions" ];
    };


  swapDevices =
    [ { device = "/dev/disk/by-uuid/2c754fb7-c1f5-48a9-8594-6aec176eaf8c"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
