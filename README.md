# 京东云亚瑟 AX1800 Pro OpenWrt 固件

基于 ImmortalWrt 24.10 自动编译的定制固件。

## 📦 已包含功能

| 插件 | 功能 | 界面 |
|------|------|------|
| PassWall | 科学上网 | ✅ 中文 |
| udpxy | IPTV 组播转单播 | ✅ |
| Lucky 大吉 | DDNS/端口转发/反向代理 | ✅ 中文 |
| FM350-GL | 5G 模块支持 | ✅ 中文 |
| Argon 主题 | 美观界面 | ✅ |

## 🚀 如何编译

1. Fork 本仓库到你的 GitHub 账号
2. 进入 `Actions` 页面
3. 点击 `Build ImmortalWrt for JDCloud AX1800 Pro`
4. 点击 `Run workflow` 按钮
5. 等待 2-4 小时编译完成
6. 在 `Releases` 页面下载固件

## 📥 刷机说明

### 已刷 Uboot 的情况下：
1. 进入 Uboot 界面（通常是断电按住 reset 键，然后通电）
2. 访问 Uboot Web 界面（通常是 192.168.1.1）
3. 上传 `*-factory.bin` 固件
4. 等待刷写完成，自动重启

### 升级固件：
1. 进入 OpenWrt 后台 → 系统 → 备份/升级
2. 上传 `*-sysupgrade.bin` 固件
3. 勾选 "保留配置"（可选）
4. 点击升级

## ⚙️ 默认设置

- **IP 地址**: 192.168.1.1
- **用户名**: root
- **密码**: 无（首次登录请设置）
- **Overlay 分区**: 1GB

## ⚠️ 注意事项

### WiFi 性能优化
- 5GHz 发射功率建议设置为 20-23dBm
- 推荐信道: 149 或 157

### FM350-GL 5G 模块
- 建议使用 USB 模式（更稳定）
- 模块发热较大，请加装散热片

## 📁 项目结构

```
.
├── .github/workflows/    # GitHub Actions 工作流
├── configs/              # 设备配置文件
├── scripts/              # DIY 定制脚本
├── files/                # 自定义文件
└── README.md
```

## 🙏 致谢

- [ImmortalWrt](https://github.com/immortalwrt/immortalwrt)
- [PassWall](https://github.com/xiaorouji/openwrt-passwall)
- [Lucky](https://github.com/gdy666/luci-app-lucky)
- [Argon Theme](https://github.com/jerrykuku/luci-theme-argon)
