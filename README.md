# Hiveton H5000M · ImmortalWrt 25.12

本项目为 Hiveton H5000M 5G CPE 适配 ImmortalWrt 25.12，并尽可能完整保留厂家 Higo 界面、Quectel RG520N-CN 5G 模块及常规路由功能。

当前固件仅用于 U-Boot 内存启动测试。eMMC 持久化安装、sysupgrade 与回滚尚未验证。

## 设备与访问入口

- 设备/SoC：Hiveton H5000M / MediaTek MT7987A
- 内存/存储：实机约 988 MiB RAM / 7.28 GiB eMMC
- 5G：Quectel RG520N-CN，USB `2c7c:0801`，QMAP `wwan0_1`
- 网口：`eth0` LAN、`eth1` WAN
- Wi-Fi：MT7992 双频 2.4/5 GHz
- Higo：`http://192.168.88.1/`
- LuCI：`http://192.168.88.1:8080/`
- SSH：`root@192.168.88.1`（RAM 测试密码 `admin`）

接入不可信网络前必须修改测试密码。

## 当前源码基线

- 项目分支：`master`
- Phase 1 前基线：`2898f03021187cddc9ed7ae4ccb2cffa255f6345`
- Workflow 构建分支：`openwrt-25.12`
- 当前构建分支 SHA：`cfd4f9545c7c893525b23ab3577252d5b9902399`
- 源码内核线：Linux 6.12
- 最近实测内核：Linux 6.12.103

Workflow 当前按分支名选择 `openwrt-25.12`，标准 feeds 也跟随各自上游分支；在 Phase 2 建立候选版本锁定/提升记录前，二者均存在漂移风险。

## 技术路线

1. 将闭源 Higo 前后端作为兼容组件保留，不改变其权属。
2. 基于 ImmortalWrt 25.12/Linux 6.12 重建系统、网络、mt76 Wi-Fi 与内核模块。
3. 保留 RG520N-CN USB/QMAP 固定路径，避免 5G 恢复操作连带重启 LAN、Wi-Fi 和管理服务。
4. 由一个手动 matrix workflow 生成 `rescue` 与 `full` 两个 initramfs profile。
5. 上游更新遵循 `candidate -> build -> RAM test -> manual promote`。
6. GPT、U-Boot、sysupgrade 与 eMMC 持久化写入延后至明确批准且救援路径验证后。

## rescue / full

| Profile | 定位 | 内容 | 当前证据 |
| --- | --- | --- | --- |
| `rescue` | 精简救援/稳定基线 | Higo、LuCI、网络、Wi-Fi、QModem、RG520N-CN 核心能力 | Actions #10 RAM 产物达到 `FUNCTION_TESTED`；后续统一构建产物状态 `UNKNOWN` |
| `full` | 完整功能测试 | rescue 加 OAF、流量统计、风扇、存储、SMB、UPnP、DDNS、Watchcat、ZeroTier | 最新 RAM 镜像仅部分功能达到 `FUNCTION_TESTED`；确切 run/artifact `UNKNOWN` |

`BUILT` 只代表产物生成，不代表设备成功启动或功能通过真机测试。

## Higo 功能兼容状态

| 功能 | 当前状态 | 证据/限制 | 优化方向 |
| --- | --- | --- | --- |
| 首页、状态、双管理入口 | `UI_OK` | RAM 固件可打开 Higo `:80` 与 LuCI `:8080` | 持续回归 |
| 5G、AT、短信、SIM、锁频 | `UI_OK`；核心拨号 `FUNCTION_TESTED` | RG520N-CN 首次拨号、IPv4/IPv6 已通过；长时重连未测 | 长稳与重连测试 |
| WAN/LAN/DHCP/IPv6/路由/防火墙 | 核心路径 `FUNCTION_TESTED`，部分页面 `UI_OK` | RAM 测试基本路由正常 | 逐页和双栈长稳测试 |
| Wi-Fi | 基础双频 `FUNCTION_TESTED` | 吞吐、漫游、高温压力未测 | 性能与压力测试 |
| 设备列表/黑名单/流量排行 | 后端 `RUNNING`，Higo 展示不完整 | wrtbwmon 有数据，Higo API 返回空列表 | 增加窄范围 wrtbwmon→Higo 适配层 |
| 应用过滤 | OAF `RUNNING`，功能未验证 | Higo 期待旧控制接口 | 验证兼容层和真实阻断 |
| 风扇 | PWM `FUNCTION_TESTED` | RPM 路径、高负载曲线未验证 | 传感器和温控测试 |
| 磁盘管理 | `INSTALLED`，API 可见 | 未执行写操作；禁止用内置 eMMC 试验 | 仅用可牺牲外置盘测试 |
| 文件共享/KSMBD | 服务 `RUNNING` | 共享、认证、权限未验证 | 外置盘 SMB2/SMB3 测试 |
| UPnP/DDNS/ZeroTier | `INSTALLED`，部分 API/服务可见 | 端到端功能未测或默认禁用 | 受控功能测试 |
| Watchcat | `RUNNING` | 故障恢复及误重启未验证 | 受控断网测试 |
| 升级/备份恢复 | 页面可能存在，功能未验证 | 属于高风险持久化路径 | 单独批准的救援/升级阶段 |

