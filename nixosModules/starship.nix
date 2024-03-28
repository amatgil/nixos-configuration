{ programs, ... }:
{
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
}
