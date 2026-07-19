import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AmbientGlowBackground extends StatelessWidget {
  const AmbientGlowBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    return RepaintBoundary(
      child: ColoredBox(
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: ClipRect(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 38, sigmaY: 38),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: FractionalTranslation(
                    translation: const Offset(.35, -.32),
                    child: GlowBlob(
                      size: 420,
                      color: Color(dark ? 0x665B2A52 : 0x99FFD0DD),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FractionalTranslation(
                    translation: const Offset(-.5, -.1),
                    child: GlowBlob(
                      size: 520,
                      color: Color(dark ? 0x55403673 : 0x889FC5FF),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FractionalTranslation(
                    translation: const Offset(.3, .45),
                    child: GlowBlob(
                      size: 680,
                      color: Color(dark ? 0x5546236E : 0x88D8C6FF),
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

class GlowBlob extends StatelessWidget {
  const GlowBlob({required this.size, required this.color, super.key});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
        ),
      ),
    );
  }
}
