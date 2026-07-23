# Flutter Agent 规范

作用域：本目录树；下级 `AGENTS.md` 优先。

## 1. 执行权限

- 仅以非 Dart/Flutter 只读命令检查，以 `apply_patch` 修改；禁止任何直接或间接 `dart`/`flutter` 调用，仅向用户提供完整命令。
- 交付须声明格式化、分析、测试、构建均未执行，不得宣称通过。
- 可直接修改 `pubspec.yaml`；基础栈内依赖无需确认，表外依赖的引入、移除、升级须先说明用途、替代方案、影响并获授权。
- 禁止修改 `.g.dart`、`.freezed.dart` 等生成物；仅提供生成命令。

## 2. 技术选型

- `pubspec.yaml` 是依赖事实源。依赖按需启用，禁止预装、同类重复或重复实现；Provider 手写，禁用 Riverpod 注解生成。
- 网络层以 Retrofit 声明接口、Dio 执行请求；Dio 统一管理基础配置、超时、请求头、拦截器及错误转换。`pretty_dio_logger` 仅在调试环境启用并脱敏。
- 数据类以 `freezed_annotation` 定义不可变结构，以 `json_annotation` 声明 JSON 映射；生成任务统一由 `build_runner`、`freezed`、`json_serializable`、`retrofit_generator` 执行。
- 结构化、可查询数据使用 Drift；SharedPreferences 仅存储小型、非敏感、非事务性设置。
- 网络图片使用 `cached_network_image` 处理缓存、占位和失败；分页使用 `riverpod_paging_utils`，并处理刷新、重试、去重及并发请求。
- `visibility_detector` 仅用于可见性或曝光检测；按索引定位长列表时使用 `scrollable_positioned_list`。

## 3. 架构

- 按功能组织：`features/<feature>/{domain,presentation}`；具体数据源置于 `data/<source>`；仅按复杂度增层。
- `domain` 仅含实体、值对象、Repository 抽象；不得依赖基础设施。远端、数据库、键值存储、平台能力均经领域接口隔离。
- `presentation` 仅依赖领域接口和通用 Provider；禁止引用 API、Remote DTO、Drift、SharedPreferences、具体实现或其 Provider。
- API、DTO、拦截器、映射器、Repository 实现及装配 Provider 内聚于数据源目录；具体实现仅在组合根经 Provider override 注入。
- 文件边界服从内聚与复用，禁止形式化分层。每文件至多一个页面/路由；页面专用组件、Provider、Notifier、无生成注解类型与页面同文件；仅跨页面/功能复用或需生成时拆分。
- 生成注解类型禁止位于 UI，须归入 `application`、`domain` 或数据源层。

## 4. Widget 与状态

- 页面/路由必须为 `HookConsumerWidget`；禁止 `StatefulWidget`、`ConsumerStatefulWidget`、`State`、`ConsumerState`、`setState`。无 Hook/Provider 的展示组件使用 `StatelessWidget`。
- 禁止以局部变量保存 Widget/Widget 表达式；直接构建，复杂或复用结构抽取独立 Widget。
- Hook 管理页面局部状态与资源；Riverpod 管理应用数据、异步、缓存、跨页状态。Provider 仅经 `WidgetRef.watch/read/listen/invalidate` 访问。
- `AsyncValue` 须在最小依赖域以 `when()` 覆盖 `data/loading/error`；禁止 `switch AsyncData` 及 `value`、`valueOrNull`、`requireValue`、`isLoading`、`hasError` 预解包。仅共同依赖域可嵌套 `when()`。
- 临时查询、参数化详情、离页即弃状态优先 `autoDispose`；常驻须有交互依据。
- 单页 Provider 与页面同文件；基础设施 Provider 位于相应实现文件且先于实现类；仅多页共享状态置于独立 `application` 文件。
- `build` 禁止 I/O；首次加载由 Provider/`useEffect` 触发，分页与操作由回调触发。资源由 Hook、`useEffect` 清理或 `ref.onDispose` 释放；异步后更新 Hook/Notifier 前分别检查 `context.mounted`/`ref.mounted`。

## 5. 异步与数据

- 异步 UI 覆盖加载、错误、空、成功及恢复路径；仅真实业务语义允许初始态；禁止空集合掩错或吞错。
- 搜索、分页、详情须防重复请求及陈旧响应覆盖，采用序号、取消或等价机制。
- 错误分层：数据层保留诊断信息；领域层稳定语义；UI 提供可理解、可恢复反馈。
- Repository 协调远端、缓存、映射；Widget/Notifier 禁止解析 DTO 或拼装底层查询。
- 生产日志禁止令牌、密钥、完整请求体、精确位置及其他敏感信息。

## 6. Dart 与持久化

- 手写标识符禁止前导下划线；生成物及生成器强制工厂除外。
- 手写构造函数/函数/方法默认命名参数：必填 `required`，可选项有默认值或可空；框架重写、运算符、第三方/生成器签名、回调约束除外。
- 优先不可变对象和 `const`；状态变更使用 Freezed `copyWith` 或新实例。
- Remote DTO 严格匹配后端字段名/类型，禁止容错类型和隐式转换；每字段显式声明同名亦不可省略的 `@JsonKey(name: ...)` 与类型匹配的 `@Default(...)`。
- DTO 须显式映射为领域模型；无效数据须拒绝或报告，禁止伪造默认业务值。
- Drift schema 变更须升版并实现可验证前向迁移，禁止以删库迁移。
- SharedPreferences 禁止存储密码、令牌、隐私、大对象或事务性数据。

## 7. UI、平台与交付

- Cupertino-first；除第三方/平台接口强制外禁止 Material。
- 液态玻璃遵循 `liquid_glass_widgets` 初始化与分层：页面优先 `GlassScaffold`，底栏使用 `GlassTabBar`；玻璃仅用于导航、工具栏、浮动控制、交互控件，滚动内容使用非折射表面。
- 视觉值取自主题/令牌；网络图须占位、回退、限缓存尺寸；适配明暗模式、安全区、键盘遮挡及充分触控区。
- 不实施无障碍适配；禁止 `Semantics`、`MergeSemantics`、`ExcludeSemantics`、`semanticLabel` 等语义 API。
- 平台能力不可用、拒权或服务关闭时须降级并提供恢复路径。
- API 地址、密钥、环境开关、第三方配置直接固化于源码；禁止环境变量、`.env`、编译参数或外部注入。
- 新平台插件须核查 Android/iOS/macOS/Windows/Linux/Web 支持矩阵，仅修改实际目标平台。
- 交付须含变更、依赖、生成物、已执行非 Dart/Flutter 检查及未执行的格式化/分析/测试/构建，并给出相应完整手动命令。
- 生成代码时检查全部非生成 Dart 文件，删除可省略的显式类型/泛型及全部 `unawaited`。
