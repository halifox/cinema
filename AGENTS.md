# 项目协作约束

适用于本仓库及所有子目录。

## 命令

- Codex **不得直接或间接执行**任何 `dart`、`flutter` 命令（包括脚本、IDE 和包装器调用）。
- 依赖安装、代码生成、格式化、分析、测试、构建和运行所需的完整命令，只能提供给用户手动执行。
- 可使用不调用 Dart/Flutter 的只读命令检查文件，并使用 `apply_patch` 修改代码。
- 交付时明确说明哪些分析、测试或构建未运行，不得宣称未执行的检查已通过。

## Flutter 代码

### 页面与文件

- 完整页面或路由 Widget 必须继承 `HookConsumerWidget`；每个 Dart 文件最多定义一个此类页面，不同页面分文件存放。
- 页面不得使用 `StatefulWidget`、`ConsumerStatefulWidget`、`State`、`ConsumerState` 或 `setState`。
- 页面专用的组件、Provider 及相关状态、参数和 Notifier 可留在页面文件；跨页面或功能复用时必须拆到独立文件。
- 无需 Hook 或 Provider 的非页面展示组件优先使用 `StatelessWidget`，不要无故改为 Consumer。

### 状态与生命周期

- 页面局部 UI 状态使用 `flutter_hooks`；应用数据、异步请求、缓存和跨页面状态使用 Riverpod，并通过 `WidgetRef.watch/read/invalidate` 访问。
- 不得在 `build` 中直接发起网络请求。首次加载放入 Provider 或 `useEffect`；分页和用户操作由明确回调触发。
- 生命周期资源优先由 Hook 自动释放；自定义监听须在 `useEffect` 清理函数中解除。
- 异步操作后更新 Hook 状态前，须确认 Widget 仍处于挂载状态。

### 命名与参数

- 手写 Dart 的类、typedef、变量、字段、常量和方法名不得以下划线开头。
- 生成文件（如 `.g.dart`、`.freezed.dart`）及生成器强制要求的手写工厂声明不受上述限制。
- 手写构造函数、普通函数和方法默认使用命名参数：必填项加 `required`，可选项提供默认值或声明为可空。
- 框架重写、运算符、第三方接口、生成器签名及回调类型约束不受参数规则限制。

## UI

- 液态玻璃界面遵循 `liquid_glass_widgets` 的组件与分层规范。
- 页面优先使用 `GlassScaffold`，底部导航使用 `GlassTabBar` 系列。
- 玻璃效果主要用于导航、工具栏、浮动控制和交互控件；普通滚动内容卡片保持清晰、非折射表面。
