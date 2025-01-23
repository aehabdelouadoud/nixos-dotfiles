{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        # Everything but the ID section:
        settings = {
          # The main layer
          main = {
            "enter" = "capslock";
            "capslock" = "enter";
            "102nd" = "rightmeta";
            "left" = "rightcontrol";
          };
        };
      };
    };
  };
}
