# 构建指南

## 方法一：使用 Xcode 创建项目

### 1. 创建新项目

1. 打开 Xcode
2. 选择 "File" -> "New" -> "Project"
3. 选择 "macOS" -> "App"
4. 填写项目信息：
   - Product Name: `ClashMac`
   - Team: 选择你的开发团队
   - Organization Identifier: `lv.llv`
   - Bundle Identifier: `lv.llv.ClashMac`
   - Interface: `SwiftUI`
   - Language: `Swift`
   - Minimum Deployment: `macOS 11.5`

### 2. 导入源代码

1. 删除 Xcode 自动生成的 `ContentView.swift` 和 `ClashMacApp.swift`
2. 将 `ClashMac` 目录下的所有文件拖拽到项目中
3. 确保文件结构如下：
   ```
   ClashMac/
   ├── ClashMacApp.swift
   ├── Models/
   │   ├── ProxyMode.swift
   │   ├── ProxyNode.swift
   │   └── ClashConfiguration.swift
   ├── Views/
   │   ├── ContentView.swift
   │   ├── SystemProxyToggleView.swift
   │   ├── ProxyModeSwitcher.swift
   │   └── UserConfigPickerView.swift
   ├── Controllers/
   │   └── ClashController.swift
   ├── Store/
   │   └── ClashStore.swift
   ├── API/
   │   ├── ClashAPIClient.swift
   │   ├── ClashSSEClient.swift
   │   └── ClashAPIError.swift
   └── Utils/
       ├── SystemProxyManager.swift
       └── ConfigManager.swift
   ```

### 3. 添加资源文件

1. 在 Xcode 中，右键点击项目
2. 选择 "Add Files to ClashMac..."
3. 选择 `Resources` 目录
4. 确保选择 "Create folder references"（不是 "Create groups"）
5. 勾选 "Copy items if needed"

### 4. 配置 Info.plist

1. 在项目设置中，找到 "Info" 标签
2. 或者直接使用项目根目录的 `Info.plist` 文件
3. 确保 Bundle Identifier 为 `lv.llv.ClashMac`

### 5. 配置 Capabilities

在 "Signing & Capabilities" 中添加：
- App Sandbox（如果需要）
- Network Client/Server（用于网络连接）
- User Selected File（用于配置文件导入）

### 6. 构建和运行

1. 选择目标设备为 "My Mac"
2. 按 `Cmd + R` 运行项目

## 方法二：使用 Swift Package Manager

```bash
cd ClashMac-Dev
swift build
```

注意：SPM 主要用于库项目，对于 macOS App，建议使用 Xcode。

## 方法三：使用命令行工具生成 Xcode 项目

```bash
cd ClashMac-Dev
swift package generate-xcodeproj
```

## 常见问题

### 1. 找不到资源文件

确保资源文件已添加到项目中，并且使用 "folder references" 而不是 "groups"。

### 2. Helper 工具编译

Helper 工具（`com.clashmac.helper`）需要单独创建为一个 XPC Service 或 Launch Agent。这需要：
- 创建新的 Target
- 配置 Code Signing
- 实现 XPC 通信

### 3. 系统代理权限

系统代理功能需要 Helper 工具配合，涉及系统权限。需要：
- 创建 Privileged Helper Tool
- 使用 SMJobBless 安装
- 实现 XPC 通信

## 下一步

1. 实现 Helper 工具的源代码
2. 完善系统代理功能
3. 添加配置文件管理
4. 实现完整的 UI
5. 添加错误处理和日志

