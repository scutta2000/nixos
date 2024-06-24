{ pkgs, ... }:
{
  stylix = {
    enable = true;
    image = ./../wallpaper.jpg;
    polarity = "dark";

    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  };
}
