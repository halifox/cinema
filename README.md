<div align="center">
  <img src="assets/icon/app_icon.png" width="120" alt="Cinema 应用图标" />
</div>

# Cinema

一款基于 Flutter 构建的第三方影视浏览与播放客户端，以苹果 CMS v10 接口为数据源，提供分类发现、搜索、片单、播放记录与多源选集体验。界面采用 Cupertino 风格，并通过液态玻璃组件适配浅色与深色外观。

> [!IMPORTANT]
> 本项目为非官方客户端，仅供学习与技术交流。应用不托管、不制作任何影视内容；内容数据与版权归相应内容服务、原作者及权利人所有。

## 界面预览

<div align="center">
  <img src="screenshots/screenshot_1.webp" width="24%" alt="首页分类浏览" />
  <img src="screenshots/screenshot_2.webp" width="24%" alt="影片详情" />
  <img src="screenshots/screenshot_3.webp" width="24%" alt="影片播放" />
  <img src="screenshots/screenshot_8.webp" width="24%" alt="播放控制" />
</div>

<div align="center">
  <img src="screenshots/screenshot_4.webp" width="48%" alt="搜索界面" />
  <img src="screenshots/screenshot_5.webp" width="48%" alt="搜索结果" />
  <img src="screenshots/screenshot_6.webp" width="48%" alt="片单" />
  <img src="screenshots/screenshot_7.webp" width="48%" alt="观看记录" />
</div>

## 功能

- 按一级与二级分类浏览影视内容，并支持分页加载
- 关键词搜索、搜索历史记录与一键清空
- 影片详情、简介、演职员信息、多播放源与分集选集
- 基于 `media_kit` 的在线播放、进度恢复、倍速与播放控制
- 本地片单收藏、观看记录与继续播放
- 适配浅色、深色系统外观的 Cupertino 液态玻璃界面

## 快速开始

### 环境要求

- Flutter SDK（Dart 3.12.2 或更高版本）
- 已配置对应目标平台的 Flutter 开发环境
- 可访问内容服务的网络连接

### 获取并运行

```bash
git clone https://github.com/halifox/cinema.git
cd cinema

flutter pub get

dart run build_runner build --delete-conflicting-outputs

flutter run --dart-define="CMS_BASE_URL=https://example.com"
```

## 技术栈

- **UI 框架** — Flutter / Cupertino / liquid_glass_widgets
- **状态管理** — Riverpod / Flutter Hooks
- **网络请求** — Dio / Retrofit
- **数据模型** — Freezed / json_serializable
- **本地存储** — Drift / Shared Preferences
- **图片加载** — cached_network_image
- **分页加载** — riverpod_paging_utils
- **媒体播放** — media_kit / media_kit_video

## 贡献

欢迎提交 Issue 和 Pull Request。提交代码前，请遵循仓库中的 [AGENTS.md](AGENTS.md) 协作约束。

## 许可证

本项目遵循 [GPL-3.0 License](LICENSE)。
