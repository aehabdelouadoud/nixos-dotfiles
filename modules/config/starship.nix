# { config, pkgs, ... }:
{
  programs.starship.enable = true;
  programs.starship.settings = {
    add_newline = false;
    right_format = "$memory_usage$cmd_duration";
    format =
      ''$hostname$username$directory$git_branch$git_status$c$golang
        $character$shell
      '';

    character = {
      success_symbol            = "[ ](bold fg:blue)[ ](bold bg:blue fg:black)[](bold fg:blue)";
      error_symbol              = "[ ](bold fg:red )[ ](bold bg:red  fg:black)[](bold fg:red)";
      vimcmd_symbol             = "[ ](bold fg:blue)[ ](bold bg:blue fg:black)[](bold fg:blue)";
      vimcmd_replace_one_symbol = "[ ](bold fg:blue)[ ](bold bg:blue fg:black)[](bold fg:blue)";
      vimcmd_replace_symbol     = "[ ](bold fg:blue)[ ](bold bg:blue fg:black)[](bold fg:blue)";
      vimcmd_visual_symbol      = "[ ](bold fg:blue)[ ](bold bg:blue fg:black)[](bold fg:blue)";
    };

    # package = {
    #   disabled = true;
    # };

    # [line_break]
    # disabled = false

    git_branch = {
      style             = "fg: blue";
      symbol            = "󰘬 ";
      truncation_length = 4;
      truncation_symbol = "";
      format            = " [$symbol $branch(:$remote_branch)]($style)";
    };


    git_commit = {
      commit_hash_length = 4;
      tag_symbol = "";
    };

    git_state = {
      format      = "[\($state( $progress_current of $progress_total)\)]($style)";
      cherry_pick = "[ PICKING](bold red)";
    };

    git_status = {
      conflicted = " ";
      ahead      = "󰛃 ";
      behind     = "󰛀 ";
      diverged   = " "; # 󰽜 󰃸
      untracked  = " ";
      stashed    = " ";
      modified   = " ";
      staged     = "[++\($count\)](blue)"; #  
      up_to_date = " ";
      renamed    = " ";
      deleted    = " ";
      style = "fg:blue";
      format = "($all_status$ahead_behind($style) )";
    };


    git_metrics = {
      disabled = false;
    };


    hostname = {
      ssh_only = false;
      format   =  "[ ](bold fg:blue)[$hostname](bg:blue bold fg:black)[ ](bold fg:blue)";
      trim_at  = ".companyname.com";
      disabled = false;
    };


    memory_usage = {
      disabled  = true;
      threshold = 5;
      symbol    = "󰍛";
      style     = "dimmed blue";
      format    = "$symbol [${ram}]($style)";
    };


    # time = {
    #   disabled    = true;
    #   format      = " [\[ $time \]]($style)";
    #   time_format = "%T";
    # };
  };
}
