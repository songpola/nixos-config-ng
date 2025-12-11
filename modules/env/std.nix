{ delib, ... }:
delib.module {
  name = "env.std";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled.env.init.enable = true;

  # nixos.ifEnabled = {
  # };
}
