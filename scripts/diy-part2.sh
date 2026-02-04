#!/bin/bash
# DIY Part 2: Execute befor make menuconfig

echo "DIY Part 2: Custom settings"

# Modify default IP
echo "Setting default IP to 192.168.1.1..."
sed -i 's/192.168.1.1/192.168.1.1/g' package/base-files/files/bin/config_generate

# Modify default hostname
echo "Setting hostname to JDCloud..."
sed -i 's/ImmortalWrt/JDCloud/g' package/base-files/files/bin/config_generate

# Modify default timezone
echo "Setting timezone to Asia/Shanghai..."
sed -i "s/'UTC'/'CST-8'/g" package/base-files/files/bin/config_generate
sed -i "s/UTC/Asia\/Shanghai/g" package/base-files/files/bin/config_generate

# Modify default theme
echo "Setting default theme to Argon..."
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile 2>/dev/null || true

# Modify overlay partition size (1GB)
echo "Setting overlay partition size to 1GB..."
sed -i 's/CONFIG_TARGET_ROOTFS_PARTSIZE=.*/CONFIG_TARGET_ROOTFS_PARTSIZE=1024/' .config 2>/dev/null || true

echo "DIY Part 2: Done"
