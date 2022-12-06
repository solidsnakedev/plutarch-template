{
  description = "plutarch-template";

  nixConfig = {
    extra-experimental-features = [ "nix-command" "flakes" "ca-derivations" ];
    extra-substituters = [ "https://cache.iog.io" "https://public-plutonomicon.cachix.org" ];
    extra-trusted-public-keys = [ "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=" "public-plutonomicon.cachix.org-1:3AKJMhCLn32gri1drGuaZmFrmnue+KkKrhhubQk/CWc=" ];
    allow-import-from-derivation = "true";
    bash-prompt = "\\[\\e[0;92m\\][\\[\\e[0;92m\\]nix develop:\\[\\e[0;92m\\]\\w\\[\\e[0;92m\\]]\\[\\e[0;92m\\]$ \\[\\e[0m\\]";
  };

  inputs = {
    tooling.url = "github:mlabs-haskell/mlabs-tooling.nix";
    plutarch.url = "github:Plutonomicon/plutarch";
    ply.url = "github:mlabs-haskell/ply?ref=master";
    plutus-simple-model.url = "github:mlabs-haskell/plutus-simple-model/fa0aa0382ecabf6fcbef8c7b9c35d85ff7b57765";

  };

  outputs = inputs@{ self, tooling, plutus-simple-model, plutarch, ply }: tooling.lib.mkFlake { inherit self; }
    {
      imports = [
        (tooling.lib.mkHaskellFlakeModule1 {
          project.src = ./.;
          project.shell.withHoogle = true;
          project.modules = [
            ({ config, ... }: {
              packages.plutus-simple-model.doHaddock = false;
            })
          ];
          project.extraHackage = [
            "${plutus-simple-model}"
            "${plutarch}"
            "${ply}/ply-core"
            "${ply}/ply-plutarch"
          ];
        })
      ];
    };
}
