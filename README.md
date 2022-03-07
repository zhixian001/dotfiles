# Dotfiles

## Usage

### 1. Clone

### 2. Create Symlink

- example (.vimrc)

```bash
ln -s "$PWD/d.vimrc" ~/.vimrc
```

## Usage (bashrc / bash_profile files)

### 1. Clone

### 2. Append to original bashrc / profile files

```bash
echo "export JH_DOTFILES_DIR=\"$HOME/dotfiles\"" >> ~/.bashrc
echo "export JH_DOTFILES_DIR=\"$HOME/dotfiles\"" >> ~/.bash_profile
echo "source \"\$JH_DOTFILES_DIR\"/d.bashrc" >> ~/.bashrc
echo "source \"\$JH_DOTFILES_DIR\"/d.bash_profile" >> ~/.bash_profile
```
