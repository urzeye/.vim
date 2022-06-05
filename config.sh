#!/bin/bash
#
# vim一键配置脚本

set -e

TARGET_DIR=$HOME/.vim
GITHUB_PROXY=https://ghproxy.com
GITHUB_URL=https://github.com/urzeye/.vim.git

# 获取当前时间
function getCurrentTime {
	echo $(date "+%Y-%m-%d %H:%M:%S.%N" | cut -b 1-23)
}

function printInfo {
	echo -e "\033[32m[$(getCurrentTime)] : $1\033[0m"
}

rm -rf $TARGET_DIR
printInfo "删除.vim目录 success"

printInfo "开始克隆.vim"
git clone $GITHUB_PROXY/$GITHUB_URL $TARGET_DIR
printInfo "克隆.vim success"

ln -sf $TARGET_DIR/.vimrc $HOME/.vimrc
printInfo "Config .vimrc success"
