{
  delib,
  ...
}:
delib.host {
  name = "erudite";
  type = "std";
  features = [ "wsl" ];
  system = "x86_64-linux";

  nixos.system.stateVersion = "25.11";
  home.home.stateVersion = "25.11";
}
