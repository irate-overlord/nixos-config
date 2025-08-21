{
  description = "NixOS config with ZFS support and user software";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.melchior = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        # Enable flakes in nix.conf
        { nix.settings.experimental-features = [ "nix-command" "flakes" ]; }

        # Your system modules
        ./configuration.nix
        ./modules/secrets.nix
        ./modules/common-tools.nix
        ./modules/user-software.nix
        ./modules/flatpak.nix

        # ZFS configuration
        {
          networking.hostId = "4f411fe7"; # required for ZFS pool import
          boot.kernelPackages = nixpkgs.legacyPackages.x86_64-linux.linuxPackages_6_6; # LTS kernel for ZFS
          boot.supportedFilesystems = [ "zfs" ];
          boot.zfs.extraPools = [ "rust" ];

          services.zfs = {
            autoScrub.enable = true;
            autoScrub.interval = "weekly";
            trim.enable = true;
          };
        }
      ];
    };
  };
}