Higo 功能不得被静默删除。任何兼容退化都必须在本表和 `CHANGELOG.md` 记录原因与恢复方向。

## 当前主要插件

下表版本来自当前配置或最近检查过的 full RAM 镜像。设备上存在某版本不等于完整功能已通过。

| 组件 | 来源/版本 | 固定状态 | 作用 | 当前证据 |
| --- | --- | --- | --- | --- |
| Higo | 厂商 overlay `1.26.04.29.09-r1` | 本地构建输入，闭源 | 厂商 UI/API | 主入口及部分页面 `UI_OK` |
| QModem | FUjr/QModem `3.2.0-r1`，`c1db0fe2067955d6b9c6b43efff1b69259f4b096` | 固定 SHA | 5G 管理、AT、短信、拨号 | `RUNNING`；首次拨号 `FUNCTION_TESTED` |
| `kmod-qmi_wwan_q` | 随目标内核编译 | 内核耦合 | Quectel QMAP 接口 | 最近 RAM 镜像 `FUNCTION_TESTED` |
| OpenAppFilter | 实测 `7.0.1-r1` | 上游 clone 未固定 | 应用识别/过滤 | `RUNNING`；阻断未验证 |
| wrtbwmon | 实测 `1.2.1-r3` | 上游 clone 未固定 | 终端流量数据 | `RUNNING`；Higo 接入不完整 |
| fancontrol | 本项目 `2.0-r1` | 本地实现 | PWM 温控曲线 | PWM `FUNCTION_TESTED` |
| DiskMan | 实测 `0.2.13-r1` | feed 跟随上游 | 分区/挂载界面 | `INSTALLED`；写操作未测 |
| KSMBD | 实测 `3.5.6-r1` | feed 跟随上游 | SMB2/SMB3 文件共享 | `RUNNING`；共享未测 |
| UPnP | 实测 `2.3.9-r1` | feed 跟随上游 | 自动端口映射 | `INSTALLED`；映射未测 |
| DDNS | 实测 `2.8.3-r5` | feed 跟随上游 | 动态 DNS | `INSTALLED`；更新未测 |
| Watchcat | 实测 `1-r25` | feed 跟随上游 | 联网故障恢复 | `RUNNING`；恢复未测 |
| ZeroTier | 实测 `1.16.0-r2` | feed 跟随上游 | 虚拟组网 | `INSTALLED`；连通未测 |

每次构建的精确包版本必须以该产物 manifest 为准。当前 OpenAppFilter、wrtbwmon 与标准 feed SHA 尚未完全可复现。

## 验证摘要

已在 RAM 固件验证：

- 启动及 `192.168.88.1` 管理网段
- Higo 与 LuCI 入口
- 基础 LAN/WAN、双频 Wi-Fi
- RG520N-CN USB 枚举、QMAP、首次拨号、IPv4/IPv6
- 风扇动态 PWM

部分验证或仅观察到安装/运行：

- QModem 重连/扫描兼容
- OAF 进程与数据库、wrtbwmon 数据
- DiskMan、KSMBD、UPnP、DDNS、Watchcat、ZeroTier 包/API/服务

尚未验证：

- 5G 长时重连
- Higo 设备列表转换、应用过滤 UI 与实际阻断
- 外置盘格式化/挂载、SMB 认证权限
- 持久化升级、备份恢复与回滚

当前简明状态见 [PROJECT_STATE.md](PROJECT_STATE.md)，时间顺序变更见 [CHANGELOG.md](CHANGELOG.md)。

## 构建方式

唯一 active workflow 为 `.github/workflows/build-h5000m-private.yml`，仅支持手动 `workflow_dispatch`。可选择 `rescue`、`full` 或 `both`；`both` 通过 matrix 分别上传两个产物。

流程会检出 `openwrt-25.12`、加载 QModem 与 full profile 插件、应用 H5000M/Higo overlay、执行配置校验和编译，并上传镜像、校验和、manifest 与 buildinfo。

本地首次完整构建通常建议预留 80–120 GB 空间及至少 8 GB 内存。纯文档治理变更不应触发固件构建。

## 已知问题与风险

- 构建分支及标准 feeds 未由单一 promotion lock 固定，存在漂移。
- OpenAppFilter 与 wrtbwmon clone 未固定 commit。
- Higo 设备列表与应用过滤兼容尚未完成。
- QModem 扫描抑制仅部分验证。
- 禁止使用内置 eMMC 做 DiskMan 探索性写操作。
- GPT 存在 alternate-LBA/布局风险，只能在单独批准的持久化阶段处理。
- initramfs 不得直接写入 kernel/rootfs 分区。
- 厂商 Higo 二进制和资源仍受原权利人许可约束。

## 当前开发阶段

Phase 1 仅建立项目治理、状态入口、文档门禁和唯一工作树。固件功能调整留待批准 Phase 2；硬件及持久化写入必须另行批准。

## 上游项目

- [ImmortalWrt](https://github.com/immortalwrt/immortalwrt)
- [H5000M U-Boot](https://github.com/Yuzhii0718/bl-mt798x-dhcpd)
- [QModem](https://github.com/FUjr/QModem)
- [OpenAppFilter](https://github.com/destan19/OpenAppFilter)
- [wrtbwmon](https://github.com/brvphoenix/wrtbwmon)
