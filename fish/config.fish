# tmux の自動起動
if test -z $TMUX
  tmux new-session
end

# fish のログインメッセージを空文字に
set fish_greeting

# alias の設定
alias up='cd ..'
alias upup='up;up'
alias tree='tree -N' # 文字化け対策
alias gd='git diff --color-words'
alias ls='ls -1'
alias l='ls' # typo 対策
alias sl='ls'
alias k='kubectl'
alias g='git'
alias pip='pip3'
alias vim='nvim'
alias typora="open -a typora"

source ~/.config/fish/extra_settings

set LANG ja_JP.UTF-8
set LC_CTYPE ja_JP.UTF-8

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/bin/google-cloud-sdk/path.fish.inc' ]; . '/usr/local/bin/google-cloud-sdk/path.fish.inc'; end

# Go のバイナリの PATH を追加
set PATH ~/go/bin $PATH

# Homebrew の PATH を追加
set PATH /opt/homebrew/bin $PATH

# pyenv の設定
set PYENV_ROOT $HOME/.pyenv
set PATH $PYENV_ROOT/bin $PATH
eval (pyenv init - | source)

# --- Mac 固有の設定
if test (uname) = Darwin
  # MacVim のための設定
  if test -f /Applications/MacVim.app/Contents/bin/mvim
    alias mvim='/Applications/MacVim.app/Contents/bin/mvim'
    alias macvim='mvim'
  end

  # ls の着色
  alias ls='ls -G'

  # Verilator の Include PATH を追加
  set PATH /usr/local/Cellar/verilator/4.020/share/verilator/include/  $PATH
end

# --- Linux 固有の設定
if uname -a | grep 'Linux' > /dev/null
  # pbcopy の定義
  alias pbcopy='xsel --clipboard --input'
  # pbpaste の定義
  alias pbpaste='xclip -selection clipboard -o'

  # ctrl caps の入れ替え
  setxkbmap -option ctrl:swapcaps

  # start X at login
  if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
      exec startx -- -keeptty
    end
  end

  # ls の着色
  alias ls='ls --color=auto'
end

# peco: history の検索プラグインのキー設定
function fish_user_key_bindings
  bind \cr peco_select_history
end

# powerine font で git branch 名を表示する
set -g theme_display_git_master_branch yes

#ディレクトリ名を省略しない
set -g fish_prompt_pwd_dir_length 0
