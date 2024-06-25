
{ inputs, pkgs, lib, ... }:

{
  imports = [
    inputs.ags.homeManagerModules.default
    inputs.anyrun.homeManagerModules.default
  ];

  home.packages = with pkgs; lib.lists.flatten [
    bun
    brightnessctl
    playerctl
    swww
    dart-sass
    grim
    slurp
    swappy
    wl-clipboard
  ];

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    bind = [ 
      "$mod, T, exec, kitty"
      "$mod, C, exec, firefox"
      "$mod, E, exec, nautilus"
      "$mod, Q, killactive"
      "$mod, F, togglefloating"
      "$mod, W, fullscreen, 1"
      "$mod, SUPER_L, exec, anyrun"
      "$mod, S, togglegroup"

      "$mod, H, movefocus, l"
      "$mod, J, movefocus, d"
      "$mod, K, movefocus, u"
      "$mod, L, movefocus, r"

      "SUPER_SHIFT, H, movewindoworgroup, l"
      "SUPER_SHIFT, J, movewindoworgroup, d"
      "SUPER_SHIFT, K, movewindoworgroup, u"
      "SUPER_SHIFT, L, movewindoworgroup, r"

      "CONTROL_SUPER_SHIFT, J, changegroupactive, f"
      "CONTROL_SUPER_SHIFT, K, changegroupactive, b"

      "SUPER_SHIFT, SPACE, exec, playerctl play-pause"
      "SUPER_SHIFT, N, exec, playerctl next"
      "SUPER_SHIFT, P, exec, playerctl previous"

      ''ALT_SHIFT, 2, exec, grim -g "$(slurp)" - | swappy -f -''
    ] ++ (
      # workspaces
      # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
      builtins.concatLists (builtins.genList (
          x: let
            ws = let
              c = (x + 1) / 10;
            in
              builtins.toString (x + 1 - (c * 10));
          in [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]
        )
        10)
    );
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
    binde = [
      "CONTROL_SUPER_SHIFT, H, resizeactive, 10 10"
      "CONTROL_SUPER_SHIFT, L, resizeactive, -10 -10"
    ];
    input = {
      # kb_layout = "us_altgr-intl";
      kb_options = "caps:escape";
      touchpad = {
        natural_scroll = true;
        clickfinger_behavior = true;
      };
    };
    exec-once = [
      "swww init"
    ];
    exec = [
      "swww img ../wallpaper.jpg"
      "ags"
    ];
    gestures = {
      workspace_swipe = true;
      workspace_swipe_use_r = true;
      workspace_swipe_distance = 200;
    };
    misc = {
      disable_hyprland_logo = true;
      new_window_takes_over_fullscreen = 2;
    };
  };
  wayland.windowManager.hyprland.plugins = [
    # inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
  ];

  programs.ags = {
    enable = true;

    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };

  programs.anyrun = {
    enable = true;
    config = {
      plugins = [
        inputs.anyrun.packages.${pkgs.system}.applications
        inputs.anyrun.packages.${pkgs.system}.websearch
      ];
      width = { fraction = 0.25; };
      y = { fraction = 0.3; };
      hideIcons = false;
      ignoreExclusiveZones = true;
      layer = "overlay";
      hidePluginInfo = true;
      closeOnClick = true;
      showResultsImmediately = true;
      maxEntries = null;
    };
    # extraCss = ''
    #   @import url("stylesheet.css");
    # '';
  };
}
