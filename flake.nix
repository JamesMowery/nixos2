{
  description = "Phoenix Flake Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien.url = "github:thiagokokada/nix-alien";
  };

  outputs = inputs@{
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    nix-alien,
    ...
  }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "electron-25.9.0"
        ];
      };
    };
    pkgs-unstable = import nixpkgs-unstable {
      inherit system;
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "electron-25.9.0"
        ];
      };
    };
  in {
    #homeConfigurations = {
    #  james = home-manager.lib.homeManagerConfiguration rec {
    #    inherit pkgs;
    #    #modules = [
    #    #  #./home.nix
    #    #];
    #    extraSpecialArgs = {
    #      inherit pkgs-unstable;
    #    };
    #  };
    #};
    nixosConfigurations = {
      phoenix = nixpkgs.lib.nixosSystem rec {
        inherit pkgs;
        specialArgs = {
          inherit pkgs-unstable;
	        inherit self;
        };
        modules = [
          ./configuration.nix

          # nix-alien with flakes + overlay
	  #({ self, ... }: {
          #  nixpkgs.overlays = [
          #    self.inputs.nix-alien.overlays.default
          #  ];
          #  environment.systemPackages = with pkgs; [
          #    nix-alien
          #  ];
          #  # Optional, needed for `nix-alien-ld`
          #  #programs.nix-ld.enable = true;
          #})

          # nix-alien with flakes
	  #({ self, system, ... }: {
          #  environment.systemPackages = with self.inputs.nix-alien.packages.${system}; [
          #    nix-alien
          #  ];
          #  # Optional, needed for `nix-alien-ld`
          #  programs.nix-ld.enable = true;
	  #})

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.james = import ./home.nix;
            home-manager.extraSpecialArgs = {
	      inherit self;
	      inherit system;
              inherit pkgs-unstable;
            };
          }
	  # nix-alien with flakes + home-manager
	  #({ self, system, ... }: {
          #  home.packages = with self.inputs.nix-alien.packages.${system}; [
          #    nix-alien
          #  ];
          #})
        ];
      };
    };
  };
}
