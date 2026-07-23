import 'package:flutter/cupertino.dart';

abstract final class AppTheme {
  static CupertinoThemeData system() {
    return const CupertinoThemeData(
      primaryColor: Color(0xFFFF375F),
      scaffoldBackgroundColor: CupertinoColors.systemBackground,
      barBackgroundColor: CupertinoColors.systemBackground,
    );
  }
}
