import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import '../theme/app_theme.dart';

Widget buildCachedImageLoading(
  BuildContext context,
  String url,
  DownloadProgress progress,
) {
  return Center(
    child: GlassProgressIndicator.circular(
      value: progress.progress,
      size: 28,
      useOwnLayer: true),
  );
}

Widget buildCachedImageError(BuildContext context, String url, Object error) {
  return Center(
    child: Icon(
      CupertinoIcons.photo,
      color: CupertinoColors.tertiaryLabel.resolveFrom(context),
      size: 32,
    ),
  );
}
