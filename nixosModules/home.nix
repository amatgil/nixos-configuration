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
    bottom
    cargo-sweep
    eza
    du-dust
    hexyl
    gitui
    gitoxide
    zellij
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
    silicon
    fzf

    neovim

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

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
      ignoreDups = true;
      ignoreSpace = true;
    };
    initExtra = "export GPG_TTY=$(tty)";
    shellAliases = {
      l="eza -l --color=always --icons=always --no-user --no-time"; # Per defecte
      lg="eza -l --color=always --icons=always --no-user --no-time --git"; # Per defecte + git
      la="eza -al --color=always --icons=always --group-directories-first";  # Tot
      ld="eza -l --color=always --icons=always --group-directories-first --no-user --no-time";  # Dirs first
      ldd="eza -al --color=always --icons=always --only-dirs --no-user --no-time";  # Dirs only
      lt="eza -aT --color=always --icons=always --group-directories-first --no-user --no-time"; # Arbre
      lm="eza --sort=size --icons=always -al --color=always --no-user --no-time"; # Tot, ordenat per mida

      grep="grep -i --color=auto";
      egrep="egrep --color=auto";
      fgrep="fgrep --color=auto";
      cp="cp -iv";
      rm="echo 'Dont rm, mv to /tmp instead'";
      mv="mv -iv";
      cat="bat --paging=never";

      doas="doas ";
      sudo="sudo ";
      fucking="sudo";
      please="sudo !!"; #Lmao

      glg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";

      img="devour sxiv"; #Replace image viewer
      hor="devour sxiv /media/HDD/School/horari20212022.png"; #Calendar & Horari
      cal="cal -m";

      v="nvim"; 
      nv="neovide .";
      pdf="devour zathura"; #Get in the habit of opening pdfs with Zathura
      wet="curl wttr.in";
      cheat="curl cheat.sh";
      top="btm"; # bottom, top pero amb Rust (aka millor)
      sys="systemctl";
      lisp="clisp";
      encfs="/etc/nixos/scripts/encfsMount";
      ifconfig="ip --brief --color address";
      cmatrix="cmatrix -C blue -b";
      playLast="mpv $(eza --sort=changed -l | tail -n1 | awk '{print $7}')";
      playlist="mpv * --shuffle --no-video";
      sping="ping -c20 archlinux.org";
      cmd="command"; # For things like 'command top'
      cd="z"; # zoxide
      zrem="zoxide remove $(pwd)";
      dunstoff="dunstctl set-paused true";
      dunston="dunstctl set-paused false";
      make_auth="/usr/bin/polkit-dumb-agent";
      record="ffmpeg -video_size 1920x1080 -framerate 25 -f x11grab -i :0.0 -f pulse -ac 2 -i default /tmp/screen_recording.mp4";
      gpu-top="sudo intel_gpu_top";
      whatismyip="curl https://am.i.mullvad.net/ip";
      mida="du -h . --max-depth=1";
      toclip="~/scripts/toclip";
      sbcl="rlwrap sbcl";
      syncfib="rsync /media/UPC/FIB/ ~/School/Quat1/ -rvzt && rsync ~/School/Quat1& /media/UPC/FIB/ -rvzt";
      music="mpv --no-video";
      "p1++"="g++ -ansi -O2 -DNDEBUG -D_GLIBCXX_DEBUG -Wall -Wextra -Werror -Wno-sign-compare -Wshadow"; # Uni
      "p2++"="g++ -ansi -O2 -DNDEBUG -D_GLIBCXX_DEBUG -Wall -Wextra -Werror -Wno-sign-compare -Wshadow"; # Uni part 2
    };
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
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
  xdg.configFile.dunst.source = ../dotfiles/dunst;
  xdg.configFile.plantill.source = ../dotfiles/plantill;

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
  	source = ../dotfiles/emacs;
  	recursive = true;
	};
	services.emacs.enable = true;

	programs.git = {
		enable = true;
		userName = "amatgil";
		userEmail = "amatgilvinyes@gmail.com";
		extraConfig = {
			user.signingkey = "D34BAAD5029249C9";
			init.defaultBranch = "master";
			core = {
				pager = "delta";
				editor = "emacs";
                                fileMode = false;
			};
                        merge.tool = "emacs";
			interactive.diffFilter = "delta --color-only";
                        alias = {
                          add = "add -p";
                          wdiff = "diff --word-diff";
                        };
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

  programs.alacritty = {
  	enable = true;
  	settings = {
  	  font = {
  	    size = 12;
  	    normal.family = "iosevka";
  	  };
  	  shell.program = "${pkgs.zsh}/bin/zsh";
  	  window.opacity = 1;
      cursor = {
        style = {
          shape = "Beam";
          blinking = "Always";
        };
        blink_interval = 500;
        thickness = 0.15;
      };
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

}
