# .vim-config
个人自用vim配置

> 依赖于curl、git，bash可用sh替代

```bash
export GITHUB_PROXY=https://ghproxy.com &&
  sh <(curl -fsSL $GITHUB_PROXY/https://raw.githubusercontent.com/urzeye/.vim/main/config.sh ||
  wget $GITHUB_PROXY/https://raw.githubusercontent.com/urzeye/.vim/main/config.sh -O -)
```
