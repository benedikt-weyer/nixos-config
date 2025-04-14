{ pkgs, config, lib, cfg, ... }:

let
	prisma-engines-utd = pkgs.callPackage ./prisma-engines/package.nix { inherit pkgs lib; };
in
rec {
	environment.systemPackages = [
		prisma-engines-utd
	];
}