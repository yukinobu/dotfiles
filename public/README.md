# dotfiles

## prerequirements

```bash
apt install git bash-completion
```

## install & update

```bash
( mkdir -p ~/local && cd "$_" && if [[ -d dotfiles ]]; then cd dotfiles && git pull --rebase; else git clone -c core.autocrlf=input --filter=tree:0 https://github.com/yukinobu/dotfiles.git; fi )
grep -qxF '. ~/local/dotfiles/_bashrc' ~/.bashrc || echo '. ~/local/dotfiles/_bashrc' >> ~/.bashrc
```

```bash
ln -is ~/local/dotfiles/_bashrc_safe ~/.bashrc_safe
cp -i ~/local/dotfiles/_gitconfig ~/.gitconfig
ln -is ~/local/dotfiles/_gitignore ~/.gitignore
ln -is ~/local/dotfiles/_vimrc ~/.vimrc
cp -i ~/local/dotfiles/_npmrc ~/.npmrc
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
