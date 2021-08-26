# NixOS setup

1. Backup your old config
```bash
$ sudo mv /etc/nixos /etc/nixos.old
```

2. Copy repo and symlink new config from dotfiles
```bash
$ git clone https://github.com/horhik/dotfiles
$ cd dotfiles
$ sudo ln -s $HOME/dotfiles/nix /etc/nixos
```

3. Past your hardware-configuration
```bash
$ sudo cp /etc/nixos.old/hardware-configuration.nix /etc/nixos/
```

4. Install home-manager
```bash
$ nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
$ nix-channel --update

$ nix-channel --add https://github.com/nix-community/home-manager/archive/release-21.05.tar.gz home-manager
$ nix-channel --update

export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH

$ nix-shell '<home-manager>' -A install
```

5. Copy dotfiles
	  ```bash
	  stow --adopt -vt ~ $HOME/dotfiles/home/*
	  ```
6. Build nixos
```bash
  cd /etc/nixos
  sudo nixos-rebuild build --flake "#."
```


