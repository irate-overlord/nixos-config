{
  description = "NixOS config with ZFS support";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

#  outputs = inputs: { # changing for now
  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.melchior = nixpkgs.lib.nixosSystem { # there was a input before nixpkgs
#      specialArgs = { inherit inputs; }; #optional for now - vimjoyer suggested
      system = "x86_64-linux";
      modules = [
        { nix.settings.experimental-features = ["nix-command" "flakes"]; }
        ./configuration.nix
        ./modules/common-tools.nix
        ./modules/user-software.nix
        ./modules/secrets.nix
        
        # Enable ZFS
        {
          networking.hostId = "4f411fe7"; # required for ZFS pool import
          boot.kernelPackages = nixpkgs.legacyPackages.x86_64-linux.linuxPackages_6_6; # LTS kernel for ZFS
          boot.supportedFilesystems = [ "zfs" ];
          boot.zfs.extraPools = [ "rust" ];
          # boot.zfs.package = pkgs.zfs_unstable; # set true only if needed

          # ZFS features
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
