# Plutarch Template

# Introduction
This tutorial will guide you through setting up a development environment for Smart contract development in Cardano, a Plutarch template project, using Nix. Nix is a package manager that allows you to create reproducible development environments, making it easier to manage dependencies and avoid conflicts.

# Prerequisites
Before starting this tutorial, you will need to have Nix installed on your system. If you don't have Nix installed, you can do so by running the following command:

## Official option
[Nix](https://nixos.org/download.html)
```
sh <(curl -L https://nixos.org/nix/install) --daemon
```
## Preferred option
[Determinate Systems](https://zero-to-nix.com/concepts/nix-installer)
```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```



# Set Up
## On non-NixOS systems
After installing Nix, you need to configure it to work with Nix Flake. Edit file `/etc/nix/nix.conf` with the following content:

```
build-users-group = nixbld
experimental-features = nix-command flakes ca-derivations
substituters = https://cache.nixos.org/
trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=
trusted-users = root <your-username>
```
```
sudo systemctl restart nix-daemon.service
```
## MacOS
```
build-users-group = nixbld
experimental-features = nix-command flakes ca-derivations
substituters = https://cache.nixos.org/
trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=
trusted-users = <your-username>

system = x86_64-darwin
extra-platforms = x86_64-darwin aarch64-darwin
sandbox = false
extra-sandbox-paths = /System/Library/Frameworks /System/Library/PrivateFrameworks /usr/lib /private/tmp /private/var/tmp /usr/bin/env
```
save the changes and restart Mac

## On NixOS system
Edit file `/etc/nixos/configuration.nix `

```
 nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes ca-derivations
    '';
  };
  nix.settings.trusted-users = [ "root" "<your-username>"];
```
```
sudo nixos-rebuild switch
```

This configuration tells Nix to use the Nix binary cache at https://cache.nixos.org/ and enables experimental features such as Nix flakes and ca derivations.

Don't forget to add your username in `<your-username>`

# Development Environment
To create a development environment for Plutarch, run the following command in the project directory:

```
$ nix develop
```

This will create an isolated environment with all the required dependencies and tools for Plutarch development. You can now run any commands inside this environment.

# Running the Executable
To run the project executable, run the following command inside the development environment:

```
[nix develop:~/plutarch-template]$ cabal run
```

This will build and run the executable.

# Running Hoogle
Hoogle is a Haskell API search engine. To run Hoogle locally for the Plutarch project, run the following command inside the development environment:

```
[nix develop:~/plutarch-template]$ hoogle server --local --port=8085
```

This will start a local Hoogle server at http://localhost:8085/.

# Pre-Commits
Before committing your changes to your repository, it's recommended to run formatting checks to ensure your code adheres to the project's style guidelines.

## Formatting
To format all Haskell (`*.hs`, `*.cabal`) and Nix (`*.nix`) files in the project, run the following command inside the development environment:

```
[nix develop:~/plutarch-template]$ ,format 
```

This will format all files in the project according to the project's style guidelines.


## Formatting Check
To check if any files need formatting, run the following command inside the development environment:

```
[nix develop:~/plutarch-template]$ ,format check
```

This will check all files in the project and report any that need formatting.


# License
Plutarch is released under the MIT license. See the [LICENSE](LICENSE) file for more information.

