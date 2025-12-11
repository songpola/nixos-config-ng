## Key Differences

### 1. **Scope & Purpose**

- **NixOS (nixpkgs)**: System-wide direnv configuration for all users
- **Home Manager**: Per-user direnv configuration

### 2. **Configuration File Locations**

**NixOS:**

- Config: `/etc/direnv/direnv.toml`
- RC file: `/etc/direnv/direnvrc`
- Custom libs: `/etc/direnv/lib/zz-user. sh`
- Environment variable: `DIRENV_CONFIG=/etc/direnv`

**Home Manager:**

- Config: `$XDG_CONFIG_HOME/direnv/direnv.toml`
- RC file: `$XDG_CONFIG_HOME/direnv/direnvrc`
- Uses standard XDG directory structure

### 3. **Shell Integration Behavior**

**NixOS** has special handling for nix shells:

- Conditionally loads direnv in `nix-shell`, `nix shell`, or `nix develop` based
  on `loadInNixShell` option
- Bash: Checks `$IN_NIX_SHELL`, `$NIX_GCROOT`, and PATH for `/nix/store`
- Zsh: Checks PATH for `/nix/store`
- Fish: Checks PATH for `/nix/store`
- Xonsh: Similar conditional logic

**Home Manager:**

- Unconditionally loads direnv in all shells
- No special nix-shell detection
- Uses `mkAfter` to ensure direnv loads after other prompt manipulations

### 4. **Package Handling**

**NixOS:**

```nix
finalPackage = pkgs.symlinkJoin {
  inherit (cfg. package) name;
  paths = [ cfg.package ];
  # Removes fish library to prevent auto-sourcing
  postBuild = ''
    rm -rf "$out/share/fish"
  '';
  meta.mainProgram = "direnv";
};
```

- Creates a wrapped package with fish integration removed
- Uses `finalPackage` for actual execution

**Home Manager:**

- Uses `cfg.package` directly
- No wrapper or modification

### 5. **Integration Options**

**NixOS:**

- `enableBashIntegration` (default: true)
- `enableZshIntegration` (default: true)
- `enableFishIntegration` (default: true)
- `enableXonshIntegration` (default: true)
- `loadInNixShell` - Controls loading in nix shells (default: true)

**Home Manager:**

- `enableBashIntegration` (default: varies)
- `enableZshIntegration` (default: varies)
- `enableFishIntegration` (default: true, **read-only**)
- `enableNushellIntegration` (default: varies)
- Xonsh mentioned in conversation but not in current code

### 6. **Silent Mode Implementation**

**NixOS:**

```nix
silent = lib.mkEnableOption ''
  the hiding of direnv logging
'';

# Applied via settings
settings = lib.mkIf cfg.silent {
  global = {
    log_format = lib.mkDefault "-";
    log_filter = lib.mkDefault "^$";
  };
};
```

**Home Manager:**

```nix
# For direnv >= 2.36.0
direnv. config.global = mkIf (cfg.silent && isVersion236orHigher) {
  log_format = "-";
  log_filter = "^$";
};

# For older versions
home.sessionVariables = lib.mkIf (cfg.silent && ! isVersion236orHigher) {
  DIRENV_LOG_FORMAT = "";
};
```

- Version-aware implementation
- Falls back to environment variable for older direnv versions

### 7. **Custom Configuration Options**

**NixOS:**

- `direnvrcExtra` - Extra lines for direnvrc
- `settings` - TOML configuration (direnv. toml)

**Home Manager:**

- `stdlib` - Custom stdlib for direnvrc
- `config` - TOML configuration (direnv.toml)

### 8. **Additional Features**

**NixOS:**

- Automatically loads user's `~/.direnvrc` or `~/.config/direnv/direnvrc`
- Loads user's custom libs from `~/.config/direnv/lib/*. sh`
- Adds package to `environment.systemPackages`

**Home Manager:**

- Nushell integration (comprehensive PATH conversion logic)
- **mise integration** - Additional tool for development environments
- More modular file structure (separate files for integrations)

### 9. **nix-direnv Integration**

**Both** support nix-direnv, but with different approaches:

**NixOS:**

```nix
nix-direnv. package = lib.mkOption {
  default = pkgs.nix-direnv. override { nix = config.nix.package; };
  ...
};
```

- Automatically overrides to use system nix package

**Home Manager:**

```nix
nix-direnv.package = mkPackageOption pkgs "nix-direnv" { };
```

- Uses default nix-direnv package without override

### 10. **Fish Integration Peculiarity**

**NixOS:** Actively removes fish integration files to prevent automatic sourcing
**Home Manager:** Marks `enableFishIntegration` as read-only and always true
because direnv's fish package automatically loads

## Summary Table

| Feature              | NixOS                 | Home Manager            |
| -------------------- | --------------------- | ----------------------- |
| Scope                | System-wide           | Per-user                |
| Config location      | `/etc/direnv`         | `~/.config/direnv`      |
| Nix-shell awareness  | ✅ Yes                | ❌ No                   |
| Nushell support      | ❌ No                 | ✅ Yes                  |
| Xonsh support        | ✅ Yes                | ⚠️ Mentioned in history |
| mise integration     | ❌ No                 | ✅ Yes                  |
| Package wrapping     | ✅ Yes (removes fish) | ❌ No                   |
| Version-aware silent | ❌ No                 | ✅ Yes                  |
| User config loading  | ✅ Explicit           | ⚠️ Implicit via XDG     |

Both implementations serve different use cases effectively, with NixOS focusing
on system-wide consistency and nix-shell integration, while Home Manager
provides per-user flexibility with more shell variety (especially Nushell) and
additional tooling integrations.
