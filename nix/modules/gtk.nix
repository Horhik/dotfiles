{config, pkgs, ...}:
{
  programs.dconf.enable = true;
  services.gnome.evolution-data-server.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.xserver.desktopManager.cde.extraPackages = with pkgs;
    options.services.xserver.desktopManager.cde.extraPackages.default ++ [
      cde-gtk-theme
      yaru-theme
    ];
  environment.etc."xdg/gtk-2.0/gtkrc".text = ''
    gtk-theme-name="Yaru-dark"
  '';
  environment.etc."xdg/gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Yaru-dark
  '';
  qt5 = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };
}
