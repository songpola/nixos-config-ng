# See also: [Comparison](./COMPARE.md)

## **Use Home Manager only** (in most cases)

### Why?

1. **They conflict with each other** - Both try to hook into your shell
   initialization, which can cause:
   - Direnv being initialized twice
   - Configuration conflicts (system vs user settings)
   - Unexpected behavior when settings differ

2. **Home Manager is more flexible**:
   - Per-user configuration (useful for multi-user systems)
   - More shell support (Nushell)
   - Better maintained with more features (mise integration)
   - Version-aware silent mode
   - Easier to manage dotfiles in git

3. **You likely don't need system-wide direnv**:
   - Direnv is typically a developer tool used per-user
   - Each user may want different settings
   - No need for system-level enforcement

## When to use NixOS module instead:

Use the **NixOS system module** only if:

1. **You want the same direnv config for ALL users** on the system
2. **You need the nix-shell integration behavior** - the NixOS module has
   special logic to conditionally load direnv when inside nix shells
3. **You're configuring a shared development machine** where standardization is
   important

## My Recommendation:

```nix
# In your Home Manager configuration
programs.direnv = {
  enable = true;
  nix-direnv.enable = true;

  # Optional but recommended
  enableBashIntegration = true;
  enableZshIntegration = true;  # or whichever shell you use

  # Optional: silence direnv output
  # silent = true;
};
```

**And keep the NixOS module disabled** (it's disabled by default).

### Exception: If you really want both

If you have a specific reason to use the NixOS module (like the nix-shell
conditional loading), you could potentially use both by:

1. Enabling NixOS module for basic setup
2. Using Home Manager only for user-specific overrides in `stdlib`/`config`

But honestly, **this is overly complex**. Just use Home Manager and you'll be
fine!
