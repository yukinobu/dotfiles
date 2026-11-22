# dotfiles

## prerequirements

```bash
apt install git bash-completion
```

## install & update

```bash
( mkdir -p ~/local && cd "$_" && if [[ -d dotfiles ]]; then cd dotfiles && git pull --rebase --prune; else git clone -c core.autocrlf=input --filter=tree:0 --single-branch --branch main --no-tags https://github.com/yukinobu/dotfiles.git; fi )
grep -qxF '. ~/local/dotfiles/_bashrc' ~/.bashrc || echo '. ~/local/dotfiles/_bashrc' >> ~/.bashrc
```

```bash
ln -is ~/local/dotfiles/_bashrc_safe ~/.bashrc_safe
cp -i ~/local/dotfiles/_gitconfig ~/.gitconfig
ln -is ~/local/dotfiles/_gitignore ~/.gitignore
ln -is ~/local/dotfiles/_vimrc ~/.vimrc
cp -i ~/local/dotfiles/_npmrc ~/.npmrc
ln -is ~/local/dotfiles/_screenrc ~/.screenrc
```

## HTTPS credentials on Windows and WSL

On Windows, enable Git Credential Manager (GCM) in the Git for Windows
installer to configure the system helper `manager`.

To reuse Windows GCM from WSL, set the helper in WSL's XDG Git config so
it survives updates to `~/.gitconfig`. Run this in WSL for a default x64
installation of Git for Windows 2.56 or later. For other versions,
architectures, or installation locations, check the executable path in the
[GCM WSL setup guide](https://github.com/git-ecosystem/git-credential-manager/blob/main/docs/wsl.md).

```bash
wsl_git_config="${XDG_CONFIG_HOME:-$HOME/.config}/git/config"
mkdir -p "$(dirname "$wsl_git_config")" &&
    git config --file "$wsl_git_config" credential.helper '/mnt/c/Program\ Files/Git/ucrt64/bin/git-credential-manager.exe'
```

If you copied an older `_gitconfig`, remove the `/mnt/c/...` and `wincred`
helper entries supplied by dotfiles from your installed `~/.gitconfig`.
Check the configured helpers and their source files in each environment.

```bash
git config --show-origin --get-all credential.helper
```

## copy my dev container into another local git repository

```bash
# Run in a Git worktree
if [[ -e .devcontainer || -L .devcontainer ]]; then
    echo ".devcontainer already exists" >&2
else
    exclude="$(git rev-parse --git-path info/exclude)"
    grep -qxF ".devcontainer/" "${exclude}" || echo ".devcontainer/" >> "${exclude}"
    cp -ir ~/local/dotfiles/_devcontainer .devcontainer
fi
```
