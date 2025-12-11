{ delib, username, ... }:
delib.module {
  name = "profiles.songpola";

  options = delib.singleEnableOption (username == "songpola");

  myconfig.ifEnabled =
    { cfg, ... }:
    {
      binaryCache.client = {
        targets = [
          {
            url = "ssh-ng://${username}@prts.tail7623c.ts.net";
            signingPublicKey = "prts-1:js8+ltSqLuUR06p1IMycRJtBTINqBlIK7vv5c3ZNnuw=";
          }
        ];
      };
    };
}
