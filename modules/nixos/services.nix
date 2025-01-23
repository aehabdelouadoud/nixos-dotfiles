{
  services = {
    dbus.enable = true;
    udisks2.enable = true;
  };
  ## Sound.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  ## Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  ## Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.blueman.enable = true;
  ## Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # MPD
  services = {
    mpd = {
      enable = true;
      musicDirectory = "/home/x/music";
      user = "x";
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "Pipewire Output"
        }
      '';
    };
  };

  # Important
  systemd = {
    services = {
      mpd.environment = {
        XDG_RUNTIME_DIR = "/run/user/1000";
      };
    };
  };
}
