{ pkgs, config, ... }:
{
  environment.systemPackages = with pkgs; [
    curl
    git
    gparted
    htop
    tree
    tailscale
    unzip
    vim
    wget
  ];

  # Enable Flatpak
  services.flatpak.enable = true;

  # Enable Tailscale service system-wide
  services.tailscale.enable = true;

  # Pass the secret to the systemd service
  systemd.services.tailscaled.serviceConfig = {
    Environment = "TS_AUTHKEY=${config.mySecrets.tailscaleAuthKey}";
  };

}
