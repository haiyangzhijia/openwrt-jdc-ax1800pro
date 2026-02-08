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

# Clear root password (ensure empty password)
echo "Clearing root password..."
sed -i 's/root:.*/root:::0:99999:7:::/g' package/base-files/files/etc/shadow

# Try to enable factory image generation
echo "Enabling factory image for jdcloud_re-ss-01..."
grep -r "jdcloud_re-ss-01" target/linux/qualcommax/image/ 2>/dev/null | cut -d: -f1 | sort | uniq | while read file; do
    sed -i '/jdcloud_re-ss-01/,/IMAGES/ s/sysupgrade.bin/sysupgrade.bin factory.bin/' "$file"
done

# Modify overlay partition size (1GB)
echo "Setting overlay partition size to 1GB..."
sed -i 's/CONFIG_TARGET_ROOTFS_PARTSIZE=.*/CONFIG_TARGET_ROOTFS_PARTSIZE=1024/' .config 2>/dev/null || true

# Fix fail2ban build error (Cannot import setuptools.build_meta)
# Ensure host python dependencies are available
echo "Fixing fail2ban build dependencies..."
if [ -f feeds/packages/net/fail2ban/Makefile ]; then
    # Add host python dependencies
    if grep -q "PKG_BUILD_DEPENDS" feeds/packages/net/fail2ban/Makefile; then
        sed -i 's/PKG_BUILD_DEPENDS:=/PKG_BUILD_DEPENDS:=python3\/host python-setuptools\/host python-wheel\/host /' feeds/packages/net/fail2ban/Makefile
    else
        sed -i '/include $(TOPDIR)\/rules.mk/a PKG_BUILD_DEPENDS:=python3/host python-setuptools/host python-wheel/host' feeds/packages/net/fail2ban/Makefile
    fi
    # Force use of pip install instead of setup.py if needed, or ensure build backend is present
fi

echo "DIY Part 2: Done"
