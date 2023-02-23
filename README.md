# Plutarch Template

# Install Nix
```
sh <(curl -L https://nixos.org/nix/install) --daemon
```

# Set `/etx/nix/nix.conf`

```
build-users-group = nixbld
experimental-features = nix-command flakes ca-derivations
substituters = https://cache.nixos.org/
trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=
trusted-users = root <your-username>
```

## Dev environment

```
$ nix develop
```

## Running executable

```
[nix develop:~/plutarch-template]$ cabal run
```

## Running hoogle

```
[nix develop:~/plutarch-template]$ hoogle server --local --port=8085
```

## Precommits

### Run `,format` before commits cabal *.hs *.nix *.cabal

```
[nix develop:~/plutarch-template]$ ,format 
```

### Format check
```
[nix develop:~/plutarch-template]$ ,format check
```

# License
See the [LICENSE](LICENSE) file for license rights and limitations (MIT).
