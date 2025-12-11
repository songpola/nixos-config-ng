{ delib, username, ... }:
delib.module {
  name = "profiles.nixos";

  options = delib.singleEnableOption (username == "nixos");

  myconfig.ifEnabled = {
    binaryCache.client = {
      targets = [
        {
          url = "http://prts.tail7623c.ts.net:5000";
          signingPublicKey = "prts-1:js8+ltSqLuUR06p1IMycRJtBTINqBlIK7vv5c3ZNnuw=";
        }
      ];
    };
  };
}
