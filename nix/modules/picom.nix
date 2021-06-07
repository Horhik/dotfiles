# This file is generated from "README.org"
{ pkgs, ... }:
{
  services.picom.enable = true;
  services.picom.package = pkgs.nur.repos.reedrw.picom-next-ibhagwan;
  services.picom.shadow = true;
  services.picom.vSync = true;
#  services.picom.inactiveOpacity = "0.8";
#  services.picom.inactiveDim = "0.7";
  services.picom.backend = "glx";
  services.picom.experimentalBackends = true;
  services.picom.opacityRule = [
      "80:class_g  = 'Zathura'"
      "80:class_g  = 'Discord'"
      "80:class_g  = 'Emacs'"
      "60:class_g  = 'Anki'"
      "100:class_g = 'keynav'"
      "85:class_g = 'Alacritty'"
  ];
  services.picom.shadowExclude = [
	"class_g = 'Navigator'"
  ];
  services.picom.extraOptions = ''
    #inactive-dim = 0.5;
    #active-opacity = 1.0;
    detect-client-opacity = true;
    detect-rounded-corners = true;
    blur:
    {
        method = "kawase";
        strength = 8;
        background = false;
        background-frame = false;
        background-fixed = false;
    };
    blur-background-exclude = [
        "class_g = 'keynav'",
        "class_g = 'Dunst'",
        "class_g = 'Navigator'",
        "class_g = 'Firefox'"
    ];
    corner-radius = 4;
    rounded-corners-exclude = [
        "window_type = 'dock'",
        "_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'",
        "class_g = 'keynav'",
    ];
    round-borders = 4;
    round-borders-exclude = [
        "class_g = 'keynav'"
    ];
  '';
}

/*
{config, pkgs, ...}:
{
  services.picom = {
    package = pkgs.nur.repos.reedrw.picom-next-ibhagwan;
    enable = true;
    #detect-rounded-corners = true;
    backend = "glx";
    activeOpacity = 1.0;
    inactiveOpacity = 0.75 ;
    experimentalBackends = true;
    settings = {
      blur = { 
        method = "gaussian";
        size = 50;
        deviation = 7.0;
      };
    };
  };
  

}
*/
