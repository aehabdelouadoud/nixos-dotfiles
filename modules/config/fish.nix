# { config, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      "."  = "cd ..";
      ".." = "cd ../..";
      ".3" = "cd ../../..";
      "-"  = "cd -";
    };
    shellAliases = {
      ls = "eza -1  --icons";
      ll = "eza -l  --icons";
      la = "eza -al --icons";
      lt = "eza -al --tree";

      c  = "clear";
      e  = "exit";
      t  = "task";
      z  = "zathura";

      vt = "kitty @ set-spacing padding=0 && vit && kitty @ set-spacing padding=default";
      cat= "bat";
      spf= "superfile";
    };
  };

  # if status is-interactive
  #     # Commands to run in interactive sessions can go here
  # end
  #
  # set -U fish_greeting
  # # fortune
  # fish_vi_key_bindings
}

