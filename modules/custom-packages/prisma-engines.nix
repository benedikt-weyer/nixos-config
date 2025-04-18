{ 
	pkgs,
	pkgs-unstable,
	config, 
	lib, 
	cfg, 
	... 
}:

let
	prisma-engines-utd = pkgs.callPackage ./prisma-engines/package.nix { inherit pkgs pkgs-unstable lib; };
in
rec {
	environment.systemPackages = [
		prisma-engines-utd
	];
}