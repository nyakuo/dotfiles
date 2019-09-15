# tmux の自動起動
if test -z $TMUX
#  if test $TERM_PROGRAM != "vscode"
  tmux new-session
#  end
end

# MacVim のための設定
if test -f /Applications/MacVim.app/Contents/MacOS/Vim
  alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim '
  alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim '
  alias mvim='/Applications/MacVim.app/Contents/bin/mvim'
  alias macvim='mvim'
end

alias vi='vim'

# alias の設定
alias up='cd ..'
alias upup='up;up'
alias tree='tree -N' # 文字化けtaisaku
alias l='ls' # typo 対策
alias gd='git diff --color-words'

# ls の着色
alias ls='ls -G'
alias sl='ls'
export LSCOLORS=xbfxcxdxbxegedabagacad

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/bin/google-cloud-sdk/path.fish.inc' ]; . '/usr/local/bin/google-cloud-sdk/path.fish.inc'; end

# Go のバイナリの PATH を追加
set PATH ~/go/bin $PATH

# --- git のブランチ名を表示
# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles '☡'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'
