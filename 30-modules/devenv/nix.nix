{ delib, pkgs, ... }:
delib.module {
  name = "devenv.nix";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    environment.systemPackages = with pkgs; [
      nil
      nixfmt-rfc-style
    ];
  };
}
