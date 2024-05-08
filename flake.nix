{
  description = "Your new nix config";

  nixConfig = {
    extra-substituters = [
    ];
    extra-trusted-public-keys = [
    ];
  };

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , nix-colors
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
    in
    {
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          # > Our main nixos configuration file <
          modules = [
            ./nixos/desktop
            ./nixos/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.pablo = import ./home/home.nix;
              home-manager.extraSpecialArgs = { inherit nix-colors ; };
              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };
        laptop = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          # > Our main nixos configuration file <
          modules = [
            ./nixos/laptop
            ./nixos/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.pablo = import ./home/home.nix;
              home-manager.extraSpecialArgs = { inherit nix-colors ; };
              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };
      };
    };
}
