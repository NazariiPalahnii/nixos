{ pkgs, config, lib, inputs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.dribbblish;

    colorScheme = "catppuccin-macchiato";

  #  customColorScheme = {
  #    accent = accent;
  #    accent-active = accent;
  #    border-active = accent;
  #    tab-active = accent;
  #    player = background;
  #    sidebar = background;
  #    highlight = accent;
  #  };


    enabledExtensions = with spicePkgs.extensions; [
      playlistIcons
      lastfm
      historyShortcut
      hidePodcasts
      adblock
      fullAppDisplay
      keyboardShortcut
    ];
  };
}
