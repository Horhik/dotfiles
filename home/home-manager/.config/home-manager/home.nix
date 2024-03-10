{ config, pkgs, ... }:




let
  unstable = import <unstable> {};
  jackWrap = drv: pkgs.symlinkJoin {
    name = "${drv.name}-jackwrapped";
    paths = [ drv ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      ls "$out/bin"
      for b in "$out/bin/"*; do
        wrapProgram "$b" \
          --prefix LD_LIBRARY_PATH : "${pkgs.pipewire.jack}/lib"
      done
    '';
  };
in{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  #services.emacs.package = pkgs.emacs-unstable;
  services.lorri.enable = true;
  services.mako.enable = true; # Notification daemon

  # nixpkgs.overlays = [
  #   (import (builtins.fetchTarball {
  #     url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
  #   }))
  # ];
  home.username = "horhik";
  home.homeDirectory = "/home/horhik";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    appimage-run
    dwarf-fortress-packages.dwarf-fortress-full
    dwarf-fortress-packages.themes.meph
    sxiv
    i3blocks
    zplug
    jq
    mononoki
    thefuck
    keepassxc
    gnome.gnome-calendar
   gnome-online-accounts
libsForQt5.kontact
  xdg-desktop-portal-gnome
    xournal
    electrum-ltc
    # Images/Video 
    ffmpeg-full
    vlc
    gimp
    darktable
    obs-studio
    # Intenet
    librewolf 
    thunderbird 
    nmap

    # Analyzing
    qdirstat

    # Notes
    logseq
    #pkgs.emacsPackages.emacsql-sqlite

    # Wayland
    wl-clipboard
    wtype

    # System

    zip unzip
    rsync wget curl
    lsd mpv 
    kitty  tmux
    htop
    usbutils 
    unixtools.fdisk
    shadowsocks-libev


    # Messaging
    
    telegram-desktop discord
    # Music
    puredata carla zrythm supercollider
    dragonfly-reverb
    cardinal
    vcv-rack
    bespokesynth-with-vst2


    # books
    zathura sioyek
    calibre

    # Audio
    pulsemixer
    strawberry
    snd
    nicotine-plus
    (jackWrap qpwgraph)
    wireplumber

    # languages
    anki

    # Phone
    android-tools


    # Screenshots
    grim slurp

    # Documents
    libreoffice

    # Notifications
    notify

    # Downloads
    transmission

    # Development
    pkg-config
    python3 stow gcc julia SDL2 cmake clang-tools
    python311Packages.python-lsp-server
    gnumake
    direnv
    
    # Latex
    pandoc texliveFull

    xdg-utils
    wlr-randr
    (import ./emacs.nix { inherit pkgs; })

    #texlive.combined.scheme-medium
    #texliveTeTeX

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" "Mononoki" "JetBrainsMono"]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    (writeShellScriptBin "nix-jack" ''
      exec /usr/bin/env \
        LD_LIBRARY_PATH=${pipewire.jack}/lib''${LD_LIBRARY_PATH:+:''${LD_LIBRARY_PATH}} \
        "''$@"
    '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.

    #"./Notes".source="/space/Notes";
    #"./Music".source="/space/Music";

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/horhik/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.waybar.enable = true;
  # programs.emacs = {            # 
  # enable = true;
  # extraPackages = epkgs: [
  #     epkgs.nix-mode
  #     epkgs.magit
  #     epkgs.org-roam
  #     epkgs.org-roam-ui
  #     epkgs.org-roam-timestamps
  #     epkgs.org-roam-bibtex
  #     epkgs.pdf-tools
  #     epkgs.sqlite
  #     epkgs.emacsql-sqlite
  #     epkgs.emacsql
  #   ];

  # };


  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
      vim = "emacsclient";
      sl = "lsd";
      ls = "lsd";
      l = "lsd -l";
      la = "lsd -la";
      ip = "ip --color=auto";
      hmgr = "emacsclient -n ~/.config/home-manager/home.nix";
      edit = "emacsclient -n ";
      sicp = "zathura /space/Nextcloud/Books/Calibre/Harold\ Abelson\,\ Gerald\ Jay\ Sussman\,\ Julie\ Sussman/Structure\ and\ Interpretation\ of\ Computer\ P\ -\ Harold\ Abelson\,\ Gerald\ Jay\ Sussman\,\ Julie\ .pdf";
      dimedovich = "zathura /space/Nextcloud/Books/Calibre/Unknown/Diemidovich\ sbornik\ \(32\)/Diemidovich\ sbornik\ -\ Unknown.pdf";
      zorich1 = "zathura /space/Nextcloud/Books/Calibre/Unknown/Matiematichieskii\ analiz\ chast\'\ I\ \[2012\]\ Zorich\ \(187\)/Matiematichieskii\ analiz\ chast\'\ I\ \[2012\]\ Z\ -\ Unknown.pdf";
      zorich2 = "zathura /space/Nextcloud/Books/Calibre/Unknown/Matiematichieskii\ analiz\ chast\'\ II\ \[2012\]\ Zorich\ \(188\)/Matiematichieskii\ analiz\ chast\'\ II\ \[2012\]\ -\ Unknown.pdf";        


      

    };

    initExtra = ''
      bindkey '^ ' autosuggest-accept
      AGKOZAK_CMD_EXEC_TIME=5
      AGKOZAK_COLORS_CMD_EXEC_TIME='yellow'
      AGKOZAK_COLORS_PROMPT_CHAR='magenta'
      AGKOZAK_CUSTOM_SYMBOLS=( '⇣⇡' '⇣' '⇡' '+' 'x' '!' '>' '?' )
      AGKOZAK_MULTILINE=0
      AGKOZAK_PROMPT_CHAR=( ❯ ❯ ❮ )
      eval $(thefuck --alias)
      autopair-init
      eval "$(direnv hook zsh)"

      bindkey "^[[1;5C" forward-word
      bindkey "^[[1;5D" backward-word

                              '';

    plugins = with pkgs; [
      {
        name = "agkozak-zsh-prompt";
        src = fetchFromGitHub {
          owner = "agkozak";
          repo = "agkozak-zsh-prompt";
          rev = "v3.7.0";
          sha256 = "1iz4l8777i52gfynzpf6yybrmics8g4i3f1xs3rqsr40bb89igrs";
        };
        file = "agkozak-zsh-prompt.plugin.zsh";
      }
      {
        name = "formarks";
        src = fetchFromGitHub {
          owner = "wfxr";
          repo = "formarks";
          rev = "8abce138218a8e6acd3c8ad2dd52550198625944";
          sha256 = "1wr4ypv2b6a2w9qsia29mb36xf98zjzhp3bq4ix6r3cmra3xij90";
        };
        file = "formarks.plugin.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.6.0";
          sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
        };
        file = "zsh-syntax-highlighting.zsh";
      }
      {
        name = "zsh-abbrev-alias";
        src = fetchFromGitHub {
          owner = "momo-lab";
          repo = "zsh-abbrev-alias";
          rev = "637f0b2dda6d392bf710190ee472a48a20766c07";
          sha256 = "16saanmwpp634yc8jfdxig0ivm1gvcgpif937gbdxf0csc6vh47k";
        };
        file = "abbrev-alias.plugin.zsh";
      }
      {
        name = "zsh-autopair";
        src = fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
          sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
        };
        file = "autopair.zsh";
      }
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
    network.listenAddress = "any"; # if you want to allow non-localhost connections
    extraConfig = ''
  audio_output {
    type "pipewire"
    name "MPD output"
  }
'';
  };
  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 49.0;
    longitude = 8.4;
  };


  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/pdf" = ["sioyek.desktop" "${pkgs.sioyek}/bin/sioyek" "org.sioyek.desktop"];
    };
    defaultApplications = {
      "application/pdf" = ["sioyek.desktop" "${pkgs.sioyek}/bin/sioyek" "org.sioyek.desktop"];
    };
  };


  
#  services.shadowsocks = {
#    enable = true;
#  };

}
