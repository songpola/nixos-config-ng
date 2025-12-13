{
  # Useful for wsl-init host
  nixConfig = {
    extra-substituters = [
      "http://prts.tail7623c.ts.net:5000"
    ];
    extra-trusted-public-keys = [
      "prts-1:js8+ltSqLuUR06p1IMycRJtBTINqBlIK7vv5c3ZNnuw="
    ];
  };

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
      flakelight,
      denix,
      ...
    }@inputs:
    flakelight ./. {
      inherit inputs;

      nixosConfigurations = denix.lib.configurations {
        moduleSystem = "nixos";
        homeManagerUser = "songpola";
        paths = [
          ./10-hosts
          ./20-config
          ./30-modules
        ];
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
