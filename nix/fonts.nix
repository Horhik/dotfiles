{config, pkgs, ...}:
{
  fonts = {
    fonts = with pkgs; [
      # icon fonts
      material-design-icons

      # normal fonts
      noto-fonts
      mononoki
      noto-fonts-cjk
      noto-fonts-emoji
      twitter-color-emoji
      liberation_ttf_v1
      hack-font
      ubuntu_font_family

      # bitmap fonts
      gohufont
      tewi-font

      # nerdfonts
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Mononoki" ]; })
    ];

    # use fonts specified by user rather than default ones
    enableDefaultFonts = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif"  "Twitter Color Emoji" ];
      sansSerif = [ "Noto Sans"   "Twitter Color Emoji"];
      monospace = [ "Mononoki Nerd Font"   "Twitter Color Emoji"];
      emoji = [ "Twitter Color Emoji" ];
    };
  };
}
