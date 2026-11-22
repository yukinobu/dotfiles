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

In WSL, the shared config uses Windows GCM when the default x64 Git for
Windows 2.56+ executable is available. If HTTPS Git commands started prompting
for a username after an update, replace the old dotfiles `[credential]` block
in `~/.gitconfig` with the block from the updated `_gitconfig`, or add it if
it is missing. If WSL already has the same GCM path in its XDG Git config,
keep a single entry for that executable.

For another installation path, configure the helper in WSL using the
[GCM WSL setup guide](https://github.com/git-ecosystem/git-credential-manager/blob/main/docs/wsl.md).
Use this command to see the helpers and their source files.

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
