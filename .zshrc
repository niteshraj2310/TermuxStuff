# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Loading some(?) Oh-My-ZSH libs with ZInit Turbo!
zinit lucid light-mode for \
    OMZL::history.zsh \
    OMZL::completion.zsh \
    OMZL::key-bindings.zsh

# Syntax highlighting, completions, auto-suggestions and some other plugins.
zinit wait lucid light-mode for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
      OMZP::colored-man-pages \
      OMZP::git \
  atload"!_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions

# Powerlevel10k Theme.
zinit ice depth=1; zinit light romkatv/powerlevel10k

# FZF (keybinds and completion).
zinit wait lucid is-snippet for \
    $PREFIX/share/fzf/key-bindings.zsh \
    $PREFIX/share/fzf/completion.zsh

# Use 16 colors
export FZF_DEFAULT_OPTS='--color 16'

# Add your aliases/functions here!

#### FUNCTIONS #####
function lit-colors() {
    if [ $(curl -I https://git.io 2>&1 | awk '/HTTP\// {print $2}') -eq 200 ]; then
    echo "Loading color scheme menu, please wait."
    bash -c "$(curl -fsSL 'https://git.io/JURDN')"
    clear
  else
    echo "Can't connect to color schemes repository."
  fi
}

function lit-fonts() {
  if [ $(curl -I https://git.io 2>&1 | awk '/HTTP\// {print $2}') -eq 200 ]; then
    echo "Loading font style menu, please wait."
    bash -c "$(curl -fsSL 'https://git.io/JtHgC')"
    clear
  else
    echo "Can't connect to font styles repository."
  fi
}

function lit-update() {
    echo "Updating system packages."
    pkg upgrade -y
    clear

    echo "Updating ZSH/Zinit stuff.."
    zi update --all
    clear

    echo "Updating bSUDO..."
    curl -L 'https://github.com/agnostic-apollo/sudo/releases/latest/download/sudo' -o $PREFIX/bin/bsudo
    owner="$(stat -c "%u" "$PREFIX/bin")"
    chown "$owner:$owner" "$PREFIX/bin/bsudo"
    chmod 700 "$PREFIX/bin/bsudo"
    clear

    echo "Updating Androfetch...."
    curl -o $PREFIX/bin/androfetch https://raw.githubusercontent.com/laraib07/androfetch/main/androfetch
    clear

    echo "Updated succesfully, enjoy!"
    sleep 2
    clear
}

#### ALIASES #####
alias fetch='androfetch'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
