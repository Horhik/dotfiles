{config, pkgs, ...}:
{
  services.picom = {
    #    package = pkgs.nur.repos.reedrw.picom-next-ibhagwan;
    enable = true;
    #detect-rounded-corners = true;
    backend = "glx";
    shadow = true;
    vSync = true;
    activeOpacity = 1.0;
    inactiveOpacity = 0.75 ;
    experimentalBackends = true;
    settings = {
      blur = { 
        method = "kawase";
        size = 50;
        deviation = 7.0;
      };
    };
  };
  

}
