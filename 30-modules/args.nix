{ delib, ... }:
delib.module {
  name = "args";

  myconfig.always =
    { myconfig, ... }:
    {
      args.shared.username = myconfig.host.homeManagerUser;
    };
}
