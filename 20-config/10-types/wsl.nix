{
  delib,
  host,
  inputs,
  # pkgs,
  ...
}:
delib.module {
  name = "types.wsl";

  options = delib.singleEnableOption host.isWsl;

  nixos.always.imports = [ inputs.nixos-wsl.nixosModules.default ];

  nixos.ifEnabled = {
    wsl.enable = true;

    # Enable xdg-open for opening files and URLs in WSL
    # environment.systemPackages = [ pkgs.xdg-utils ];
  };
}
