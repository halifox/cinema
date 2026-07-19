import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

GlassLargeTitleController useGlassLargeTitleController() {
  final controller = useMemoized(GlassLargeTitleController.new);
  useEffect(() => controller.dispose, [controller]);
  return controller;
}
