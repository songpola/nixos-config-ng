{
  delib,
  host,
  ...
}:
delib.module {
  name = "env.std";

  options = delib.singleEnableOption false;

  myconfig.ifEnabled.env.init.enable = true;

  nixos.ifEnabled = {
    networking.hostName = host.name;

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
    };

    # Localization
    time.timeZone = "Asia/Bangkok";
    environment.variables.TZ = "Asia/Bangkok";

    # NOTE: nftables doesn't work well on WSL
    networking.nftables.enable = !host.wslFeatured;
  };
}
