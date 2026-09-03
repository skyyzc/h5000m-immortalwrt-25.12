# Hiveton H5000M · ImmortalWrt 25.12

本项目为 Hiveton H5000M 5G CPE 的 ImmortalWrt 25.12 适配工程。目标是在保留厂家 HigoROS 管理界面、RG520N-CN 5G 模块和原有路由能力的前提下，将底层从 ImmortalWrt 24.10 升级到 25.12。

> 当前仅提供 U-Boot 内存启动（initramfs）测试镜像，尚未发布可安全写入 eMMC 的正式镜像。请勿把 initramfs 直接写入 kernel/rootfs 分区。

## 访问方式

- HigoROS：`http://192.168.88.1/`
- 原生 LuCI：`http://192.168.88.1:8080/`
- SSH：`root@192.168.88.1`
- 测试密码：`admin`（正式使用前必须修改）

## 已确认的设备信息

| 项目 | 信息 | 状态 |
| --- | --- | --- |
| 设备/SoC | Hiveton H5000M / MediaTek MT7987 | 实机确认 |
| 存储 | eMMC | 实机确认 |
| 5G 模块 | Quectel RG520N-CN，USB ID `2c7c:0801` | 实机确认 |
| 5G 数据接口 | QMAP，运行接口 `wwan0_1` | 实机确认 |
| 无线 | 2.4 GHz + 5 GHz，mt76/mt7992 系列 | 实机确认 |
| Bootloader | U-Boot 2025.07.1，基于 `Yuzhii0718/bl-mt798x-dhcpd` | 实机确认 |
| 原厂系统 | ImmortalWrt 24.10-SNAPSHOT，Linux 6.6.94 | 实机确认 |
| 目标系统 | ImmortalWrt `openwrt-25.12`，已测试 Linux 6.12.103 | RAM 实测 |

eMMC 已确认包含 U-Boot 环境、factory、FIP、kernel 和 rootfs 分区。原厂 `factory` 分区实机读取为全零；原厂无线驱动同样回退到默认 `MT7992_EEPROM.bin`，因此 mt76 的 EEPROM 回退日志不是本项目造成的数据丢失。

## 项目思路

1. 保留厂商 HigoROS 前端和静态链接后端，不修改其闭源业务逻辑。
2. 使用 ImmortalWrt 25.12、Linux 6.12 和开源 mt76 重建系统、网络与无线层。
3. 为 RG520N-CN 固定 QMAP 设备路径，避免 QModem 反复扫描不存在的设备。
4. 修补重拨流程并保留 `USB`/`USBv6` 配置，避免 5G 重拨触发 LAN、Wi-Fi、LuCI、HigoROS 和 SSH 全部重启。
5. 依据原厂包清单和 HigoROS 功能探测逐项恢复插件；内核模块必须针对 Linux 6.12 重编译，不能复制 24.10 的 `.ko`。
6. eMMC 写入延后到 RAM 镜像稳定验证之后，并保留 U-Boot 回退路径与原厂备份。

## HigoROS 功能保留矩阵

“已保留”表示完成 25.12 RAM 实测；“待验证”表示已有可行实现或已纳入增强构建；“未保留”表示存在明确兼容障碍。

