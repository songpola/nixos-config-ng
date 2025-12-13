final: prev: {
  args.enable = true;
  rices.enable = false;
  hosts = {
    type.types = prev.hosts.type.types ++ [
      "wsl"
      "baremetal"
    ];
    # features.features = prev.hosts.features.features ++ [ "" ];
  };
}
