# ClashMac 开发工程

这是从已编译的 ClashMac.app 反编译重建的开发工程。

## 项目结构

```
ClashMac-Dev/
├── ClashMac/              # 主应用源代码
│   ├── Models/           # 数据模型
│   ├── Views/            # SwiftUI 视图
│   ├── Controllers/      # 控制器
│   ├── Store/            # 状态管理
│   ├── API/              # API 客户端
│   └── Utils/            # 工具类
├── ClashMacHelper/       # Helper 工具（需要单独编译）
├── Resources/            # 资源文件
│   ├── ui/              # Web UI 文件
│   ├── mihomo           # Clash 核心二进制
│   └── *.icns           # 图标文件
├── Scripts/              # 安装/卸载脚本
└── Package.swift         # Swift Package Manager 配置
```

## 功能模块

### 核心类

- **ClashMacApp**: 应用入口
- **ClashStore**: 状态管理（使用 ObservableObject）
- **ClashController**: Clash 进程控制
- **ClashAPIClient**: Clash API 客户端
- **ClashSSEClient**: Server-Sent Events 客户端

### 数据模型

- **ProxyMode**: 代理模式（规则/全局/直连）
- **ProxyNode**: 代理节点
- **ClashConfiguration**: Clash 配置

### 视图组件

- **ContentView**: 主视图
- **SystemProxyToggleView**: 系统代理开关
- **ProxyModeSwitcher**: 代理模式切换器
- **UserConfigPickerView**: 配置文件选择器

## 构建说明

### 使用 Xcode

1. 打开 Xcode
2. 选择 "File" -> "New" -> "Project"
3. 选择 "macOS" -> "App"
4. 将 `ClashMac` 目录中的文件添加到项目中
5. 配置 Bundle Identifier: `lv.llv.ClashMac`
6. 添加资源文件到项目

### 使用 Swift Package Manager

```bash
cd ClashMac-Dev
swift build
```

## 依赖项

- macOS 11.5+
- Swift 5.9+
- SwiftUI
- Foundation
- AppKit

## 注意事项

⚠️ **重要提示**：

1. 这是一个**反编译重建**的项目，源代码是基于二进制分析推断的，可能不完全准确
2. 某些功能实现可能需要根据实际需求进行调整
3. Helper 工具（`com.clashmac.helper`）需要单独编译，可能需要 XPC 通信实现
4. 系统代理功能需要 Helper 工具配合，涉及权限提升
5. 部分 API 调用和配置可能需要根据实际的 Clash API 文档进行调整

## 待完成功能

- [ ] Helper 工具的源代码重建
- [ ] 完整的系统代理实现
- [ ] 配置文件管理
- [ ] 代理节点选择
- [ ] 日志查看
- [ ] 规则管理
- [ ] 完整的错误处理

## 资源文件

- `mihomo`: Clash 核心二进制文件（已包含）
- `ui/zashboard/`: Web UI 界面（已包含）
- 图标和资源文件（已包含）

## 许可证

请根据原始项目的许可证使用。

