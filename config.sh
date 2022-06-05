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

# 判断是否已经安装了vim，如未安装则安装vim
if [ -z $(which vim) ]; then
	printInfo "vim未安装，先安装vim"
	yum install -y vim || apt-get install vim || apk --no-cache add -f bash curl vim || pacman -S --noconfirm vim
	if [ -z $(which vim) ]; then
		printInfo "vim安装失败，请手动安装vim"
		exit 1
	else
		printInfo "vim安装成功"
	fi
else
	printInfo "vim已安装"
fi

if [ -d $TARGET_DIR ]; then
	printInfo "检测到已存在目录，将备份原有配置至 $TARGET_DIR.bak"
	mv $TARGET_DIR $TARGET_DIR.bak
	printInfo "备份完成"
else
	printInfo "未检测到已存在目录"
fi

printInfo "开始克隆.vim"
git clone $GITHUB_PROXY/$GITHUB_URL $TARGET_DIR
printInfo "克隆.vim success"

ln -sf $TARGET_DIR/.vimrc $HOME/.vimrc
printInfo "Config .vimrc success"
