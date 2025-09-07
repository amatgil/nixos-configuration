# Help is available in the configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).


{ config, pkgs, ... }:

{
  # Flakes enable
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true; # mostly nvidia :(
  nixpkgs.config.nvidia.acceptLicense = true; # this is specifically nvidia lmao

  #nixpkgs.config.permittedInsecurePackages = ["electron-25.9.0" ]; # For obsidian

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


  services = {
    gvfs.enable = true;
    syncthing = {
      enable = true;
      user = "casenc";
      dataDir = "/home/casenc/Documents"; # Should really be moved from here
      configDir = "/home/casenc/.config/syncthing"; # Should really be moved from here
    };

    displayManager = {
      # Friendship ended with plasma, now awesomewm is my (old and new) best friend
      sddm.enable = true;
      defaultSession = "none+awesome";
    };

    printing.enable = true; # TODO: Doesn't work?
    picom.enable = true;  # Compositor

    tor = {
      enable = true;
      openFirewall = true;
      torsocks.enable = true;
      client.enable = true;
    };

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
        variant = "nodeadkeys"; # "cat"
        options = "compose:menu";
        # This is completed by the `keyd` service
      };

      windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luaPackages; [
          luarocks # package manager for lua
          luadbi-mysql
        ];
      };

      autoRepeatDelay = 250;
      autoRepeatInterval = 25;
    };

    keyd.enable = true; # Config file under /etc/keyd/capslock-rebind.conf
                        # see the `environment.etc."keyd/capslock-rebind.conf".source`
                        # line below
    

    #foldingathome.enable = true;
  };

  # see services.keyd
  environment.etc."keyd/capslock-rebind.conf".source = ../dotfiles/capslock-rebind.conf;

  programs.gnupg.agent = {
	  enable = true;
	  #pinentryFlavor = "curses";
	  pinentryPackage = pkgs.pinentry-qt;
	  enableSSHSupport = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    # OUTDATED: It's an OR: if it's older than 20d OR it's not the last four gens, it's byebye'd
    clean.extraArgs = "--keep-since 100d";
    flake = "/etc/nixos";
  };

  stylix = {
    enable = true;
    image = ../dotfiles/awesome/wallpaper.jpg;
    polarity = "dark";
    cursor.package = pkgs.qogir-icon-theme;
    cursor.name = "Qogir Cursors";
    cursor.size = 32;
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

    base16Scheme = ../dotfiles/catppuccin-mocha.yaml;

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
  #sound.enable = true;
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
    extraGroups = [ "networkmanager" "wheel" "video" "scanner"
                    "lp"
                    "uinput" # kanata (deprecated?)
                    "kvm"
                  ];
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
    usbutils
    rsync
    glib # gio (gvfs)
    man-pages
    man-pages-posix
    xdotool
    bc
    radeontop
    xorg.xev
    gnuplot
    slock
    fzf
  ];
  documentation.dev.enable = true; # https://nixos.wiki/wiki/Man_pages

  fonts.packages = with pkgs; [
    iosevka
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
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

