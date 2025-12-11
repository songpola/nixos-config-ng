## NixOS-WSL

```bash
sudo nixos-rebuild switch --flake github:songpola/nixos-config-ng#wsl-init --accept-flake-config --option tarball-ttl 0
```

OR

```bash
NIX_CONFIG="experimental-features = nix-command flakes pipe-operators" \
nix-shell -p nh \
--run 'nh os switch github:songpola/nixos-config-ng -H wsl-init -- --accept-flake-config --option tarball-ttl 0'
```
