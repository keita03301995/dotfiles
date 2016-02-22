# 少し凝った zshrc
# License : MIT
# http://mollifier.mit-license.org/

########################################
# 環境変数
export LANG=ja_JP.UTF-8

# 色を使用出来るようにする
autoload -Uz colors
colors

# zwdエディタを使用
autoload zed

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default

# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


########################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

# ブランチの表示
zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'
# プロンプトの設定
function _update_vcs_info_msg() {
  LANG=en_US.UTF-8 vcs_info

  RPROMPT="%{$(echotc UP 2)${bg[blue]}%}%*%{$(echotc DO 2)${reset_color}%}"

  PROMPT="
${vcs_info_msg_0_}
%{${fg[cyan]}%}$ %~%{${reset_color}%} 
%(?.%{${fg[magenta]}%}.%{${fg[blue]}%})%(?![%n]$ ![%n]$ )%{${reset_color}%}"

	PROMPT2="${fg[magenta]}[%n]> ${reset_color}"

}
add-zsh-hook precmd _update_vcs_info_msg

########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
#
# beep を無効にする
setopt no_beep
#
# フローコントロールを無効にする
setopt no_flow_control
#
# Ctrl+Dでzshを終了しない
setopt ignore_eof
#
# '#' 以降をコメントとして扱う
setopt interactive_comments
#
# ディレクトリ名だけでcdする
setopt auto_cd
#
# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups
#
# 同時に起動したzshの間でヒストリを共有する
setopt share_history
#
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
#
# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space
#
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
#
# 高機能なワイルドカード展開を使用する
setopt extended_glob
#
# コマンド名の修正
setopt correct
# ヒストリの実行時間の保存
setopt extended_history
#
# タブ補完の表示を1ページに
setopt list_packed
#
# TABで補完候補を順に切り替え
setopt auto_menu
# 補完候補のカーソル選択
#
zstyle ':completion:*:default' menu select=1
#
########################################
# キーバインド
#
# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward
#
########################################
# エイリアス

alias la='ls -a'
alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

alias historyall="history 1"
# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# tmux起動時に自動で分割出来るように

if [ $SHLVL = 1 ]; then
  alias tmux="tmux attach || tmux new-session \; source-file ~/.tmux/new-session"
fi

# シェルの再起動

alias relogin='exec $SHELL -l'

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'
#
# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi
#
#
#
########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls -F --color=auto'
        ;;
esac
#
# vim:set ft=zsh:
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
