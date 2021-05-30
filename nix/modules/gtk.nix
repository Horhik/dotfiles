{config, pkgs, ...}:
{
  services.xserver.desktopManager.cde.extraPackages = with pkgs;
    options.services.xserver.desktopManager.cde.extraPackages.default ++ [
      cde-gtk-theme
    ];
  environment.etc."xdg/gtk-2.0/gtkrc".text = ''
    gtk-theme-name="Yaru"
  '';
  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=yaru-theme
  '';
  qt5 = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };
}
