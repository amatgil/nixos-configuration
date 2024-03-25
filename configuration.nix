# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # And home-manager so that the options can be set from in here
      <home-manager/nixos>
    ];

  # Bootloader.
  boot = {
    loader = {
      #grub = {
      #  enable = true;
      #  useOSProber = true;
      #  efiSupport = true;
      #  device = "nodev";
      #  extraEntriesBeforeNixOS = true;
      #};
      #efi.efiSysMountPoint = "/boot/efi";
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 3;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
    };
    
    supportedFilesystems = [ "ntfs" ];
  };

  nix.gc = {
    automatic = true;
    randomizedDelaySec = "14m";
    options = "--delete-older-than 10d";
  };

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "dreanix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # DON'T Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = false;
  services.xserver.desktopManager.gnome.enable = false;

  # Plasma my beloved
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Keyboard layout(s)
  #
  # services.kanata = {
  #    enable = true;
  #    keyboards = { # "teclat" is the name of the keyboard
  #      "teclat".config = ''
  #(defcfg
  #	process-unmapped-keys yes
  #)
  #(defsrc
  #)
  #  '';
  #    };
  #  };
  # Dwm my beloved
  #  #services.xserver.windowManager.dwm.package = pkgs.dwm.overrideAttrs {
  #  src = ./dwm;
  #};

  # Configure keymap in X11
  services.xserver = {
    layout = "es";
    xkbVariant = "cat";
  };

  # Configure console keymap
  console.keyMap = "es";

  # remaps
  services.xserver.xkbOptions = "esc:swapcaps";
  services.xserver.autoRepeatDelay = 300;
  services.xserver.autoRepeatInterval = 50;


  # Enable CUPS to print documents.
  services.printing.enable = true;

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

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.casenc = {
    isNormalUser = true;
    description = "casenc";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
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
  ];

  fonts.packages = with pkgs; [
    iosevka
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  home-manager.users.casenc = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;
	  nixpkgs.config.permittedInsecurePackages = [
      "electron-25.9.0" # For obsidian
    ];
  	home.username = "casenc";
  	home.homeDirectory = "/home/casenc";

  	# NO TOUCHY
  	home.stateVersion = "23.11"; 

  	# The home.packages option allows you to install Nix packages into your
  	# environment.
  	# # A list of them is at https://search.nixos.org/packages
    home.packages = with pkgs; [
      cargo
      rustc
      keepassxc
      zathura
      sxiv
      neovim
      neovide
      bacon
      bat
      just
      sccache
      tealdeer
      silicon
      zoxide
      bottom
      cargo-sweep
      eza
      du-dust
      hexyl
      gitui
      gitoxide
      zellij
      starship
      vscodium-fhs
      alejandra
      obsidian
      nil
      tokei
      eza
      monocraft
      killall
      ripgrep
      wget
      yt-dlp
      du-dust
      qbittorrent
      mullvad-vpn
      yakuake
      alacritty
      delta
      meld
      pandoc
      texlive.combined.scheme-full 
      groff
      encfs
      qalculate-gtk

  	  neovim

  	  zsh
  	  zsh-autocomplete
  	  zsh-autosuggestions
  	  zsh-syntax-highlighting

  	  dunst
  	  dmenu
  	  mold
  	  xmousepasteblock
  	  keepassxc
  	  thunderbird
  	  devour
  	  imagemagick
      youtube-dl
      
      iosevka # Untested
	  ];
  	# Keep in mind, these will end up in ~/
  	home.file = {
  		".zshrc".source = ./dotfiles/shell/zshrc;
  		".shell_aliases".source = ./dotfiles/shell/shell_aliases;
  	};

    programs.starship = {
      enable = true;
      settings = {
        add_newline = false;
        buf = {symbol = " ";};
        c = {symbol = " ";};
        character = {
          error_symbol = "[](red)";
          success_symbol = "[](bold purple)";
        };
        cmd_duration = {
          disabled = false;
          min_time = 30;
          show_milliseconds = false;
        };
        directory = {
          format = "[$path](bold cyan)";
          read_only = " ";
          truncate_to_repo = false;
          truncation_length = 4;
          truncation_symbol = "../";
        };
        docker_context = {symbol = " ";};
        format = "[┌](bold #C74DED) [󰄛 ](bold #C74DED) '$directory' de $hostname ($all)[└>](bold #C74DED) $character\n";
        git_branch = {symbol = " ";};
        haskell = {symbol = " ";};
        hg_branch = {symbol = " ";};
        hostname = {
          disabled = false;
          format = "[$hostname](bold purple)";
          ssh_only = false;
        };
        lua = {symbol = " ";};
        memory_usage = {symbol = " ";};
        package = {symbol = " ";};
        python = {symbol = " ";};
        rlang = {symbol = "ﳒ ";};
        ruby = {symbol = " ";};
        rust = {symbol = " ";};
        scala = {symbol = " ";};
        spack = {symbol = "🅢 ";};
        username = {
          disabled = false;
          format = "[$user](bold dimmed blue) ";
          show_always = false;
        };
      };
    };
  	xdg.configFile.dunst.source = ./dotfiles/dunst;
  	xdg.configFile.plantill.source = ./dotfiles/plantill;
  	xdg.configFile.nvim = {
  		source = ./dotfiles/nvim;
  		recursive = true;
  	};

	  programs.emacs = {
		  enable = true;
		  extraPackages = epkgs: [
			  epkgs.nix-mode
			  epkgs.evil
        epkgs.evil-collection
			  epkgs.magit
			  epkgs.rust-mode
			  epkgs.origami
		  ];
	  };
	  xdg.configFile.emacs = {
  		source = ./dotfiles/emacs;
  		recursive = true;
	  };
	  services.emacs.enable = true;

	  programs.git = {
		  enable = true;
		  userName = "amatgil";
		  userEmail = "amatgilvinyes@gmail.com";
		  extraConfig = {
			  user.singingkey = "D34BAAD5029249C9";
			  init.defaultBranch = "master";
			  core = {
				  pager = "delta";
				  editor = "nvim";
			  };
			  interactive.diffFilter = "delta --color-only";
			  delta = {
				  navigate = true; # change sections with n/N
				  light = false;   # for terminals with white bg
			  };
			  diff = {
				  tool = "meld";
				  colorMoved = "default";
			  };
			  difftool.prompt = false;
			  #difftool."meld".cmd = "meld \"$LOCAL\" \"$REMOTE\""; <-- how space?
			  commit.gpgsign = true;
			  pull.rebaes = true;
			  credential.helper = "cache --timeout 7200";
			  safe.directory="/etc/nixos";
		  };
	  };

	  programs.zsh.enable = true;
  	programs.alacritty = {
  	  enable = true;
  	  settings = {
  	    font = {
  	      size = 12;
  	      normal.family = "iosevka";
  	    };
  	    shell.program = "${pkgs.zsh}/bin/zsh";
  	    window.opacity = 1;
  	  };
  	};

  	#programs.zellij = {
  	#  enable = true;
  	#  settings.default_layout = "compact";
  	#};

	  programs.gpg.enable = true;
  	programs.hyfetch = {
  	  enable = true;
  	  settings = {
  	    args = null;
  	    backend = "neofetch";
  	    color_align = {
  	      custom_colors."1" = 3;
  	      custom_colors."2" = 2;
  	      fore_back = [];
  	      mode = "custom";
  	    };
  	    distro = null;
  	    light_dark = "dark";
  	    lightness = 0.65;
  	    mode = "rgb";
  	    preset = "asexual";
  	    pride_month_disable = false;
  	    pride_month_shown = [];
  	  };
  	};

  	programs.mpv = {
  	  enable = true;
  	  bindings = {
  	    RIGHT = "seek  5";
  	    LEFT = "seek  -5";
  	    UP = "seek  60";
  	    DOWN = "seek  -60";
  	    "Shift+RIGHT" = "no-osd seek  1";
  	    "Shift+LEFT" = "no-osd seek  -1";
  	    "[" = "add speed -0.05";
  	    "]" = "add speed 0.05";
  	    "Ctrl+[" = "add speed -0.25";
  	    "Ctrl+]" = "add speed 0.25";
  	    "{" = "multiply speed 0.5";
  	    "}" = "multiply speed 2.0";
  	  };
  	};

  	home.sessionVariables = {
  	  EDITOR = "nvim";
  	};

  	# Let Home Manager install and manage itself.
  	programs.home-manager.enable = true;

  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
