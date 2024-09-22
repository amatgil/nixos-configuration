# Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).


{ config, pkgs, ... }:

{
  # Flakes enable
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0" ]; # For obsidian

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
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

  services.displayManager = {
	# Friendship ended with plasma, now awesomewm is my (old and new) best friend
	  sddm.enable = true;
	  defaultSession = "none+awesome";
  };

  services = {
    printing.enable = true; # Enable CUPS to print documents.
    picom.enable = true;  # Compositor

    pipewire = {
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

    xserver = {
      enable = true;
      xkb = {
        layout = "es";
        variant = "cat";
        options = "caps:escape,compose:menu"; # TODO: disable normal escape
      };
      #xkbOptions = "esc:swapcaps,compose:Menu";
      windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
          luarocks # package manager for lua
          luadbi-mysql
        ];
      };

      autoRepeatDelay = 300;
      autoRepeatInterval = 50;
    };
  };



  programs.gnupg.agent = {
	  enable = true;
	  #pinentryFlavor = "curses";
	  pinentryPackage = pkgs.pinentry-qt;
	  enableSSHSupport = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    # It's an OR: if it's older than 4d OR it's not the last three gens, it's byebye'd
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/etc/nixos";
  };

  stylix = {
    enable = true;
    image = ../dotfiles/awesome/wallpaper.jpg;
    polarity = "dark";
    cursor.package = pkgs.qogir-icon-theme;
    cursor.name = "Qogir Cursors";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    opacity = {
      applications = 1.0;
      terminal = 0.9;
      desktop = 1.0;
      popups = 1.0;
    };
    fonts = {
      sizes = {
        applications = 12;
        terminal = 10;
        desktop = 10;
        popups = 13;
      };
      serif = {
        package = pkgs.iosevka;
        name = "Iosevka";
      };
      sansSerif = {
        package = pkgs.iosevka;
        name = "Iosevka";
      };
      monospace = {
        package = pkgs.iosevka;
        name = "Iosevka";
      };
      emoji = {
        package = pkgs.uiua386;
        name = "Uiua386";
      };
    };
  };

  programs.steam.enable = true;

  console.keyMap = "es";


  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.sane = {
    enable = true; # enables support for SANE scanners
    extraBackends = [ pkgs.hplipWithPlugin ];
  };
  security.rtkit.enable = true;
  security.polkit = {
    enable = true;
    #package = pkgs.lxqt.lxqt-policykit;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.casenc = {
    isNormalUser = true;
    description = "casenc";
    extraGroups = [ "networkmanager" "wheel" "video" "scanner" "lp"];
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
    nh
    nix-output-monitor
    nvd
    acpi
    pavucontrol
    brightnessctl # dkhfhdsfklhsf brighmthrness
    fdupes
    networkmanagerapplet
    xsane
    man-pages
    man-pages-posix
  ];
  documentation.dev.enable = true; # https://nixos.wiki/wiki/Man_pages

  environment.variables.EDITOR = "emacs";

  fonts.packages = with pkgs; [
    iosevka
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    inconsolata
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
  ];
  #virtualisation.docker.enable = true;
  #users.extraGroups.docker.members = [ "casenc" ]; # Equivalent to root, careful
  system.stateVersion = "23.11"; # NO TOUCHY
}

