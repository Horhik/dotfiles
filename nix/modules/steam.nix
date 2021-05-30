{config, pkgs, ...}:
{
  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      nativeOnly = true;
    };
  };
  programs.steam.enable = true;
}
