# dotfiles

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
