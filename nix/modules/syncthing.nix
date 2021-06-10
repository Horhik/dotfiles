{config, pkgs, ...}:
{
  services.syncthing = {
    enable = true;
    user = "horhik";
    dataDir = "/home/horhik/Notes";
    configDir = "/home/horhik/.config/syncthing";
  };

}
