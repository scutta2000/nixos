{ config, pkgs, ... }:

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
    pkgs.gnome3.gnome-tweaks
    mattermost-desktop
    docker
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

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
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      alias nor="sudo nixos-rebuild switch --flake .#scutta"
    '';
  };

  programs.git = {
    enable = true;
    userName = "scutta";
    userEmail = "scuttari.pietro@gmail.com";
  };
}

