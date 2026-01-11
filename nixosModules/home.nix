{ config, pkgs, lib, ... }: {
  home.username = "casenc";
  home.homeDirectory = "/home/casenc";

  nixpkgs.config.allowUnfree = true;
  #nixpkgs.config.permittedInsecurePackages = [
  #  "electron-25.9.0" # For obsidian
  #];

  # NO TOUCHY
  home.stateVersion = "23.11"; 

  # The home.packages option allows you to install Nix packages into your
  # environment.
  # # A list of them is at https://search.nixos.org/packages

  home.packages = with pkgs; [
    (callPackage (fetchFromGitHub {
      owner = "amatgil";
      repo = "plantill";
      rev = "master";
      sha256 = "sha256-y3vvw4NlgTLnqNqecwDpQknTvKqIvNA0whHgRW/bHoE=";
    }) {})
    (callPackage (fetchFromGitHub {
      owner = "amatgil";
      repo = "hamster";
      rev = "master";
      sha256 = "sha256-pE2gmFcS+RQqr1OZo4MMjaHrRkCa/F/tpQbS6S+0LrI=";
    }) {})
    nemo
    imagemagick
    keepassxc
    zathura
    sxiv
    neovim
    neovide
    arandr
    bacon
    bat
    qbittorrent
    just
    sccache
    tealdeer
    silicon
    bottom
    cargo-sweep
    eza
    hexyl
    gitui
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
    dust # du-dust
    qbittorrent
    mullvad-vpn
    alacritty
    pinentry-emacs
    delta
    meld
    pandoc
    texlive.combined.scheme-full 
    groff
    encfs
    qalculate-gtk
    firefox
    thunderbird
    zip
    unzip
    silicon
    fzf
    qdirstat
    (prismlauncher.override {
      jdks = [
        temurin-bin-21
        temurin-bin-8
        temurin-bin-17
      ];})
    file

    neovim

    dmenu
    mold
    xmousepasteblock
    keepassxc
    thunderbird
    devour
    imagemagick
    yt-dlp

    kdePackages.korganizer # i don't remember if i ever used this
    kdePackages.kruler  # neat :D
    kdePackages.ktimer  # self-explanatory
                kronometer  # self-explanatory
    kdePackages.kmines  # game
    kdePackages.knights # game
    kdePackages.minuet  # music practice
    kdePackages.kalzium # periodic table
    libreoffice
    inkscape
    fontforge-gtk
    ascii
    kicad-small

    ungoogled-chromium
    strawberry
    gforth
    gimp

    obs-studio

    rustup
    ghc
    uiua-unstable
    jdk21_headless # might as well have it :/
    
    (rWrapper.override { packages = with rPackages; [ggplot2 readr tidyverse dplyr xts]; })
    (rstudioWrapper.override{ packages = with rPackages; [ggplot2 readr tidyverse dplyr xts]; })


    janet
    (pkgs.jpm.overrideAttrs (old: {
      buildInputs = old.buildInputs ++ [ pkgs.makeWrapper ];
      postInstall = "wrapProgram $out/bin/jpm --add-flags '--libpath=${pkgs.janet}/lib --ldflags=-L${pkgs.glibc}/lib --local'";
    }))

    gdb

    virt-viewer openfortivpn # uni

    mold

    cmake


    # X11 dependencies (for raylib)
    libGL xorg.libX11 xorg.libX11.dev xorg.libXcursor xorg.libXi xorg.libXinerama xorg.libXrandr
    #emscripten
    pkg-config

    evince

    elmPackages.elm elmPackages.elm-language-server uglify-js

    llvmPackages_20.clang-tools # clangd
  ];

  programs = {
    rofi = {
      enable = true;
      #theme = "android_notification"; # stylix takes care of it
    };

    # For shell scripting
    nushell = {
      enable = true;
      #plugins = with pkgs.nushellPlugins; [query];
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      plugins = [{
        name = "zsh-vi-mode";
        src = "${pkgs.zsh-vi-mode}/share/zsh-vi-mode";
      }];
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
        ignoreDups = true;
        ignoreSpace = true;
      };
      initContent = "export GPG_TTY=$(tty)";
      shellAliases = {
        l="eza -l --color=always --icons=always --no-user --no-time"; # Per defecte
        lg="eza -l --color=always --icons=always --no-user --no-time --git"; # Per defecte + git
        la="eza -al --color=always --icons=always --group-directories-first";  # Tot
        ld="eza -l --color=always --icons=always --group-directories-first --no-user --no-time";  # Dirs first
        ldd="eza -al --color=always --icons=always --only-dirs --no-user --no-time";  # Dirs only
        lt="eza -aT --color=always --icons=always --group-directories-first --no-user --no-time"; # Arbre
        lm="eza --sort=size --icons=always -al --color=always --no-user --no-time"; # Tot, ordenat per mida
        
        e="emacsclient . &";

        grep="grep -i --color=auto"; egrep="egrep --color=auto"; fgrep="fgrep --color=auto";
        cp="cp -iv"; rm="echo 'Dont rm, mv to /tmp instead'"; mv="mv -iv";
        cat="bat --paging=never";

        doas="doas "; sudo="sudo ";
        fucking="sudo"; please="sudo $(fc -ln -1)"; # Apparently works with both bash and zsh, `fc` is a shell builtin

        glg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";

        img="devour sxiv"; pdf="devour zathura";
        cal="cal -m";

        v="nvim"; top="btm"; sys="systemctl";
        ifconfig="ip --brief --color address";
        cmatrix="cmatrix -C blue -b";
        sping="ping -c20 gnu.org";
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
        sbcl="rlwrap sbcl";

        dc="echo 'Did you mean cd lmao'";
      };
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;

      settings = {
        format = "[┌](bold #C74DED) [󰄛 ](bold #C74DED) '$directory' de $hostname ($all)[└](bold #C74DED) $character\n";
        add_newline = false;
        buf = {symbol = " ";};
        c = {symbol = " ";};
        character = {
          success_symbol = "[⍜](bold purple)";
          error_symbol = "[⍥](red)";
          vimcmd_symbol = "[⍥](bold bright-yellow)";
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
        #direnv.disabled = false;
        spack = {symbol = "🅢 ";};
        username = {
          disabled = false;
          format = "[$user](bold dimmed blue) ";
          show_always = false;
        };
      };
    };

    # BEGIN AUTORANDR AREA

    # interesting: https://bacardi55.io/2023/07/10/new-laptop-part-6-managing-multi-screens-with-i3wm-and-autorandr/ 
    autorandr = {
      enable = true;
      profiles = {
        dreanix-default = {
          fingerprint = { # todo: update and generalize for more devices
            "HDMI-1" = "00ffffffffffff0010ac9ca04d414b340c1a0103a0351e78eaa0a5a656529d270f5054a54b00714f8180010101010101010101010101023a801871382d40582c45000f292100001e000000ff004b4b4d4d57363348344b414d0a000000fc0044454c4c205032343134480a20000000fd00384c1e5311000a20202020202001ab02031bc1230904038301000067030c002000802d43908402e2000f8c0ad08a20e02d10103e9600a05a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d0";
            "HDMI-2" = "00ffffffffffff001e6d555be37a0b00081e010380301b78ea3135a5554ea1260c5054a54b00714f81809500b300a9c0810081c09040023a801871382d40582c4500e00e1100001e000000fd00384b1e5512000a202020202020000000fc004c472046554c4c2048440a2020000000ff003030384e544d584e343335350a017402031bf14890040301121f1013230907078301000065030c001000023a801871382d40582c4500e00e1100001e2a4480a07038274030203500e00e1100001e011d007251d01e206e285500e00e1100001e8c0ad08a20e02d10103e9600e00e11000018000000000000000000000000000000000000000000000000000000004b";
          };
          config = {
            "HDMI-2" = {
              enable = true;
              primary = true;
              crtc = 0;
              mode = "1920x1080";
              position = "0x0";
              rate = "60.00";
            };
            "HDMI-1" = {
              enable = true;
              crtc = 0;
              mode = "1920x1080";
              position = "1920x0";
              rate = "60.00";
            };
          };
        };
      };
    };

  };
  services = {
    autorandr.enable = true;
    dunst.enable = true;
  };


  # END AUTORANDR AREA

  xdg.configFile.plantill.source = ../dotfiles/plantill;
  xdg.configFile.awesome.source = ../dotfiles/awesome;

  # Emacs gets its own area
  # TODO: Extract this out into its own file
	programs.emacs = {
		enable = true;
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
    startWithUserSession = "graphical";
  };

  xdg.configFile.emacs = {
    source =
      let
        casuiua-src = pkgs.fetchFromGitHub {
          owner = "amatgil";
          repo = "casuiua-mode";
          rev = "master";
          sha256 = "sha256-1zLvMeHgewzs5Y3B3zG6nB30SfV7J8yofUV95+JWWGo=";
        };
        lean4-src = pkgs.fetchFromGitHub {
          owner = "leanprover-community";
          repo = "lean4-mode";
          rev = "master";
          sha256 = "sha256-6XFcyqSTx1CwNWqQvIc25cuQMwh3YXnbgr5cDiOCxBk=";
        };
      in
        pkgs.stdenv.mkDerivation rec {
          name = "emacs-tangle-init";
          src = ../dotfiles/emacs;
          unpackPhase = ''
            cp -r ${src}/* .
            cp -r ${casuiua-src}/casuiua-mode.el .
            cp -r ${lean4-src} ./lean4-mode
          '';
          buildPhase = ''
            ${pkgs.figlet}/bin/figlet "Tangling Emacs..."
            mkdir -p $out
            ${pkgs.emacs}/bin/emacs --batch --eval "(require 'org)" --eval "(org-babel-tangle-file \"literate-init.org\")"
          '';
          installPhase = ''
            cp    init.el         $out
            cp    casuiua-mode.el $out
            cp -r lean4-mode      $out
            ${pkgs.figlet}/bin/figlet "Installed init.el"
          '';
        };

  	recursive = true;
	};

  # TODO: Put these programs.* under the other programs = {...} section
	programs.git = {
		enable = true;
		userName = "amatgil";
		userEmail = "amatgilvinyes@gmail.com";
		extraConfig = {
      rerere.enabled = 1;
			user.signingkey = "D34BAAD5029249C9";
			init.defaultBranch = "master";
			core = {
				pager = "delta";
				editor = "emacsclient";
        fileMode = false;
			};
      merge.tool = "emacs";
			interactive.diffFilter = "delta --color-only";
      alias = {
        add = "add -p";
        wdiff = "diff --word-diff";
      };
			delta = {
        enable = true;
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
      github.user = "amatgil";
		};
    aliases = {
      s = "status";
      c = "commit";
    };
	};

  programs.alacritty = {
  	enable = true;
  	settings = {
  	  font = lib.mkForce {
  	    #size = 12;
  	    normal.family = "Uiua386";
  	  };
  	  #window.opacity = 1;

  	  terminal.shell.program = "${pkgs.zsh}/bin/zsh";
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

  home.file.".cargo/config.toml".text = ''
    [target.x86_64-unknown-linux-gnu]
    linker = "${pkgs.llvmPackages.clangUseLLVM}/bin/clang"
    rustflags = ["-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/mold"]
  '';


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
