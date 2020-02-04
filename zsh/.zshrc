# set encoding
LANG="en_GB.UTF-8"

# defaults
EDITOR=nvim
export EDITOR

# powerline10k - instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# dotfiles
declare -a apps=("zsh")
pushd ${HOME}/.dotfiles >/dev/null
  for app in "${apps[@]}"; do
    stow -R -t ~ ${app}
  done
popd >/dev/null

# zplug - init
export ZPLUG_HOME=${HOME}/.zplug
if [ ! -d ${ZPLUG_HOME} ]; then
  git clone https://github.com/zplug/zplug ${ZPLUG_HOME}
  sed -i'' -e 's,compinit -d,compinit -u -d,g' ${ZPLUG_HOME}/base/core/load.zsh
fi
source $ZPLUG_HOME/init.zsh

# zplug - install plugins
zplug "DarrinTisdale/zsh-aliases-exa", depth:1
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "plugins/ansible", from:oh-my-zsh, depth:1
zplug "plugins/git", from:oh-my-zsh, depth:1
zplug "plugins/osx", from:oh-my-zsh, depth:1
zplug "zsh-users/zsh-autosuggestions", depth:1
zplug "zsh-users/zsh-completions", depth:1
zplug "zsh-users/zsh-syntax-highlighting", depth:1, defer:2

# zplug - install missing
if ! zplug check --verbose; then
  echo; zplug install
fi

# powerline9k
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(hostname dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs history time)

# zplug - load
zplug load

# dsdo
PATH=$PATH:$HOME/Projects/dsgo
export PATH

# python
alias python=/usr/local/bin/python3
alias pip=/usr/local/bin/pip3
source /Users/dev35/.venv/bin/activate

# thefuck
eval $(thefuck --alias)
alias f='fuck'

# vim
alias vi='nvim'
alias vim='nvim'
alias nano='nvim'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
