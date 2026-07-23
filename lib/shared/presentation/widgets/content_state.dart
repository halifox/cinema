import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

typedef ErrorPresentation = (IconData icon, String title, String message);

class ContentStateSliver extends StatelessWidget {
  const ContentStateSliver.loading({super.key})
    : icon = CupertinoIcons.circle,
      title = '正在加载',
      message = '正在获取内容，请稍候',
      iconColor = const Color(0xFFFF5A5F),
      loading = true,
      onRetry = null;

  factory ContentStateSliver.error({
    required Object error,
    VoidCallback? onRetry,
    Key? key,
  }) {
    final presentation = errorPresentation(error: error);
    return ContentStateSliver.internal(
      key: key,
      icon: presentation.$1,
      title: presentation.$2,
      message: presentation.$3,
      iconColor: const Color(0xFF8B5CF6),
      loading: false,
      onRetry: onRetry,
    );
  }

  const ContentStateSliver.internal({
    required this.icon,
    required this.title,
    required this.message,
    required this.iconColor,
    required this.loading,
    this.onRetry,
    super.key,
  });

  const ContentStateSliver.empty({
    required this.icon,
    required this.title,
    required this.message,
    super.key,
  }) : iconColor = const Color(0xFFFF5A5F),
       loading = false,
       onRetry = null;

  final IconData icon;
  final String title;
  final String message;
  final Color iconColor;
  final bool loading;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              loading
                  ? Center(
                      child: GlassProgressIndicator.circular(
                        size: 40,
                        color: CupertinoTheme.of(context).primaryColor,
                      ),
                    )
                  : Icon(icon, size: 48, color: iconColor),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.label.resolveFrom(context),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CupertinoColors.secondaryLabel.resolveFrom(context),
                ),
              ),
              if (onRetry != null) ...[
                const SizedBox(height: 20),
                GlassButton.custom(
                  width: 132,
                  height: 44,
                  shape: const LiquidRoundedSuperellipse(borderRadius: 44),
                  onTap: onRetry!,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.refresh, size: 18),
                      SizedBox(width: 8),
                      Text(
                        '重新加载',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  static ErrorPresentation errorPresentation({required Object error}) {
    if (error is DioException) {
      final message = responsePayloadMessage(error: error);

      if (error.type == DioExceptionType.badResponse) {
        return switch (error.response?.statusCode) {
          210 => (CupertinoIcons.shield_fill, '访问受限', message),
          400 => (
            CupertinoIcons.exclamationmark_triangle_fill,
            '请求有误',
            message,
          ),
          401 => (
            CupertinoIcons.person_crop_circle_badge_exclam,
            '登录已失效',
            message,
          ),
          403 => (CupertinoIcons.lock_shield_fill, '无权访问', message),
          404 => (CupertinoIcons.search_circle, '内容不存在', message),
          405 => (
            CupertinoIcons.exclamationmark_triangle_fill,
            '请求不受支持',
            message,
          ),
          408 => (CupertinoIcons.clock_fill, '请求超时', message),
          409 => (
            CupertinoIcons.exclamationmark_triangle_fill,
            '请求冲突',
            message,
          ),
          422 => (CupertinoIcons.doc_text_search, '内容无法处理', message),
          429 => (CupertinoIcons.hourglass, '请求过于频繁', message),
          final int code when code >= 500 => (
            CupertinoIcons.exclamationmark_triangle_fill,
            '服务异常',
            message,
          ),
          _ => (CupertinoIcons.exclamationmark_triangle_fill, '加载失败', message),
        };
      }

      return switch (error.type) {
        DioExceptionType.connectionTimeout => (
          CupertinoIcons.clock_fill,
          '连接超时',
          message,
        ),
        DioExceptionType.sendTimeout => (
          CupertinoIcons.arrow_up_circle_fill,
          '发送超时',
          message,
        ),
        DioExceptionType.receiveTimeout => (
          CupertinoIcons.arrow_down_circle_fill,
          '响应超时',
          message,
        ),
        DioExceptionType.connectionError => (
          CupertinoIcons.wifi_exclamationmark,
          '网络不可用',
          message,
        ),
        DioExceptionType.badCertificate => (
          CupertinoIcons.lock_shield_fill,
          '安全连接失败',
          message,
        ),
        DioExceptionType.cancel => (
          CupertinoIcons.xmark_circle_fill,
          '请求已取消',
          message,
        ),
        DioExceptionType.transformTimeout => (
          CupertinoIcons.clock_fill,
          '数据处理超时',
          message,
        ),
        DioExceptionType.badResponse => (
          CupertinoIcons.exclamationmark_triangle_fill,
          '加载失败',
          message,
        ),
        DioExceptionType.unknown => (
          error.error is FormatException || error.error is TypeError
              ? CupertinoIcons.doc_text_search
              : CupertinoIcons.exclamationmark_triangle_fill,
          error.error is FormatException || error.error is TypeError
              ? '数据异常'
              : '网络异常',
          message,
        ),
      };
    }

    return switch (error) {
      FormatException() ||
      TypeError() => (CupertinoIcons.doc_text_search, '数据异常', ''),
      StateError() => (
        CupertinoIcons.exclamationmark_triangle_fill,
        '状态异常',
        '',
      ),
      _ => (CupertinoIcons.exclamationmark_triangle_fill, '出现问题', ''),
    };
  }

  static String responsePayloadMessage({required DioException error}) {
    final data = error.response?.data;
    if (data is Map) {
      for (final key in const ['message', 'detail', 'error']) {
        final value = data[key];
        if (value is String && value.trim().isNotEmpty) {
          return value.trim();
        }
      }
    }

    final statusMessage = error.response?.statusMessage?.trim();
    if (statusMessage != null && statusMessage.isNotEmpty) {
      return statusMessage;
    }

    return '';
  }
}
