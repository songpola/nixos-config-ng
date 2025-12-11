{
  delib,
  host,
  inputs,
  pkgs,
  ...
}:
delib.module {
  # This module enables WSL support if the host is WSL
  name = "core.wsl";

  options = delib.singleEnableOption host.wslFeatured;

  nixos.always.imports = [ inputs.nixos-wsl.nixosModules.default ];

  nixos.ifEnabled = {
    wsl.enable = true;

    # Enable xdg-open for opening files and URLs in WSL
    environment.systemPackages = [ pkgs.xdg-utils ];
  };
}
