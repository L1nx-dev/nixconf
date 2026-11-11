{ pkgs, config, ... }:

let
  kotlin-lsp = pkgs.callPackage ../cPkgs/kotlin-lsp.nix { };
in
{
  imports = [
    ./hyprland/hyprland.nix
    ./zsh/zsh.nix
    ./nvim/nvim.nix
    ./kitty/kitty.nix
    ./rofi/rofi.nix
    ./misc/misc.nix
    ./obsidian/obsidian.nix
    ./zen/zen.nix
    ./walker/walker.nix
    ./gtk/gtk.nix
  ]; 

  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    kotlin-lsp

    btop
    fd
    qt6.qtdeclarative
    timg
    mpv
    fzf
    ytfzf
    jq
    curl
    mpg123
    musikcube
    gnome-boxes
    onlyoffice-desktopeditors
    elephant
    ripgrep

    # TERMINAL ANIMATIONS #
    peaclock
    cava 
    lavat 


    pyright
    nixd
    typescript-language-server
    vscode-langservers-extracted
    kotlin-language-server
    jdt-language-server
    clang-tools
    omnisharp-roslyn     
    lua-language-server

    jdk21
    gradle


    (pkgs.python3.withPackages (ps: [ ps.pygame-ce ]))
    gradle
    android-studio
    jdk21


    vimix-cursors
    geist-font
    nerd-fonts.geist-mono
    nerd-fonts.symbols-only

    # HYPRLAND PLUGINS #
    (pkgs.callPackage ../cPkgs/hyprglass.nix {
      mkHyprlandPlugin = pkgs.hyprlandPlugins.mkHyprlandPlugin;
    })    

    android-tools
  ];

  qt.enable = true;
  qt.platformTheme.name = "gtk";
  qt.style.name = "adwaita-dark";

  fonts.fontconfig.enable = true;

  home.pointerCursor = {
    enable = true;
    package = pkgs.vimix-cursors;
    name = "Vimix-cursors";
    size = 30;
    gtk.enable = true;
    x11.enable = true;

    hyprcursor.enable = true;
    hyprcursor.size = 24;
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "user";
      user.email = "DJTrump@cumallover.me";
    };
  };

  systemd.user.services.ceres = {
    Unit.Description = "Ceres agent daemon";

    Service = {
      ExecStart = "/home/user/Projects/ceres/build/install/ceres/bin/ceres daemon";
      WorkingDirectory = "/home/user/Projects/ceres";
      Environment = [ "JAVA_HOME=${pkgs.jdk}" ];
      Restart = "on-failure";
      RestartSec = "3s";
      SuccessExitStatus = "143";
      TimeoutStopSec = "10s";
    };

    Install.WantedBy = [ "default.target" ];
  };
}
