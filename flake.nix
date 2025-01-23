{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11"; # Stable branch
    nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable"; # Unstable branch
    home-manager = {
      url = "github:nix-community/home-manager?ref=release-24.11";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit pkgs;
            inherit pkgs-unstable;
          };
          modules = [
            inputs.home-manager.nixosModules.default
            ./hosts/default/configuration.nix
          ];
        };
      };
    };
}

