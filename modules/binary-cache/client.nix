{ delib, ... }:
delib.module {
  name = "binaryCache.client";

  options =
    with delib;
    moduleOptions {
      enable = boolOption false;

      targets = listOfOption (submodule {
        options = {
          url = noDefault (strOption null);
          signingPublicKey = noDefault (strOption null);
        };
      }) [ ];
    };

  nixos.ifEnabled =
    { cfg, ... }:
    {
      nix.settings = {
        substituters = map (it: it.url) cfg.targets;
        trusted-public-keys = map (it: it.signingPublicKey) cfg.targets;
      };
    };
}
