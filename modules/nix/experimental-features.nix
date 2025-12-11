{ delib, ... }:
delib.module {
  name = "nix.experimental-features";

  options = delib.singleEnableOption false;

  nixos.ifEnabled = {
    nix.settings.experimental-features = [
      "flakes"
      "nix-command"
      "pipe-operators"
    ];
  };
}
