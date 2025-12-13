{
  delib,
  username,
  host,
  ...
}:
delib.module {
  name = "profiles.songpola";

  options = delib.singleEnableOption (username == "songpola");

  myconfig.ifEnabled = {
    binaryCache.client.targets = [
      {
        # Use SSH-based binary cache access when on WSL.
        # Authentication is handled via Tailscale SSH.
        url =
          if host.isWsl then
            "ssh-ng://songpola@prts.tail7623c.ts.net"
          else
            "http://prts.tail7623c.ts.net:5000";
        signingPublicKey = "prts-1:js8+ltSqLuUR06p1IMycRJtBTINqBlIK7vv5c3ZNnuw=";
      }
    ];
  };
}
