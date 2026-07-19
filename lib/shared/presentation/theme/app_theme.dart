import 'package:flutter/cupertino.dart';

abstract final class AppTheme {
  static const seedColor = Color(0xFFFF375F);

  static CupertinoThemeData system() {
    return const CupertinoThemeData(
      primaryColor: seedColor,
      scaffoldBackgroundColor: CupertinoColors.systemBackground,
      barBackgroundColor: CupertinoColors.systemBackground,
    );
  }
}