| HigoROS 功能 | 25.12 状态 | 依赖/原因 | 优化方向 |
| --- | --- | --- | --- |
| 连接、邻区、锁频、AT、短信、SIM、流量和 5G 设置 | 已保留 | HigoROS、QModem、RG520N-CN | 持续验证掉线恢复 |
| WAN、LAN/DHCP、IPv6、路由、转发、DMZ、拓扑、诊断 | 已保留 | netifd、firewall4、odhcp6c | 双栈长稳测试 |
| HigoROS `:80` + LuCI `:8080` | 已保留 | 双管理入口 | 固化升级迁移策略 |
| 双频 Wi-Fi | 已保留 | mt76/mac80211 | 吞吐、漫游和高温压力测试 |
| 设备列表、黑名单、流量排行 | 部分保留/待修复 | DHCP/邻居表可用；统计依赖 `wrtbwmon` | 25.12 feed 已移除该包；移植兼容版或接入 nlbwmon |
| UPnP | 待验证 | `miniupnpd-nftables` | 已纳入增强构建 |
| DDNS | 待验证 | `ddns-scripts` | 已纳入增强构建 |
| 防火墙、DoS、IP/URL 过滤 | 基本保留 | firewall4/nftables、HigoROS | 逐类验证规则 |
| 应用过滤 | 待编译验证 | 原厂 `oaf.ko` 绑定 Linux 6.6 ABI | 用 OpenAppFilter 源码针对 6.12 重编译 |
| 固件、备份、日志、任务、信息、监控、终端、通知 | 基本保留 | HigoROS 和系统工具 | 逐页回归 |
| 风扇控制 | 待验证 | pwm-fan/hwmon | 已按原厂三条曲线重建 25.12 服务；实测 PWM/RPM |
| 磁盘管理 | 待验证 | block-mount、USB、EXT4/exFAT/NTFS3、DiskMan | 外置磁盘全流程测试 |
| 文件共享 | 待验证 | KSMBD | 测试 SMB2/SMB3 和权限 |
| ZeroTier | 待验证 | `zerotier` | 已纳入，默认不加入网络 |
| Watchcat | 待验证 | `watchcat` | 已纳入，避免默认激进重启 |

这些菜单并非 RAM 启动方式本质上无法实现。HigoROS 会按软件包、配置和服务状态动态显示菜单；早期 RAM 镜像采用精简包集合，因此隐藏了入口。

## 编译组件、版本与功能

滚动 feed 包的精确版本以每次成功构建产物中的 `*.manifest` 为准。README 记录源码通道、原厂参考版本和项目固定版本。

| 组件/插件 | 原厂参考版本 | 25.12 来源/版本 | 功能 |
| --- | --- | --- | --- |
| ImmortalWrt / Linux | 24.10 / 6.6.94 | `openwrt-25.12` / 6.12 系列 | 系统、网络和驱动 |
| HigoROS | — | `1.26.04.29.09-1` | 厂商界面与 API |
| QModem | — | main，当前 3.2 系列 | RG520N-CN 管理、AT、短信和拨号 |
| `kmod-qmi_wwan_q` | 原厂 Quectel 驱动 | 随当前内核编译 | QMAP 数据接口 |
| OpenAppFilter | `appfilter 6.1.8-r1` | 6.1.8 系列源码 | 应用识别与终端访问控制 |
| H5000M fancontrol | `1-r3` | 本项目 `2.0-1` | 静音/均衡/性能温控曲线 |
| wrtbwmon | `1.2.1-r3` | `brvphoenix/wrtbwmon`，`1.2.1-r3` | Higo 设备流量数据源；通过 iptables-nft 兼容层运行 |
| DiskMan | `0.2.13-r1` | 25.12 feed | 分区、格式化和挂载 |
| KSMBD | `ksmbd-server 3.5.5-r1` | 25.12 feed/内核 | SMB2/SMB3 文件共享 |
| UPnP | `miniupnpd-nftables 2.3.9-r1` | 25.12 feed | 自动端口映射 |
| DDNS | `ddns-scripts 2.8.2-r65` | 25.12 feed | 动态 DNS 更新 |
| Watchcat | `1-r17` | 25.12 feed | 网络故障检测与恢复 |
| ZeroTier | `1.14.1-r14` | 25.12 feed | 虚拟组网 |
| block-mount/automount | 24.10 对应版本 | 25.12 feed | 外置存储探测与挂载 |
| EXT4/exFAT/NTFS3 | Linux 6.6.94 模块 | 针对 Linux 6.12 编译 | 移动存储文件系统 |

## 构建版本与测试重点

