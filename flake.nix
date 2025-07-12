{
  description = "Home media server nixos system configuration";

  inputs = {
    # *** CHANGE HERE: Use the 25.05 stable branch ***
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    # Define a specific NixOS configuration for your machine.
    # Replace 'your-hostname' with the actual hostname of your machine.
    # You can find your hostname by running 'hostname' in your terminal.
    nixosConfigurations."media" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; # Adjust for your architecture

      specialArgs = { inherit home-manager; };

      modules = [
        ./nixos
        home-manager.nixosModules.home-manager
      ];
    };
  };
}