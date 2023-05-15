{ config, pkgs, lib, ... }:

{
  home.username = "scutta";
  home.homeDirectory = "/home/scutta";
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    xclip
    gcc
    neovim
    kitty
    nodejs
    gnomeExtensions.pop-shell
    gnomeExtensions.tray-icons-reloaded
    pkgs.gnome3.gnome-tweaks
    mattermost-desktop
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    obsidian
    (appimageTools.wrapType2 {
      name = "filen.io";
      src = fetchurl {
        url = "https://cdn.filen.io/desktop/release/filen_x86_64.AppImage";
        sha256 = "sha256-Zax7MmGJtuV9AhbZ8URUMvbKnLdDSt+jl86V8DzZUuM=";
      };
    })
    insomnia
    aws-sam-cli
    awscli2
    ripgrep
    yarn
  ];
  lib.xdg.desktopEntries."filen.io" = {
    name = "Filen.io";
    exec = "filen.io";
    terminal = false;
    categories = [ "Application" ];
  };


  fonts.fontconfig.enable = true;

  programs.kitty = {
    enable = true;
    settings = {
      background = "#1b1d22";
      foreground = "#e6e8ee";
      cursor = "#f6f6ec";
      selection_background = "#2e353d";
      color0 = "#22252b";
      color8 = "#22252b";
      color1 = "#b53f36";
      color9 = "#b53f36";
      color2 = "#5ab977";
      color10 = "#5ab977";
      color3 = "#ddb566";
      color11 = "#ddb566";
      color4 = "#6a7b92";
      color12 = "#6a7b92";
      color5 = "#a3799d";
      color13 = "#a3799d";
      color6 = "#3f93a8";
      color14 = "#3f93a8";
      color7 = "#e6e8ee";
      color15 = "#ebedf2";
      selection_foreground = "#1b1d22";
    };
    keybindings = {
      "ctrl+shift+n" = "new_os_window_with_cwd";
      "ctrl+shift+t" = "new_tab_with_cwd";
    };
  };

  programs.fish = {
    enable = true;
    functions = {
      noe = '' cd /home/scutta/.config/home-manager && nvim '';
      nor = '' sudo nixos-rebuild switch --flake /home/scutta/.config/home-manager#scutta '';

    };
  };

  programs.git = {
    enable = true;
    userName = "scutta";
    userEmail = "scuttari.pietro@gmail.com";
  };
}

