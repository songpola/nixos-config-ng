{
  delib,
  host,
  ...
}:
delib.module {
  name = "env.init";

  options = delib.singleEnableOption host.isInit;

  myconfig.ifEnabled = {
    nix.experimental-features.enable = true;

    binaryCache.client.enable = true;

    programs = {
      vscode-remote.enable = true;
      direnv.enable = true;
    };

    devenv.nix.enable = true;
  };
}
