{
    description = "Dev env for Verilog dev";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs";
    };
    outputs = inputs@{ self, ... }:
    let
        system = "x86_64-linux";
        pkgs = import inputs.nixpkgs { inherit system; };
    in
    {
        devShells.${system}.default = pkgs.mkShell {
            packages = with pkgs; [
                gnumake
                iverilog
                verilator
                yosys
                gtkwave
                netlistsvg
                haskellPackages.sv2v
            ];
        };
    };
}
