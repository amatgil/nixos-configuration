{ config, pkgs, ... }: {
  home.username = "casenc";
  home.homeDirectory = "/home/casenc";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0" # For obsidian
  ];

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
    firefox
    thunderbird
    fzf

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

    korganizer
    
    iosevka # Untested
  ];

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
      epkgs.undo-fu
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
			safe.directory="*";
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
