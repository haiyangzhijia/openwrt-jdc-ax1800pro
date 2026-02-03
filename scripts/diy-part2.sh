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

# ==================== 修复 Rust LLVM 下载问题 ====================
# Rust CI 的 LLVM 预编译包可能已过期(404)，需要禁用 download-ci-llvm
echo "配置 Rust 从源码编译 LLVM (修复 CI 下载 404 问题)..."
RUST_PKG_DIR="feeds/packages/lang/rust"
if [ -d "$RUST_PKG_DIR" ]; then
    # 在 Rust 包的 Makefile 中添加禁用 download-ci-llvm 的配置
    if [ -f "$RUST_PKG_DIR/Makefile" ]; then
        # 检查是否已经添加过
        if ! grep -q "RUST_CONFIGURE_ARGS.*download-ci-llvm" "$RUST_PKG_DIR/Makefile"; then
            echo "修改 Rust Makefile 禁用 download-ci-llvm..."
            sed -i '/RUST_CONFIGURE_ARGS/s/$/ --set llvm.download-ci-llvm=false/' "$RUST_PKG_DIR/Makefile" 2>/dev/null || true
        fi
    fi
    
    # 创建 bootstrap.toml 配置
    mkdir -p "$RUST_PKG_DIR/files"
    cat > "$RUST_PKG_DIR/files/bootstrap.toml" << 'EOF'
[llvm]
download-ci-llvm = false
EOF
    echo "已创建 Rust bootstrap.toml 配置"
fi

echo "DIY Part 2 完成!"
