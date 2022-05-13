{
  description = "baycomp";

  # 2022-01-24
  inputs.nixpkgs.url =
    "github:NixOS/nixpkgs/8ca77a63599ed951d6a2d244c1d62092776a3fe1";

  outputs = { self, nixpkgs }:

    let system = "x86_64-linux";
    in with import nixpkgs { inherit system; };

    let python = python39;
    in rec {

      defaultPackage."${system}" = packages."${system}".baycomp;

      packages."${system}".baycomp = python.pkgs.buildPythonPackage {
        pname = "baycomp";
        version = "unstable";

        src = self;

        doCheck = false;

        propagatedBuildInputs = with python.pkgs; [ matplotlib numpy scipy ];

        meta = with lib; {
          homepage = "https://github.com/janezd/baycomp";
          description = "A library for Bayesian comparison of classifiers";
          license = licenses.mit;
        };
      };
    };
}
