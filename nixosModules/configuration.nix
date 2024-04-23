# Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 3;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
    };
    kernel.sysctl."kernel.sysrq" = 1;
    supportedFilesystems = [ "ntfs" ];
  };

  nix.gc = {
    automatic = true;
    randomizedDelaySec = "14m";
    options = "--delete-older-than 10d";
  };
  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # I don't know why these have to be here, they're already in home.nix
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0" ]; # For obsidian

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.hostName = "dreanix"; # Define your hostname.
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Madrid";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ca_ES.UTF-8";
    LC_IDENTIFICATION = "ca_ES.UTF-8";
    LC_MEASUREMENT = "ca_ES.UTF-8";
    LC_MONETARY = "ca_ES.UTF-8";
    LC_NAME = "ca_ES.UTF-8";
    LC_NUMERIC = "ca_ES.UTF-8";
    LC_PAPER = "ca_ES.UTF-8";
    LC_TELEPHONE = "ca_ES.UTF-8";
    LC_TIME = "ca_ES.UTF-8";
  };

  services.xserver = {
    enable = true;
    layout = "es";
    xkbVariant = "cat";

    # Plasma my beloved
    #displayManager.sddm.enable = true;
    #desktopManager.plasma5.enable = true;

    # Friendship ended with plasma, now awesomewm is my (old and new) best friend
    displayManager = {
      sddm.enable = true;
      defaultSession = "none+awesome";
    };

    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # package manager for lua
        luadbi-mysql
      ];
    };

    # Remaps
    xkbOptions = "esc:swapcaps";
    autoRepeatDelay = 300;
    autoRepeatInterval = 50;
  };
  programs.gnupg.agent = {
	  enable = true;
	  #pinentryFlavor = "curses";
	  pinentryFlavor = "emacs";
	  enableSSHSupport = true;
  };


  console.keyMap = "es";

  services.printing.enable = true; # Enable CUPS to print documents.

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.casenc = {
    isNormalUser = true;
    description = "casenc";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = []; # They're all in home-manager
  };

  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    lua
    wget
    lf
    gitFull
    gcc
    clang
    nil # nix lsp
    mpv
    xclip # For (n)vim clipboard access
    ffmpeg
    kanata # Keyboard layout
    pinentry-curses
  ];
  environment.variables.EDITOR = "emacs";
  fonts.packages = with pkgs; [
    iosevka
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    noto-fonts
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
  #virtualisation.docker.enable = true;
  #users.extraGroups.docker.members = [ "casenc" ]; # Equivalent to root, careful
  system.stateVersion = "23.11"; # NO TOUCHY
}
