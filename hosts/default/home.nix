{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "x";
  home.homeDirectory = "/home/x";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs = {
    tmux = {
      keyMode = "vi";
      enable = true;
    };
    btop.enable = true;
    waybar = {
      enable = true;
      # settings = {};
      # style = {};
    };
    wlogout.enable = true;
    git = {
      enable = true;
      # userName = "Name";
      # userEmail = "email@domain";
    };
    ncmpcpp = {
      enable = true;
      bindings = [
        {
          key = "l";
          command = "next_column";
        }
        {
          key = "h";
          command = "previous_column";
        }
        {
          key = "k";
          command = "scroll_up";
        }
        {
          key = "j";
          command = "scroll_down";
        }
        {
          key = "J";
          command = [
            "select_item"
            "scroll_down"
          ];
        }
        {
          key = "K";
          command = [
            "select_item"
            "scroll_up"
          ];
        }
      ];
    };
    # cava = {
    #   enable = true;
    #   settings = {
    #     general = {
    #       mode = "waves";
    #     };
    #     color = {
    #       background = "'#161616'";
    #       foreground = "'#dde1e6'";
    #
    #       gradient = 1;
    #       gradient_count = 8;
    #       gradient_color_1 = "'#161616'";
    #       gradient_color_2 = "'#303030'";
    #       gradient_color_3 = "'#606060";
    #       gradient_color_4 = "'#82cfff'";
    #       gradient_color_5 = "'#78a9ff'";
    #       gradient_color_6 = "'#dde1e6'";
    #       gradient_color_7 = "'#dde1e6'";
    #       gradient_color_8 = "'#ffffff'";
    #     };
    #   };
    # };
  };

  services = {
    # ssh-agent.enable = true;
    batsignal.enable = true;
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
  };

  gtk = {
    enable = true;
    # theme = {
    #   name = "gruvbox-dark";
    #   package = pkgs.gruvbox-gtk-theme;
    # };
    # iconTheme = {
    #   name = "Gruvbox-Plus-Dark";
    #   package = pkgs.gruvbox-plus-icons;
    # };
    cursorTheme = {
      name = "macOS-BigSur-White";
      package = pkgs.capitaine-cursors-themed;
    };
  };

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "android-studio-stable"
      "wpsoffice"
    ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Flutter tools
    flutter
    android-studio

    keepassxc

    plantuml
    imv
    feh

    sfml
    libresprite
    pixelorama

    # Tasks management
    taskwarrior3
    timewarrior 
    vit
    taskwarrior-tui
    calcurse

    # Graphics
    inkscape
    gimp
    krita
    blender

    gtypist           # Universal typing tutor
    ddgr              # Search DuckDuckGo from the terminal

    slides            # Terminal based presentation tool
    presenterm        # A terminal based slideshow tool

    castero           # TUI podcast client for the terminal

    eget              # Easily install prebuilt binaries from GitHub
    wpsoffice         # 

    tere              # A faster alternative to cd + ls.

    uchess            # Play chess against UCI engines in your terminal
    gambit-chess      # Play chess in your terminal

    yewtube           # Terminal based YouTube player and downloader, forked from mps-youtube

    # masterpdfeditor   # A PDF Editor

    forgejo

    # Others
    ripgrep
    shellcheck
    viu # See pictures in terminal

    # Browsers
    qutebrowser
    librewolf

    # Entertainment
    mov-cli
    ani-cli

    zathura

    telegram-desktop
    anki
    swaylock
    speedtest-cli
    gowall
    whitesur-cursors
    # apple-cursor
    bat
    lldb
    bc
    batsignal
    legcord 
    plasma5Packages.kdeconnect-kde 
    noisetorch
    tldr
    wineWowPackages.waylandFull
    yt-dlp

    pandoc
    tetex

    audacity
    lmms
    ardour

    qemu
    pom

    obs-studio
    wofi

    # Rust environment
    rustup
    rust-gdb

    # Some security tools
    clamav # Antivirus engine designed for detecting Trojans, viruses, malware and other malicious threats

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # xdg.mimeApps = {
  #   enable = true;
  #   defaultApplications = {
  #     "text/html" = "librewolf.desktop";
  #     "x-scheme-handler/http" = "librewolf.desktop";
  #     "x-scheme-handler/https" = "librewolf.desktop";
  #     "x-scheme-handler/about" = "librewolf.desktop";
  #     "x-scheme-handler/unknown" = "librewolf.desktop";
  #   };
  # };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/x/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {};

  imports = [
    ../../modules/config/hyprland.nix
    # ../../modules/config/dunst.nix
  ];
}
