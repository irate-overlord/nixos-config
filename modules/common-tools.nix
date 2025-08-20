{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    vim
    curl
    wget
    htop
    unzip
    tree
    tailscale
  ];

  # Enable Tailscale service system-wide
  services.tailscale.enable = true;

}
