import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AmbientGlowBackground extends StatelessWidget {
  const AmbientGlowBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ColoredBox(
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: ClipRect(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: 30,
              sigmaY: 30,
              tileMode: TileMode.decal,
            ),
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: FractionalTranslation(
                    translation: const Offset(0.3, -0.25),
                    child: AmbientGlowBlob(
                      size: 360,
                      color: const Color(0xFFFFC7C9).withValues(alpha: .55),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FractionalTranslation(
                    translation: const Offset(-0.4, -0.1),
                    child: AmbientGlowBlob(
                      size: 420,
                      color: const Color(0xFFC9D7FF).withValues(alpha: .5),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionalTranslation(
                    translation: const Offset(0.15, 0.45),
                    child: AmbientGlowBlob(
                      size: 800,
                      color: const Color(0xFFDCCBFF).withValues(alpha: .5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AmbientGlowBlob extends StatelessWidget {
  const AmbientGlowBlob({required this.size, required this.color, super.key});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(-0.2, -0.25),
            radius: 1.15,
            colors: [
              color,
              color.withValues(alpha: color.a * 0.55),
              color.withValues(alpha: color.a * 0.18),
              color.withValues(alpha: 0),
            ],
            stops: const [0, 0.28, 0.62, 1],
          ),
        ),
      ),
    );
  }
}
