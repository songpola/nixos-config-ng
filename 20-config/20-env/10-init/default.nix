{
  delib,
  ...
}:
delib.module {
  name = "env.init";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled = {
    binaryCache.client.enable = true;

    programs = {
      vscode-remote.enable = true;
      direnv.enable = true;
    };

    devenv.nix.enable = true;
  };

  nixos.ifEnabled = {
    nix.settings.experimental-features = [
      "flakes"
      "nix-command"
      "pipe-operators"
    ];
  };
}
