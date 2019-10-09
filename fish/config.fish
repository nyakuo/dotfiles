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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/bin/google-cloud-sdk/path.fish.inc' ]; . '/usr/local/bin/google-cloud-sdk/path.fish.inc'; end

# Go のバイナリの PATH を追加
set PATH ~/go/bin $PATH

# --- Mac 固有の設定
if test (uname) = Darwin
  # MacVim のための設定
  if test -f /Applications/MacVim.app/Contents/MacOS/Vim
    alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim '
    alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim '
    alias mvim='/Applications/MacVim.app/Contents/bin/mvim'
    alias macvim='mvim'
  end

  # ls の着色
  alias ls='ls -G'
end

# --- Linux 固有の設定
if uname -a | grep 'Linux' > /dev/null
  # pbcopy の定義
  alias pbcopy='xsel --clipboard --input'

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

  # ls の着色
  alias ls='ls --color=auto'
end
