# dotfiles

## install & update

```bash
( mkdir -p ~/local && cd "$_" && if [[ -d dotfiles ]]; then cd dotfiles && git pull --rebase; else git clone -c core.autocrlf=input --filter=tree:0 https://github.com/yukinobu/dotfiles.git; fi )
grep -qxF '. ~/local/dotfiles/_bashrc' ~/.bashrc || echo '. ~/local/dotfiles/_bashrc' >> ~/.bashrc
```

```bash
ln -s ~/local/dotfiles/_vimrc ~/.vimrc
```
