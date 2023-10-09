{ pkgs, lib, ... }:

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
    gnome3.gnome-tweaks
    mattermost-desktop
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    obsidian
    (appimageTools.wrapType2 {
      name = "filen.io";
      src = fetchurl {
        url = "https://cdn.filen.io/desktop/release/filen_x86_64.AppImage";
        sha256 = "sha256-5vkndT9V/81fUdzS+KTfAjPAGO0IJRx8QhNxBNG8nnU=";
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
        sha256 = "sha256-ptP2+Wk6Vf6uHbmqUNiWEogar4vyvaqVGEJA2rRWwvs=";
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
    cachix
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
    nvtop
    (appimageTools.wrapType2 {
      name = "bruno";
      src = fetchurl {
        url = "https://github.com/usebruno/bruno/releases/download/v0.22.0/bruno_0.22.0_x86_64_linux.AppImage";
        sha256 = "sha256-bQS6bIV6/v84aRjtBzz2kQ6ec79Ie606K5oXFuG+h70=";
      };
    })
  ];

  xdg.desktopEntries."filen.io" = {
    name = "Filen.io";
    exec = "filen.io";
    terminal = false;
    categories = [ "Application" ];
    icon = pkgs.fetchurl {
      url = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.A2pgLX_Xzioy5jR-tbMffwHaHa%26pid%3DApi&f=1&ipt=563f27a08889e1ca4ade04a26597ff020480edffb912feffef43258e1553a36f&ipo=images";
      sha256 = "sha256-dTG8Dswj+YX2aOnZPHQH+UWasxMmF4Ju+i21PPl+fWo=";
    };
  };
  xdg.desktopEntries."RedisInsight" = {
    name = "RedisInsight";
    exec = "RedisInsight";
    terminal = false;
    categories = [ "Application" ];
    icon = pkgs.fetchurl {
      url = "http://thenewstack.io/wp-content/uploads/2015/03/redis-logo.png";
      sha256 = "sha256-eVFiN8WpK+s6PXXBxudJM9+/sIY1STc3jheSaE757Us=";
    };

  };
  xdg.desktopEntries."Bruno" = {
    name = "bruno";
    exec = "bruno";
    terminal = false;
    categories = [ "Application" ];
    icon = pkgs.fetchurl {
      url = "https://github.com/usebruno/bruno/blob/main/assets/images/logo-transparent.png?raw=true";
      sha256 = "sha256-A6h72gKkGnZgxoneKNyQZHLj7354tUYjEGi2IHGhvBU=";
    };
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
      nor = '' sudo nixos-rebuild switch --flake ~/.config/home-manager#scutta '';
      "openvpn-qmedia" = '' sudo openvpn ~/openvpn/pietro.scutta-config.ovpn'';
      "clear-port" = '' sudo lsof -i :$argv[1] | tee /dev/tty | awk '(NR>1) {print $2}' | xargs -p sudo kill -9 
      '';
      cdp = '' cd ~/code/(FZF_DEFAULT_COMMAND="fd --type d --base-directory ~/code -d 3" fzf --color dark) '';
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
    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = false;
      core.autocrlf = "input";
    };
    delta = {
      enable = true;
      options = {
        line-numbers = true;
      };
    };
  };
}

