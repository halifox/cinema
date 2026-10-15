<div align="center">

  <img src="assets/icon/app_icon.png" alt="哈狸影视 应用图标" width="128" />

# 哈狸影视

一款采用 iOS Liquid Glass 界面风格的苹果 CMS 影视第三方客户端。

[![Built with Flutter](https://img.shields.io/badge/built%20with-Flutter-02569B)](#从源码运行与构建)
[![Android arm64](https://img.shields.io/badge/Android-arm64-3DDC84)](#安装)
[![iOS unsigned IPA](https://img.shields.io/badge/iOS-unsigned%20IPA-555555)](#安装)
[![License: GPL-3.0](https://img.shields.io/badge/license-GPL--3.0-lightgrey)](LICENSE)

[功能](#功能概览) · [预览](#界面预览) · [安装](#安装) · [构建](#从源码运行与构建) · [数据与隐私](#数据与隐私)

</div>

---

> [!IMPORTANT]
> 本项目为非官方客户端，仅供学习与技术交流。应用不托管、不制作任何影视内容；内容数据与版权归相应内容服务、原作者及权利人所有。

## 功能概览

- 按一级与二级分类浏览影视内容，支持分页加载；
- 通过关键词搜索影片，查看搜索历史；
- 将影片加入本地片单，查看观看记录；
- 查看影片详情、简介和演职员信息，切换播放源与分集；
- 支持在线播放、倍速与播放控制，记录播放进度，继续上次观看；
- 使用 Cupertino 风格界面，支持浅色与深色外观，并在导航和交互控件中使用液态玻璃效果。

## 界面预览

<div align="center">
  <img src="screenshots/screenshot_1.webp" width="24%" />
  <img src="screenshots/screenshot_2.webp" width="24%" />
  <img src="screenshots/screenshot_3.webp" width="24%" />
  <img src="screenshots/screenshot_8.webp" width="24%" />
  <img src="screenshots/screenshot_4.webp" width="48%" />
  <img src="screenshots/screenshot_5.webp" width="48%" />
  <img src="screenshots/screenshot_6.webp" width="48%" />
  <img src="screenshots/screenshot_7.webp" width="48%" />
</div>

## 安装

### Android

从 [GitHub Releases](https://github.com/halifox/cinema/releases/latest) 下载 `.apk` 文件，打开后按系统提示安装。目前提供 arm64 安装包。

### iOS

从 [GitHub Releases](https://github.com/halifox/cinema/releases/latest) 下载未签名的 `.ipa` 文件，使用 SideStore 安装。

首次使用请按 [SideStore 官方安装教程](https://docs.sidestore.io/docs/installation/install) 完成配置，再在 SideStore 的 **My Apps → +** 中选择下载的 IPA。免费 Apple 账号签名通常需每 7 天刷新一次。

版本变化见 [CHANGELOG.md](CHANGELOG.md)。

## 使用说明与限制

- 分类、详情、播放源和分集信息来自所配置的苹果 CMS v10 内容服务，浏览与播放需要可访问相应服务的网络连接。
- 第三方服务的接口、线路或内容变化可能影响加载或播放。遇到失败时，可检查网络后使用页面提供的重试或刷新操作。
- 片单、观看进度与搜索历史保存在本机，当前不提供账号登录或跨设备同步。
- 图片缓存用于减少重复加载，当前不提供影片下载或离线片库；缓存不等同于可完整离线观看。
- 当前发布流程面向 Android arm64 和 iOS。仓库中的其他平台目录不代表已有对应发行包或经过完整验证。

## 从源码运行与构建

### 环境要求

- Flutter SDK（包含 Dart 3.12.2 或兼容的 3.x 版本，以 `pubspec.yaml` 为准）
- 对应目标平台的 Flutter 开发环境
- Android 构建需要 Android SDK 和 Java 17；iOS 构建需要 macOS、Xcode 与对应的签名配置
- 可访问内容服务的网络连接

### 获取并运行

准备兼容苹果 CMS v10 接口的服务地址，并通过
`--dart-define="CMS_BASE_URL=https://example.com"` 在编译时直接注入地址。请将示例地址替换为实际服务地址；未配置或传入空地址时，应用会显示配置错误。

```bash
# 克隆仓库
git clone https://github.com/halifox/cinema.git
cd cinema

# 安装依赖
flutter pub get

# 生成 Retrofit、Freezed、JSON 与 Drift 相关代码
dart run build_runner build --delete-conflicting-outputs

# 运行应用
flutter run --dart-define="CMS_BASE_URL=https://example.com"
```

仓库已经包含当前生成的代码；当数据模型、API 或数据库定义发生变化时，需要重新执行代码生成。

### 构建安装包

在仓库根目录运行，并替换内容服务地址：

```bash
# Android arm64 Release APK：需先配置 android/key.properties 和签名密钥
flutter build apk --release --target-platform android-arm64 --dart-define="CMS_BASE_URL=https://example.com"

# iOS 未签名应用：需在 macOS 上运行，产物不能直接安装
flutter build ios --release --no-codesign --dart-define="CMS_BASE_URL=https://example.com"

# iOS 签名 IPA：需先在 Xcode 中配置开发团队、证书与描述文件
flutter build ipa --release --dart-define="CMS_BASE_URL=https://example.com"
```

Android APK 输出到 `build/app/outputs/flutter-apk/`；iOS 未签名应用输出到 `build/ios/iphoneos/`，签名 IPA 输出到 `build/ios/ipa/`。仓库的发布工作流会将未签名 iOS 应用另行打包为 IPA。

### 技术栈

- **UI 框架** — Flutter / liquid_glass_widgets
- **状态管理** — Riverpod / Flutter Hooks
- **网络请求** — Dio / Retrofit
- **数据模型** — Freezed / json_serializable
- **本地存储** — Drift / Shared Preferences
- **图片加载** — cached_network_image
- **分页加载** — riverpod_paging_utils
- **媒体播放** — media_kit / media_kit_video

## 数据与隐私

### 本地数据

片单收藏、影片信息、观看记录、播放进度与搜索历史通过 Drift 存储在本地 SQLite 数据库中；网络图片由图片缓存组件管理。

可在观看记录页面清空观看记录，在搜索历史页面删除单条搜索记录。清空观看记录不会同时删除片单收藏、搜索历史或所有分集进度。Android 可通过系统应用设置清除应用存储，删除本地数据库、设置和缓存；此操作不可撤销。

### 网络请求与诊断

浏览和搜索时，应用会向所配置的内容服务发送请求，包含相应的分类、分页、搜索关键词或影片标识。加载海报和播放影片时，还会访问内容服务返回的图片与媒体地址。

项目已接入 Sentry 错误与性能诊断，发布工作流通过构建配置传入 Sentry DSN。配置有效时，可能发送异常、堆栈、请求诊断信息和设备信息；当前配置启用了默认个人信息收集、性能追踪，以及错误会话和部分普通会话的回放采样。因此，本项目不作“无遥测”或“所有数据仅保留在本机”的承诺。

调试构建启用 Dio 网络日志，可能包含请求地址、参数和请求头。提交 Issue 或分享日志前，请删除个人信息与其他敏感内容。

## 许可证与第三方内容

本项目源代码遵循 [GPL-3.0 License](LICENSE)。第三方依赖遵循各自的许可证，依赖列表见 [pubspec.yaml](pubspec.yaml)。

影视内容的版权归原作者及相关权利人所有，不适用本项目的代码许可证。本项目的许可证声明不构成内容、商标或品牌授权。

## 参与贡献

欢迎提交问题、改进建议和 Pull Request。提交代码前，请阅读 [AGENTS.md](AGENTS.md) 中的协作约束。

反馈问题时，请说明应用版本、平台、复现步骤和错误现象；附带截图或日志前请先脱敏。
