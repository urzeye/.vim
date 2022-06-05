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

# 判断是否为Alpine系统
if [ -e /etc/alpine-release ]; then
	printInfo "检测到当前系统为Alpine系统，换源中..."
	sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
	printInfo "换源完成"
fi

# 判断是否已经安装了vim，如未安装则安装vim
if [ -z $(which vim) ]; then
	printInfo "vim未安装，先安装vim"
	yum install -y vim && yum clean all ||
		apk --no-cache add -f curl vim && rm -rf /var/cache/apk/* ||
		apt-get install vim && rm -rf /var/cache/apt/archive/* ||
		pacman -S --noconfirm vim
	if [ -z $(which vim) ]; then
		printInfo "vim安装失败，请手动安装vim"
		exit 1
	else
		printInfo "vim安装成功"
	fi
else
	printInfo "vim已安装"
fi

# 判断是否已经安装了git
if [ -z $(which git) ]; then
	printInfo "git未安装，先安装git"
	yum install -y git && yum clean all ||
		apk --no-cache add -f git && rm -rf /var/cache/apk/* ||
		apt-get install git && rm -rf /var/cache/apt/archive/* ||
		pacman -S --noconfirm git
	if [ -z $(which git) ]; then
		printInfo "git安装失败，请手动安装git"
		exit 1
	else
		printInfo "git安装成功"
	fi
else
	printInfo "git已安装"
fi

# 备份原配置文件
if [ -d $TARGET_DIR ]; then
	printInfo "检测到已存在目录，将备份原有配置至 $TARGET_DIR.bak"
	mv $TARGET_DIR $TARGET_DIR.bak
	printInfo "备份完成"
else
	printInfo "未检测到已存在目录，跳过备份"
fi

printInfo "开始克隆.vim"
git clone $GITHUB_PROXY/$GITHUB_URL $TARGET_DIR
printInfo "克隆.vim success"

ln -sf $TARGET_DIR/.vimrc $HOME/.vimrc
printInfo "Config .vimrc success"
