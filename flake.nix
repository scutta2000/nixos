{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {self , nixpkgs, home-manager, ...}:
    let 
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        scutta = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.scutta = import ./home.nix;
            }
          ];
        };
      };
    };


  # outputs = inputs@{ nixpkgs, home-manager, ... }: {
  #   nixosConfigurations = {
  #     hostname = nixpkgs.lib.nixosSystem {
  #       system = "x86_64-linux";
  #       modules = [
  #         ./configuration.nix
  #         home-manager.nixosModules.home-manager
  #         {
  #           home-manager.useGlobalPkgs = true;
  #           home-manager.useUserPackages = true;
  #           home-manager.users.scutta = import ./home.nix;

  #           # Optionally, use home-manager.extraSpecialArgs to pass
  #           # arguments to home.nix
  #         }
  #       ];
  #     };
  #   };
  # };
}
