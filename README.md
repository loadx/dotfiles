# The most minimal multi-host nix flake

## How it works

```bash
├── apps
│   ├── dircolors.nix
│   ├── direnv.nix
│   ├── git.nix
│   ├── htop.nix
│   ├── nixpkgs.nix
│   ├── tmux.nix
│   └── zsh.nix
├── flake.lock
├── flake.nix
├── hosts
│   └── wsl
│       ├── apps
│       │   ├── git.nix
│       │   └── zsh.nix
│       └── default.nix
└── lib
    └── helpers.nix
```

### Structure

| Folder      | Purpose                                                                                                    |
| ----------- | ---------------------------------------------------------------------------------------------------------- |
| `apps`      | Contains a list of generic home-manager settings or includes that you want on every host (unless excluded) |
| `flake.nix` | Entry point that specifies the flake output for each host                                                  |
| `lib`       | Common functions live in here                                                                              |
| `hosts`     | This is where you put all the settings and specific attributes for each host                               |

### Adding or overwriting things

This config has been stripped back to the barest of essentials, where everything in the root [apps](./apps) folder applies to all systems. The magic that makes all this happen is the simple function defined here [lib/helpers.nix#L4](lib/helpers.nix#L4)
By default this will search for all `${path}/*.nix` files and include them; You can exclude things as needed by adding them to the exclude list.

For host-based overrides, the same function is used, importing all `hosts/<host>/apps/*.nix` files. The precedence here is for any app files in the host to override any attributes of the `apps/*.nix` parent. No more need to go full galaxy brain and use things like mkMerge.

The rest is on you to bring.

### Defining a host

Use these as a base

#### Linux/WSL (Non-NixOS) using home-manager

1. Create a new hosts folder and default.nix file

```bash
touch hosts/<your host name>/default.nix
```

2. Fill in the contents of the default.nix for your new host:

```nix
{ inputs, helpers, ... }:

inputs.home-manager.lib.homeManagerConfiguration {
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;

  extraSpecialArgs = { inherit inputs; };

  modules = [
    (
      { pkgs, ... }:
      {
        nix = {
          enable = false;
          package = pkgs.nix;
          settings = {
            experimental-features = "nix-command flakes";
          };
        };

        manual = {
          html.enable = false;
          manpages.enable = false;
          json.enable = false;
        };

        home = {
          username = "myuser";
          homeDirectory = "/home/myuser";
          stateVersion = "25.11";
        };

        # --- Shared & Local Imports ---
        imports =
          (helpers.importAllNixFiles { path = ../../apps; })
          ++ (helpers.importAllNixFiles {
            path = ./apps;
          });

        home.packages = with pkgs; [
          git
        ];

        # Let Home Manager install and manage itself
        programs.home-manager.enable = true;
      }
    )
  ];
}
```

3. wire up the flake output [flake.nix](./flake.nix) <br /><br />
   Add to the bottom stanza

```nix
homeConfigurations.<your hostname> = import ./hosts/wsl/default.nix {
  inherit inputs helpers;
};
```

#### Darwin/MacOS - Using [nix-darwin](https://github.com/nix-darwin/nix-darwin)

1. Create a new hosts folder and default.nix file

```bash
touch hosts/<your host name>/default.nix
```

2. Fill in the contents of the default.nix for your new host:

```bash
touch hosts/<host alias>default.nix
```

```nix
{ inputs, helpers, ... }:
inputs.darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  specialArgs = { inherit inputs helpers; };

  modules = [
    inputs.home-manager.darwinModules.home-manager

    ({ pkgs, ... }: {
      # --- ENGINE 1: nix-darwin (System) ---
      imports = [ ./apps/brew.nix ];

      system.stateVersion = 6;
      system.primaryUser = "myuser";

      nix.settings.experimental-features = "nix-command flakes";
      nix.enable = false;

      users.users.myuser = {
        name = "myuser";
        home = "/Users/myuser";
      };

      home.stateVersion = "25.11";

      # --- Shared & Local Imports ---
      imports =
        (helpers.importAllNixFiles { path = ../../apps; })
          ++ (helpers.importAllNixFiles {
            path = ./apps;
      };

      environment.systemPackages = with pkgs; [
        vim
        git
      ];
    })
  ];
}
```

3. wire up the flake output [flake.nix](./flake.nix)<br /><br />
   Add to the bottom stanza

```nix
darwinConfigurations.amber = import ./hosts/amber/default.nix {
  inherit inputs helpers;
};
```

### Building

Dependent on if you are using home-manager or darwin-nix

For darwin-nix (assuming the host is a mac called `bob`)

```bash
sudo darwin-rebuild switch --flake .#bob
```

For home-manager (assuming the host is Linux'y and called `bill`)

```bash
home-manager switch --impure --flake .#loadx@bill
```

### What if I have a host i dont want in my git repository?

Yeah this is a pain in home-manager that it wants everything to be in the local .git folder. Here's a workaround:

```bash
git add -N hosts/<host i want to hide>
```

Voila
