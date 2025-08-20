{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    brave
    protonpass
    steam
  ];
}
