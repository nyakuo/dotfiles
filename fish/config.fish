# tmux の自動起動
if test -z $TMUX
  tmux new-session
end

# alias の設定
alias up='cd ..'
alias upup='up;up'
alias tree='tree -N' # 文字化け対策
alias gd='git diff --color-words'
alias l='ls' # typo 対策
alias sl='ls'
alias pbcopy='xsel --clipboard --input'

# ls の着色
alias ls='ls --color=auto'

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

# --- Mac 固有の設定
if test (uname) = Darwin
  # MacVim のための設定
  if test -f /Applications/MacVim.app/Contents/MacOS/Vim
    alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim '
    alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim '
    alias mvim='/Applications/MacVim.app/Contents/bin/mvim'
    alias macvim='mvim'
  end
end

# --- Linux 固有の設定
if uname -a | grep 'Linux' > /dev/null
  # ctrl caps の入れ替え
  setxkbmap -option ctrl:swapcaps

  # 多ボタンマウスを機能させる
  easystroke enable

  # start X at login
  if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
      exec startx -- -keeptty
    end
  end
end
