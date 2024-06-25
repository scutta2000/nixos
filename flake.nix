{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ags.url = "github:Aylur/ags";
    stylix.url = "github:danth/stylix";
    anyrun.url = "github:anyrun-org/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";

    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # Hyprspace.url = "github:KZDKM/Hyprspace";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        scutta = lib.nixosSystem {
          inherit system;

          # environment.systemPackages = with nixpkgs; [
          #   anyrun.packages.${system}.anyrun
          # ];
          # environment.systemPackages = [ inputs.anyrun.packages.${system}.anyrun ];


          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.scutta = import ./home.nix;
              home-manager.extraSpecialArgs = { inherit inputs; };
            }
            inputs.stylix.nixosModules.stylix
          ];
        };
      };
    };
}

