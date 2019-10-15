# fcitx の起動
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export DefaultIMModule=fcitx
fcitx &

# SPDIF出力を有効に
amixer -c 0 cset name='IC958 Default PCM' on

# マウスカーソルを1秒動かなければ隠す
unclutter --timeout 1 &

# Here awesome is kept as default
session=${1:-awesome}

# 多ボタンマウスを機能させる
easystroke enable &

# Keyboard のリピート開始及び速度を変更
xset r rate 200 30

exec awesome
