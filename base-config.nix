final: prev:
let
  env = [ "init" ];
  core = [ "wsl" ];
in
{
  args.enable = true;
  rices.enable = false;
  hosts = {
    type.types = prev.hosts.type.types ++ env;
    features.features = prev.hosts.features.features ++ core;
  };
}
