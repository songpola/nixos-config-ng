{
  delib,
  options,
  pkgs,
  ...
}:
# This host is designed to be used as the initial environment
# for a fresh NixOS-WSL installation.
delib.host {
  name = "wsl-init";
  type = "wsl";
  system = "x86_64-linux";

  homeManagerUser = options.wsl.defaultUser.default;

  nixos.system.stateVersion = options.system.stateVersion.default;
  home.home.stateVersion = options.system.stateVersion.default;

  myconfig.env.init.enable = true;

  nixos = {
    # Essential packages
    environment.systemPackages = with pkgs; [
      nh
      micro
      git
      jujutsu
    ];
  };
}
