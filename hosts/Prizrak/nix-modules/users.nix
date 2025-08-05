{config, pkgs, ...}:
{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin"; 

  users.users.Prizrak = {
    isNormalUser = true;
    home = "/home/Prizrak";
    extraGroups = ["wheel" "networkmanager" ];
  };
}
