#!/bin/bash
#
# DIY Part 1: 在 feeds update 之后执行
# 用于添加额外的软件源和修改 feeds

echo "=========================================="
echo "DIY Part 1: 配置第三方软件源"
echo "=========================================="

# 添加 Argon 主题
echo "添加 Argon 主题..."
rm -rf package/luci-theme-argon
git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

# 添加 Argon 主题配置插件
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config

echo "DIY Part 1 完成!"
