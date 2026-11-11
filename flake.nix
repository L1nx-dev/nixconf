{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    obsidian-extensions = {
      url = "github:karaolidis/nix-obsidian-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, obsidian-extensions, grub2-themes }:
    let
      system = "x86_64-linux";

      overlays = [ obsidian-extensions.overlays.default ];
      specialArgs = { inherit zen-browser system; };

      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };

      mkHost = hostFile: nixpkgs.lib.nixosSystem {
        inherit system specialArgs;

        modules = [
          hostFile
          grub2-themes.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.user = import ./home/home.nix;
              extraSpecialArgs = specialArgs;
            };
            nixpkgs = { inherit overlays; config.allowUnfree = true; };
          }
        ];
      };
    in
    {
      nixosConfigurations = {
        desktop = mkHost ./configuration/hosts/desktop.nix;
        laptop  = mkHost ./configuration/hosts/laptop.nix;
      };

      homeConfigurations.user = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = specialArgs;
        modules = [ ./home/home.nix ];
      };
    };
}
