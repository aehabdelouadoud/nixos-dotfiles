# { config, pkgs, ... }:
{
  dunst = {
    enable = true;
    settings = {
      global = {
        sort = "yes";
        font = "Droid Sans 9";
        width = 300;
        height = 300;
        offset = "20x20";
        origin = "top-right";
        progress_bar = true;
        progress_bar_corner_radius = 4;
        corner_radius = 5;
        progress_bar_height = 5;
        separator_height = 10;
        gap_size = 10;
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "close_current";
        mouse_right_click = "close_all";
        # browser = "/run/current-system/sw/bin/xdg-open";
        browser = "librewolf";
        # progress_color = "#658CD0";
      };

      urgency_critical = {
        background  = "#C3477D";
        foreground  = "#cccccc";
        frame_color = "#C3477D";
        timeout = 0;
      };

      urgency_normal = {
        background  = "#cccccc";
        foreground  = "#202020";
        frame_color = "#202020";
        timeout = 5;
      };

      urgency_low = {
        background  = "#cccccc";
        foreground  = "#202020";
        frame_color = "#202020";
        timeout = 3;
      };
    };
  };
}
