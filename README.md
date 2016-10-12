# dotfiles-vcsh
## General
To sync dotfiles between machines, I use [vcsh](https://github.com/RichiH/vcsh). As many tools use their own plugin
managers, e.g. vim's [vundle](https://github.com/VundleVim/Vundle.vim) and tmux's [tpm](https://github.com/tmux-plugins/tpm),
I keep minimal config in this repository, just enough to configure the tools and the plugin managers enough to do their job.

The below sections include anything necessary over and above `vcsh dotfiles-vcsh pull`, in order to get to my desired
environment. In the event that a dependency doesn't exist, I hope that the
config is as resilient as possible, but there are no guarantees.

## Tools and dependencies
### bash
#### bash-git-prompt
As seen [here](https://github.com/magicmonty/bash-git-prompt). A heavy but great prompt.

    git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

#### thefuck
As seen [here](https://github.com/nvbn/thefuck).

    pip install --user thefuck

#### virtualenvwrapper
As seen [here](https://virtualenvwrapper.readthedocs.io). I rarely use it these
days, most of my python packages are installed with `pip install --user`, but
for now it remains.

    pip install --user virtualenvwrapper

### tmux
#### tpm

    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

* Start tmux, or if tmux is already running, `C-a :source-file ~/.tmux.conf`.
* To install the plugins themselves, `C-a I`. This will also reload the tmux configuration.

[Full tmux installation docs](https://github.com/tmux-plugins/tpm)

#### powerline-daemon
My config attempts to use [powerline](https://github.com/powerline/powerline), or more accurately [powerline-daemon](https://github.com/kovidgoyal/powerline-daemon),
but reverts gracefully if powerline-daemon isn't present.

    pip install --user powerline-status
    wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
    wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
    mkdir ~/.fonts
    mv PowerlineSymbols.otf ~/.fonts/
    fc-cache -vf ~/.fonts/
    mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

In my experience, it is then necessary to restart the terminal emulator. Starting `tmux` should then display a pretty
and useful powerline at the bottom of the window.

[Full powerline-daemon installation docs](https://powerline.readthedocs.io/en/master/installation.html)

### vim
TODO - forgot to edit this last time I set up vim on a machine. Probably
includes installing vundle and doing a install plugins run.
