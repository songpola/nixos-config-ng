{
  delib,
  host,
  pkgs,
  ...
}:
delib.module {
  name = "env.init";

  options = delib.singleEnableOption host.isInit;

  nixos.ifEnabled = {
    nix.settings.experimental-features = [
      "flakes"
      "nix-command"
      "pipe-operators"
    ];

    environment.systemPackages = with pkgs; [
      nh
      micro
      git
    ];
  };
}
