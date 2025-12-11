{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/release-25.11";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    flakelight.url = "github:nix-community/flakelight";
    flakelight.inputs.nixpkgs.follows = "nixpkgs";

    denix = {
      url = "github:yunfachi/denix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flakelight,
      nixos-wsl,
      denix,
      ...
    }@inputs:
    flakelight ./. {
      inherit inputs;

      nixosConfigurations = denix.lib.configurations {
        moduleSystem = "nixos";
        homeManagerUser = "songpola";
        paths = [ ./modules ];
        extensions = with denix.lib.extensions; [
          args
          (base.withConfig (import ./base-config.nix))
        ];
        specialArgs = {
          inherit inputs;
        };
      };

      devShell.packages =
        pkgs: with pkgs; [
          nil
          just
          nushell
        ];

      flakelight.builtinFormatters = false;
    };
}
