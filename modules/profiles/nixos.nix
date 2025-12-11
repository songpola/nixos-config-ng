{ delib, username, ... }:
delib.module {
  name = "profiles.nixos";

  options = delib.singleEnableOption (username == "nixos");

  myconfig.ifEnabled =
    { cfg, ... }:
    {
      # TODO: Enable non-SSH binary cache on PRTS first
      # nix.binaryCache = {
      #   enable = true;
      #   targets = [
      #     {
      #       url = "ssh-ng://${username}@prts.tail7623c.ts.net";
      #       signingPublicKey = "prts-1:js8+ltSqLuUR06p1IMycRJtBTINqBlIK7vv5c3ZNnuw=";
      #     }
      #   ];
      # };
    };
}
