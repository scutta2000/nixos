{ config, pkgs, lib, home-manager, ... }:

{
  home.username = "scutta";
  home.homeDirectory = "/home/scutta";
  home.stateVersion = "22.11";

  home.packages = with pkgs; lib.lists.flatten [
    xclip
    gcc
    neovim
    kitty
    nodejs
    (with nodePackages; [
      prettier
      typescript-language-server
      eslint
      vscode-langservers-extracted
      pnpm
    ])
    nodePackages."@tailwindcss/language-server"
    gnomeExtensions.pop-shell
    gnomeExtensions.appindicator
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
    htop
    flameshot
    xdg-desktop-portal-gnome
    xdg-desktop-portal
    beekeeper-studio
    starship
    any-nix-shell
    (appimageTools.wrapType2 {
      name = "RedisInsight";
      src = fetchurl {
        url = "https://download.redisinsight.redis.com/latest/RedisInsight-v2-linux-x86_64.AppImage";
        sha256 = "sha256-beOA2PwkolYak95CLwdjFVmYrl0h8p1/7RaXaKUnOsE=";
      };
    })
    openvpn
    cargo
    chromium
    inetutils
    lsof
    btop
    vscode
    dmidecode
    cudaPackages_12.cudatoolkit
    llvm
    clang-tools
    #llvmPackages_rocm.clang
    pkgs.cachix
    jetbrains.pycharm-community
    python311
    python311Packages.pip
    wpsoffice
    bat
    unzip
    nil
    lua-language-server
    gnumake
    skypeforlinux
    parallel
    opam
    fzf
    fd
    qrcp
    tree
  ];

  lib.xdg.desktopEntries."filen.io" = {
    name = "Filen.io";
    exec = "filen.io";
    terminal = false;
    categories = [ "Application" ];
  };

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
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
      hide_window_decorations = "yes";
    };
    keybindings = {
      "ctrl+shift+n" = "new_os_window_with_cwd";
      "ctrl+shift+t" = "new_tab_with_cwd";
    };
  };

  programs.fish = {
    enable = true;
    functions = {
      noe = '' cd ~/.config/home-manager && nvim home.nix '';
      nor = ''
      sudo nixos-rebuild switch --flake ~/.config/home-manager#scutta '';
      "openvpn-qmedia" = '' sudo openvpn ~/openvpn/pietro.scutta-config.ovpn'';
      "clear-port" = '' sudo lsof -i :$argv[1] | tee /dev/tty | awk '(NR>1) {print $2}' | xargs -p sudo kill -9 
      '';
      cdp = ''
      cd ~/code/(FZF_DEFAULT_COMMAND="fd --type d --base-directory ~/code -d 3" fzf --color dark)
      '';
    };
    shellInit = ''
      any-nix-shell fish --info-right | source
      set EDITOR nvim
      set NIXPKGS_ALLOW_UNFREE 1
      set CUDA_PATH ${pkgs.cudaPackages_12.cudatoolkit}

      source /home/scutta/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
    '';
  };

  programs.git = {
    enable = true;
    userName = "scutta";
    userEmail = "scuttari.pietro@gmail.com";
  };
}

