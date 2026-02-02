#!/bin/bash
#
# DIY Part 2: 在 make menuconfig 之前执行
# 用于自定义固件设置

echo "=========================================="
echo "DIY Part 2: 自定义固件设置"
echo "=========================================="

# 修改默认 IP 地址
echo "设置默认 IP 为 192.168.1.1..."
sed -i 's/192.168.1.1/192.168.1.1/g' package/base-files/files/bin/config_generate

# 修改默认主机名
echo "设置主机名为 JDCloud..."
sed -i 's/ImmortalWrt/JDCloud/g' package/base-files/files/bin/config_generate

# 修改默认时区为上海
echo "设置时区为 Asia/Shanghai..."
sed -i "s/'UTC'/'CST-8'/g" package/base-files/files/bin/config_generate
sed -i "s/UTC/Asia\/Shanghai/g" package/base-files/files/bin/config_generate

# 设置默认主题为 Argon
echo "设置默认主题为 Argon..."
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile 2>/dev/null || true

# 修改 overlay 分区大小为 1GB (1024MB)
echo "设置 overlay 分区大小为 1GB..."
sed -i 's/CONFIG_TARGET_ROOTFS_PARTSIZE=.*/CONFIG_TARGET_ROOTFS_PARTSIZE=1024/' .config 2>/dev/null || true

echo "DIY Part 2 完成!"