| Actions 版本 | 定位 | 测试内容 | 状态 |
| --- | --- | --- | --- |
| #9 | 无线恢复基线 | Higo/LuCI、双频无线、5G 双栈 | 成功并已实测 |
| #10 | QModem 稳定基线 | 固定 RG520N-CN、重拨不中断 LAN/Wi-Fi/SSH | 构建中；增强版回退对照 |
| #12 | 完整功能增强尝试 | OAF、风扇、存储、共享、UPnP、DDNS、Watchcat、ZeroTier、设备统计 | 配置校验停止：缺少 `wrtbwmon`，未产生镜像 |
| #13 | 完整功能增强修正版 | 为 25.12 外置引入 wrtbwmon 1.2.1-r3 及 LuCI 前端 | 待构建 |

后续优先测试最新完整功能增强版，并用 #10 做稳定性对照。报告问题时必须注明 Actions 运行编号，不能只写“最新固件”。

## 自动构建

工作流：`.github/workflows/build-h5000m-private.yml`

1. 从 `openwrt-25.12` 分支检出源码。
2. 加载 H5000M 覆盖层、HigoROS、QModem 和外部开源插件。
3. 执行 `make defconfig` 并检查必需包；缺少关键组件时立即失败。
4. 编译 initramfs，上传镜像、校验和、manifest 和 buildinfo。

本地完整首次构建建议至少 80–120 GB 空间、8 GB 内存。GitHub Actions 每次运行使用独立虚拟机，并行任务不会覆盖彼此产物。

## 更新记录

### 2026-09-03

- 明确 #10 为 QModem 稳定基线、#12 为完整功能增强尝试。
- 根据原厂包清单梳理 HigoROS 菜单与插件依赖。
- 增加 OpenAppFilter Linux 6.12 源码编译方案。
- 增加 H5000M 风扇控制重建实现和原厂三种温控曲线。
- 将 DiskMan、KSMBD、UPnP、DDNS、Watchcat、ZeroTier 和常用 USB 文件系统加入增强构建。
- #12 发现 25.12 feed 不提供 `wrtbwmon`；下一步移植兼容包或为 HigoROS 接入 nlbwmon。
- 准备 #13：从维护中的独立源码引入 `wrtbwmon 1.2.1-r3` 和 `luci-app-wrtbwmon 2.0.13`，保留构建期必需包校验。
- 重写 README，增加设备信息、项目思路、功能矩阵、插件版本和测试约定。

### 已完成的早期优化

- 管理网段改为原厂 `192.168.88.0/24`。
- 恢复原厂双频 SSID、信道和带宽默认值。
- 固定 RG520N-CN USB/QMAP 配置并关闭无意义的通用探测。
- 优化 QModem 重拨，避免全网络重启。
- 确认 factory 分区为空并记录无线 EEPROM 回退行为。

## README 更新规则

每个影响固件行为、依赖、默认配置或测试结论的提交，都应同步更新：

1. HigoROS 功能保留矩阵的状态与原因；
2. 组件版本或成功构建 manifest；
3. Actions 运行编号和测试重点；
4. 更新记录中的新增、修复、回退和已知问题。

仅排版、注释等不影响固件的修改可不新增版本条目。

## 风险与限制

- HigoROS 为厂商闭源组件，本项目只封装设备已有文件，不声称拥有其版权。
- 24.10 预编译内核模块不能加载到 Linux 6.12，必须重编译或替换。
- wrtbwmon 使用旧式流量规则，可能与 nftables、flow offloading 和代理插件冲突。
- 风扇策略完成 PWM、RPM 和高负载温度测试前属于实验功能。
- 当前镜像只用于 RAM 启动验证。

## 上游与致谢

- [ImmortalWrt](https://github.com/immortalwrt/immortalwrt)
- [H5000M U-Boot / bl-mt798x-dhcpd](https://github.com/Yuzhii0718/bl-mt798x-dhcpd)
- [QModem](https://github.com/FUjr/QModem)
- [OpenAppFilter](https://github.com/destan19/OpenAppFilter)
- [OpenWrt](https://openwrt.org/)

ImmortalWrt/OpenWrt 代码遵循各自许可证。本项目新增脚本采用 GPL-2.0-only；厂商二进制及界面资源仍受原权利人许可约束。
