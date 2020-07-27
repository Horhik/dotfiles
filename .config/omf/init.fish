
function fish_user_key_bindings
  fish_vi_key_bindings
end

#---startup---#
neofetch
ssh-add ~/.ssh/arch                                                                                                                                                                I


function __ssh_agent_start -d "start a new ssh agent"
  ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
  chmod 600 $SSH_ENV
  source $SSH_ENV > /dev/null
end

function __ssh_agent_is_started -d "check if ssh agent is already started"
	if begin; test -f $SSH_ENV; and test -z "$SSH_AGENT_PID"; end
		source $SSH_ENV > /dev/null
	end

	if test -z "$SSH_AGENT_PID"
		return 1
	end

	ssh-add -l > /dev/null 2>&1
	if test $status -eq 2
		return 1
	end
end


if test -z "$SSH_ENV"
    set -xg SSH_ENV $HOME/.ssh/environment
end

if not __ssh_agent_is_started
    __ssh_agent_start
end

# exec ssh-add ~/.ssh/arch

#---vim---#
alias vim nvim
alias vi "/bin/vim"

#---configs---#
alias i3cfg "vim ~/.config/i3/config"
alias pbcfg "vim ~/.config/polybar/config.ini"
alias compfg "vim ~/.config/compton/compton.conf"
alias alacfg "vim ~/.config/alacritty/alacritty.yml"
alias fishcfg "vim ~/.config/omf/init.fish"
alias fishf	"vim ~/.config/omf/init.fish"
alias vicfg "vim ~/.config/nvim/init.vim"
alias zshcfg "vim ~/.zshrc"
alias dev-ankilan "tmux at -t ankilan"
alias firefox firefox-developer-edition
alias vim1 "alacritty -e nvim"
alias gc "git clone"
alias gp "ssh-add ~/.ssh/arch; git push"
alias clj "clojure"

set TERMINAL st


set -U fish_cursor_normal block
set -U fish_cursor_insert line
set -U fish_cursor_replace_one underscore

function fish_user_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_default_key_bindings -M insert
    # Without an argument, fish_vi_key_bindings will default to
    # resetting all bindings.
    # The argument specifies the initial mode (insert, "default" or visual).
    fish_vi_key_bindings insert
end



function fish_mode_prompt
end

function fish_right_prompt -d "Write out the right prompt"
  switch $fish_bind_mode
    case default
      set_color --bold red
      echo 'N'
    case insert
      set_color --bold green
      echo 'I'
    case replace_one
      set_color --bold yellow
      echo 'R'
    case visual
      set_color --bold brmagenta
      echo 'V'
    case '*'
      set_color --bold red
      echo '?'
  end
  set_color normal
end



