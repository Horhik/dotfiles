{config, pkgs, ...}:
{
  networking.extraHosts =
    ''
      127.0.0.1 www.youtube.com
      127.0.0.1 m.youtube.com
      127.0.0.1 youtube.com
    '';

}
