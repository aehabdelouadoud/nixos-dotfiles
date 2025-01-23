# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/doas.nix
    ../../modules/nixos/keyd.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  # Networking.
  networking = {
    hostName = "NixOS"; # Define your hostname.
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Africa/Casablanca";

  # Automaticlly delete garbage collection of unused Nix store paths that are older than 15 days.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delte-older-than 15d";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.x = {
    isNormalUser = true;
    # initialPassword = "P@ssw@rd";
    description = "Main user";
    shell = pkgs.bash;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "input"
      "networkmanager"
    ];
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    users = {
      "x" = import ./home.nix;
    };
  };

  environment.systemPackages =
    (with pkgs; [
      # Wayland
      wayland-protocols
      wayland-utils
      wlroots
      xwayland
      meson
      wl-clipboard
      wlogout

      # Hyprland Environment
      hyprland
      # xdg-desktop-portal-gtk
      # xdg-desktop-portal-hyprland
      ## Notification
      dunst
      libnotify
      ## Application Launchers
      rofi-wayland
      wofi
      ## Bar
      waybar
      swww
      hyprcursor
      ## Screenshot
      hyprshot
      jq
      grim
      slurp

      # Terminal
      starship
      fishPlugins.autopair
      fishPlugins.done
      tmux
      tui-journal

      # Command line tools.
      fastfetch
      eza
      fzf
      fortune

      # Security
      firejail

      # Media and Document Viewers
      playerctl
      (mpv.override {
        scripts = with pkgs.mpvScripts; [
          uosc
          mpris
          sponsorblock
          mpv-cheatsheet
        ];
      })

      # Brightness Control
      brightnessctl

      # Compilers & language servers
      gcc
      clang
      check # Unit testing framework for C
      go
      fennel
      libclang
      fennel-ls
      nil
      marksman

      # XDG utils
      xdg-utils
      zip
      unzip
      glib
      git
      wget

      # Network
      networkmanagerapplet
      # networkmanager_dmenu

      # Audio
      pavucontrol
      pulsemixer
      ncmpc

      # For mpd
      mpc-cli
      ncmpcpp

      # Bluetooth
      bluez
      bluetuith

      # Secure files
      nodePackages_latest.svgo

      # Disks
      udiskie

      # Not sorted yet.
      keyd
      docker
      wl-screenrec
      wf-recorder 
      jellyfin-ffmpeg
      libinput
      nix-init
      yarn
      nixpkgs-fmt
    ])

    ++

    (with pkgs-unstable; [
      texliveFull
      latexrun
      tectonic

      satty

      kitty
      foot
      cool-retro-term

      # Terminal tools
      gnupg

      # Games
      qtcreator
      libsForQt5.full
      hyprpicker
      ## depends on
      cmake
      pkg-config
      pango
      cairo
      hyprutils
      libxkbcommon
      # Text Editors
      vim
      neovim
      neovide
      pyright
      nodePackages.browser-sync
      hurl
      lua-language-server
      fd
      tree-sitter
      mercurial
      cargo
      nodejs
      jdk
      libgit2
      gnumake
      julia
      (python3.withPackages (
        subpkgs: with subpkgs; [
          pip
        ]
      ))
      lua
      (luajit.withPackages (
        subpkgs: with subpkgs; [
          luarocks
        ]
      ))
      php
      phpPackages.composer

      p7zip
      superfile
      # hyprshot
      ocamlPackages.gstreamer
    ]);

  fonts.packages = with pkgs; [
    nerdfonts
    cozette
    dina-font
    gohufont
    monoid
  ];

  environment.sessionVariables = {
    # Hint Electon apps to use wayland
    NIXOS_OZONE_WL = "1";
    CHROME_EXECUTABLE = "google-chrome-stable";
    PATH = "$PATH:$(yarn global bin)";
    EDITOR = "neovide";
  };

  # Programs
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    hyprlock = {
      enable = true;
      # settings = {
      # };
    };

    firejail = {
      enable = true;
      wrappedBinaries = {
        # librewolf.
        librewolf = {
          executable = "${pkgs.librewolf}/bin/librewolf";
          profile = "${pkgs.firejail}/etc/firejail/librewolf.profile";
          extraArgs = [
            # Required for U2F USB stick
            "--ignore=private-dev"
            # Enforce dark mode
            "--env=GTK_THEME=Adwaita:dark"
            # Enable system notifications
            "--dbus-user.talk=org.freedesktop.Notifications"
          ];
        };
        # Google chrome.
        # google-chrome-stable = {
        #   executable = "${pkgs.google-chrome}/bin/google-chrome-stable";
        #   profile = "${pkgs.firejail}/etc/firejail/google-chrome.profile";
        #   desktop = "${pkgs.google-chrome}/share/applications/google-chrome.desktop";
        # };
      };
    };
    noisetorch.enable = true;
    fish.enable = true;
    starship.enable = true;
    kdeconnect.enable = true;
    ssh.startAgent = true;
  };

  # Enabling screensharing and the like.(Need further search)
  xdg = {
    mime = {
      defaultApplications = {
        "text/html"             = "librewolf.desktop";
        "application/pdf"       = "zathura.desktop";
        "text/markdown" = "neovide.desktop";
        "text/plain" = "neovide.desktop";
        "image/svg+xml" = "feh.desktop";           # SVG images
        
        "application/xml" = "firefox.desktop";         # XML files
        "text/xml" = "neovide.desktop";                # XML files (text)
        "application/json" = "neovide.desktop";        # JSON files
        "text/css" = "neovide.desktop";                # CSS files
      };
    };
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
    };
  };

  ## Bluetooth
  hardware = {
    bluetooth = {
      enable = true; # enables support for Bluetooth
      settings = {
        General = {
          Experimental = true;
        };
      };
      powerOnBoot = true; # powers up the default Bluetooth controller on boot
    };
  };

  # Services.
  services = {
    printing.enable = true; # Enable CUPS to print documents.
    dbus.enable = true;
    udisks2.enable = true; # Auto-mounting
    pipewire = { # Sound.
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    # libinput.enable = true; # Enable touchpad support (enabled default in most desktopManager).
    openssh.enable = true; # Enable the OpenSSH daemon.
    blueman.enable = true; # Bluetooth
    mpd = {
      enable = true;
      musicDirectory = "/home/x/ideas";
      user = "x";
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "Pipewire Output"
        }
      '';
    };
  };

  # Important `for mpd`
  systemd = {
    services = {
      mpd.environment = {
        XDG_RUNTIME_DIR = "/run/user/1000";
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
