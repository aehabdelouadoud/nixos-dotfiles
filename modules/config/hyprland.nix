{ /* config,  */pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    settings = {
      exec = [
        "hyprctl setcursor 'macOS-BigSur-White' 20"
      ];

      exec-once = [
        "nm-applet --indicator"
        "blueman-applet"
        "udiskie"
        "waybar"
        "swww-daemon --format xrgb && swww img ./backgroud.jpg"
        "batsignal -e -b -p -w 20 -c 10 -d 5 -f 90 -D \"systemd suspend\" -m 1"
      ];

      monitor = ",preferred,auto,auto";

      "$terminal"    = "kitty";
      "$fileManager" = "kitty -e superfile";
      "$menu"        = "wofi --show drun";
      "$browser"     = "qutebrowser";

      env = [
        "XCURSOR_THEME,macOS-BigSur-White"
        "XCURSOR_SIZE,20"
        "HYPRCURSOR_SIZE,20"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;

        border_size = 0;

        # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        "col.active_border"   = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        layout = "master";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#decoration
      decoration = {
        rounding = 3;
        shadow = {
          enabled = true;
          range = 10;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        # active_opacity = 1.0;
        # inactive_opacity = 0.8;
        # fullscreen_opacity = 1.0;
        dim_inactive = true;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };

      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations = {
        enabled = true; # Def
        first_launch_animation = true; # Def
        # https://wiki.hyprland.org/Configuring/Animations
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows,     1, 7,  myBezier"
          "windowsOut,  1, 7,  default, popin 80%"
          "border,      1, 10, default"
          "borderangle, 1, 8,  default"
          "fade,        1, 7,  default"
          "workspaces,  1, 6,  default"
        ];
      };

      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # https://wiki.hyprland.org/Configuring/Variables/#misc
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0.5;
        touchpad = {
          natural_scroll = false;
        };
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
      };

      # See https://wiki.hyprland.org/Configuring/Master-Layout
      master = {
        new_status = "master";
        mfact = 0.55;
      };

      # Variables

      "$mod"   = "SUPER";
      "$modsh" = "SUPER SHIFT";

      # Bindings

      bindm = [
        # mouse movements
        "$mod,   mouse:272, movewindow"
        "$modsh, mouse:272, resizewindow"
      ];

      bind = [
        "$mod,     Z,         exec,           zathura"
        "$mod,     N,         exec,           neovide"
        "$mod,     M,         exec,           wofi --show drun -show-icons || pkill wofi"
        "$mod,     RETURN,    exec,           $terminal"
        "$mod,     T,         exec,           foot"
        "$mod,     B,         exec,           $browser"
        "$mod,     Q,         killactive,     "
        "$mod,     DELETE,    exit,           "
        "$mod,     E,         exec,           $fileManager"
        "$mod,     BACKSPACE, exec,           wlogout"
        "$mod,     ESCAPE,    exec,           pkill waybar || waybar"
        "$mod,     F,         fullscreen"
        "$mod ALT, V,         togglefloating, "
        "$mod ALT, P,         pseudo,         "
        "$mod ALT, J,         togglesplit,    "

        "$mod,       P, exec, hyprshot -s -m window -o /tmp -f screenshot.png && satty --filename=/tmp/screenshot.png"
        "$mod SHIFT, P, exec, hyprshot -s -m region -o /tmp -f screenshot.png && satty --filename=/tmp/screenshot.png"

        # Move focus with mainMod + (vim keys)
        "$mod, left,  movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up,    movefocus, u"
        "$mod, down,  movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mod, S, togglespecialworkspace, magic"
        "$mod SHIFT, S, movetoworkspace, special:magic"

        # Move focus with mainMod + arrow keys
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        # Move active window around current workspace with mainMod + SHIFT + CTRL [←→↑↓]
        "$mod ALT, H, movewindow, l"
        "$mod ALT, L, movewindow, r"
        "$mod ALT, K, movewindow, u"
        "$mod ALT, J, movewindow, d"

        # Scroll through existing workspaces with mainMod + , and mainMod + .
        "$mod, PERIOD, workspace, e+1"
        "$mod, COMMA,  workspace, e-1"

        # 
        "$mod, TAB,    workspace, +1"
      ];

      binde = [
        # Resize windows
        "$mod SHIFT, L, resizeactive,  10 0"
        "$mod SHIFT, H, resizeactive, -10 0"
        "$mod SHIFT, K, resizeactive, 0 -10"
        "$mod SHIFT, J, resizeactive, 0  10"
      ];

      bindel = [
        # Media
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && dunstify -h int:value:$(echo \"$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')*100\" | bc | awk '{printf \"%.0f\\n\", $1}') Audio"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && dunstify -h int:value:$(echo \"$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')*100\" | bc | awk '{printf \"%.0f\\n\", $1}') Audio"

        # Brightness control
        ", XF86MonBrightnessUp  , exec, brightnessctl set +1% && dunstify -h int:value:$(echo \"$(brightnessctl get) * 100 / $(brightnessctl max)\" | bc) Brightness"
        ", XF86MonBrightnessDown, exec, brightnessctl set 1%- && dunstify -h int:value:$(echo \"$(brightnessctl get) * 100 / $(brightnessctl max)\" | bc) Brightness"

        ", PRINT, exec, hyprshot -m output -o /tmp -f screenshot.png && satty --filename=/tmp/screenshot.png"
      ];

      bindl = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        # Requires playerctl
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        ", XF86AudioNext, exec, playerctl next"

        # Requires mpc
        ", XF86AudioPlay, exec, mpc toggle"
        ", XF86AudioPrev, exec, mpc prev && dunstify \"Mpd song\" \"$(mpc current | sed 's/\.opus$//' | sed 's/\[[^]]*\]//g')\""
        ", XF86AudioNext, exec, mpc next && dunstify \"Mpd song\" \"$(mpc current | sed 's/\.opus$//' | sed 's/\[[^]]*\]//g')\""
      ];

      # Window rules
      windowrule = [
        # Pavucontrol
        "float,        ^(pavucontrol)$"
        "pin,          ^(pavucontrol)$"
        "size 70% 50%, ^(pavucontrol)$"

        # Blueman
        "float,        ^(.blueman-manager-wrapped)$"
        "size 70% 50%, ^(.blueman-manager-wrapped)$"
        "pin,          ^(.blueman-manager-wrapped)$"

        # Networkmanager Editor
        "float,        ^(nm-connection-editor)$"
        "size 70% 50%, ^(nm-connection-editor)$"
        "pin,          ^(nm-connection-editor)$"
        "center 1,     ^(nm-connection-editor)$"

        # Satty ( Screenshot utility )
        "float,        ^(com.gabm.satty)$"
        "size 70% 50%, ^(com.gabm.satty)$"
        "pin,          ^(com.gabm.satty)$"
        "center 1,     ^(com.gabm.satty)$"
      ];

      # windowrulev2 = [
      #   "float, class:(anki), title:(Browse (0 of 0 cards selected))"
      # ];
    };
  };
}

