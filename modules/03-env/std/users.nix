{
  delib,
  host,
  username,
  lib,
  ...
}:
delib.module {
  name = "env.std";

  nixos.ifEnabled = lib.mkMerge [
    # WSL: Set default user (will be created if not exists)
    (lib.mkIf (host.wslFeatured) {
      wsl.defaultUser = username;
    })
    # Use private group by default and add to `wheel` and `users` extra groups
    {
      users.groups.${username}.gid = 1000;
      users.users.${username} = {
        isNormalUser = true;
        uid = 1000;
        group = username;
        extraGroups = [
          "wheel"
          "users"
        ];
      };
    }
  ];
}
