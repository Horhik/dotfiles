{config, pkgs, ...}:
 {
  enable = true;
  clock24 = true;
  home.packages =  [pkgs.tmuxPlugins.gruvbox ];
  extraTmuxConf = '' 
    set -g @plugin 'egel/tmux-gruvbox'
    set -g @tmux-gruvbox 'dark' # or 'light'
    # List of plugins
    set -g @plugin 'tmux-plugins/tpm'
    set -g @plugin 'tmux-plugins/tmux-sensible'
    set -g mouse on

    set -g history-limit 500000

    setw -g monitor-activity on
    set -g visual-activity on

    set -g status-justify centre
    #run '~/.config/tmux/plugins/tpm/tpm'


    # Activity monitoring
    set-option -g prefix C-space
    setw -g monitor-activity on
    set -g visual-activity on

    # Vi copypaste mode
    set-window-option -g mode-keys vi
    bind-key -T copy-mode-vi v send-keys -X begin-selection
    bind-key -T copy-mode-vi y send-keys -X copy-selection
    # enable by r + v
    bind-key -T copy-mode-vi r send-keys -X rectangle-toggle

    # word seperators for automatic word selection
    setw -g word-separators ' '

    # hjkl pane traversal
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R

    # HJKL resize pane
    bind -r K resize-pane -U
    bind -r J resize-pane -D
    bind -r H resize-pane -L
    bind -r L resize-pane -R
  '';
}
