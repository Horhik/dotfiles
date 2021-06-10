
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export _JAVA_AWT_WM_NONREPARENTING=1
export ANDROID_SDK_ROOT=/home/horhik/Android/Sdk/
export NDK_HOME=/home/horhik/Android/Sdk/ndk/22.0.7026061/
ZSH_THEME="cloud"
plugins=(git colorize colored-man-pages emoji rustup sudo zsh-syntax-highlighting zsh-autosuggestions zsh-completions)
autoload -U compinit && compinit
export PATH=$HOME/.local/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$HOME/.emacs.d/bin:$PATH
export PATH=$HOME/Desktop:$PATH
export PATH=/home/horhik/code/projects/potato-notify:$PATH
export PATH="/root/.deno/bin:$PATH"
alias vim=nvim
alias vi=vim
alias libvirtdaemon="sudo start-stop-daemon --start libvirtd"
alias virtm="sudo start-stop-daemon --start virtlogd &; sudo start-stop-daemon --start libvirtd &; virt-manager &" 
alias clip=xclip -selection clipboard
alias suspend="loginctl suspend"
if [ -f '/home/horhik/yandex-cloud/path.bash.inc' ]; then source '/home/horhik/yandex-cloud/path.bash.inc'; fi
if [ -f '/home/horhik/yandex-cloud/completion.zsh.inc' ]; then source '/home/horhik/yandex-cloud/completion.zsh.inc'; fi
alias rd='rustc -g --emit="obj,link"'

compile_and_run() {
     rustc -g --emit="obj,link" $1 && gdb ${1%.*}
}

alias rdr=compile_and_run
alias aia=ankiaudio
alias picom="killall picom; picom --experimental-backends &;"
alias cc="cargo check"
alias ct="cargo test"
alias gc="git clone"
alias gs="git status"
alias vim="nvim"

neofetch

eval $(thefuck --alias)
