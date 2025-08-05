{ config, lib, pkgs, nixpkgs, inputs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix

      ../../modules/wm/nvidia

#      ../../modules/tui/bluetooth
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.config.common.default = "*";

  nixpkgs.config.allowUnfree = true;


  nix.settings.experimental-features = ["nix-command" "flakes"];

   networking.hostName = "nixos"; # Define your hostname.
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

   time.timeZone = "Europe/Berlin";

 fonts = {
  enableDefaultPackages = true;
  packages = with pkgs; [ 
    ubuntu_font_family
    liberation_ttf
    material-symbols
    nerd-fonts.jetbrains-mono
    # Persian Font
    vazir-fonts
  ];

  fontconfig = {
    defaultFonts = {
      serif = [  "Liberation Serif" "Vazirmatn" ];
      sansSerif = [ "Ubuntu" "Vazirmatn" ];
      monospace = [ "Ubuntu Mono" ];
    };
  };
}; 

  services.pipewire = {
     enable = true;
     pulse.enable = true;
  };

   users.users.Prizrak = {
     isNormalUser = true;
     extraGroups = [ "wheel" "input" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };

   programs.dconf.enable = true;

   environment.systemPackages = with pkgs; [
   #...
   ];

  system.stateVersion = "25.05"; # Did you read the comment?

}

