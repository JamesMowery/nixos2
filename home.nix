{ config, pkgs, pkgs-unstable, ...}:
{
  home.username = "james";
  home.homeDirectory = "/home/james";
  
  home.packages = [
    # General
    pkgs.alacritty
    pkgs.fish
    pkgs.neofetch
    
    # Web
    #pkgs.firefox

    # Utility
    pkgs-unstable.btop
    pkgs.flameshot
    pkgs.fzf
    pkgs.gparted
    pkgs.killall
    pkgs.nethogs
    #nh
    pkgs.openrgb
    pkgs.tldr
    pkgs.nvd
    pkgs.ripgrep
    pkgs.starship
    pkgs.unzip
    pkgs.wget
    pkgs.yazi

    # Productivity
    pkgs.hunspell
    pkgs.hunspellDicts.en_US-large
    pkgs.libreoffice-qt
    pkgs.logseq
    pkgs.qalculate-qt
    pkgs.thunderbird

    # Development
    pkgs.lazygit
    pkgs.nodejs
    pkgs.tree-sitter
    pkgs.vscodium

    # Multimedia
    pkgs.ffmpeg
    pkgs.handbrake
    pkgs.mpv
    pkgs.stremio

    # Creative
    pkgs.fluidsynth
    pkgs-unstable.freecad
    #pkgs.gimp
    #pkgs.kicad
    pkgs-unstable.obs-studio
    pkgs-unstable.obsidian

    # Gaming
    pkgs-unstable.goverlay
    pkgs-unstable.heroic
    pkgs-unstable.lutris
    pkgs-unstable.mangohud
    pkgs-unstable.protonup-qt

    # Virtualization / Emulation
    pkgs-unstable.bottles
    pkgs-unstable.distrobox
    #pkgs.podman
    pkgs-unstable.winetricks
    pkgs-unstable.wineWowPackages.stable
    #pkgs.wineWowPackages.waylandFull

    # Social
    pkgs.discord
    pkgs.signal-desktop
    pkgs.telegram-desktop

    # Finance
    #pkgs.ib-tws
    pkgs.tradingview
  ];

  programs.firefox = {
    enable = true;
    #profiles.default = {
    #  id = 0;
    #  name = "default";
    #  isDefault = true;
    #  settings = {
    #    "extensions.formautofill.creditCards.enabled" = false;
    #    "dom.payments.defaults.saveAddress" = false;
    #    "extensions.pocket.enabled" = false;
    #    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    #    "layout.css.color-mix.enabled" = true;
    #    "media.ffmpeg.vaapi.enabled" = true;
    #    "cookiebanners.ui.desktop.enabled" = true;
    #    "devtools.command-button-screenshot.enabled" = true;
    #  };
    #};
  };

  programs.git = {
    enable = true;
    package = pkgs-unstable.git;
    userName = "James Mowery";
    userEmail = "jmowery@gmail.com";
  };

  programs.neovim = {
    enable = true;
    #package = pkgs-unstable.neovim;
    plugins = [
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];
  };

  #programs.steam = {
  #  enable = true;
  #  gamescopeSession.enable = true;
  #};

  home.file = {

  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Hyprland/Wayland/WM Specific
  #services.blueman-applet.enable = true;
  #packages.hyprpaper.enable = true;
  #packages.hyprshot.enable = true;
  #packages.mako.enable = true;
  #packages.waybar.enable = true;
  #packages.wofi.enable = true;

  #packages.mako.enable = true;
  
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
