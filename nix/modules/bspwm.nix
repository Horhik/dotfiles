{ pkgs, ... }:
{
  services.xserver.windowManager.bspwm.enable = true;
  home.packages =  [pkgs.sxhdkd];
}
