{ config, pkgs, lib, nix-flatpak, ... }:

{
  # GUI apps from nixpkgs
  environment.systemPackages = with pkgs; [
    brave
    discord
  ];

  # Steam full setup (32-bit libs + runtime)
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
}
