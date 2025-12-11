{ delib, ... }:
delib.module {
  name = "default";

  myconfig.always =
    { myconfig, ... }:
    {
      args.shared.username = myconfig.host.homeManagerUser;
    };
}
