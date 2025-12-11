# This host is designed to be used as the initial environment
# for a fresh NixOS-WSL installation.
{
  delib,
  lib,
  config,
  ...
}:
let
  # NOTE: lib.version will return something like "25.11.20251130.8bb5646"
  nixpkgsVersion = lib.versions.majorMinor lib.version; # => "25.11"
in
delib.host {
  name = "nixos";
  type = "init";
  features = [ "wsl" ];
  system = "x86_64-linux";

  # Override: Use the default user of NixOS-WSL
  homeManagerUser = config.wsl.defaultUser; # default: "nixos"

  # Intentionally keep both stateVersion in sync with Nixpkgs version
  nixos.system.stateVersion = nixpkgsVersion;
  home.home.stateVersion = nixpkgsVersion;

  myconfig = {
    programs = {
      direnv.enable = true;
      vscodeRemote.enable = true;
    };

    nix.binaryCache.enable = true;

    devenv = {
      nix.enable = true;
    };
  };
}
