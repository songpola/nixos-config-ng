{
  delib,
  options,
  config,
  ...
}:
# This host is designed to be used as the initial environment
# for a fresh NixOS-WSL installation.
delib.host {
  name = "wsl-init";
  type = "init";
  features = [ "wsl" ];
  system = "x86_64-linux";

  homeManagerUser = config.wsl.defaultUser;

  nixos.system.stateVersion = options.system.stateVersion.default;
  home.home.stateVersion = options.system.stateVersion.default;
}
