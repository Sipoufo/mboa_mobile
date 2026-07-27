import 'package:afrodiet/src/core/theme/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, this.size = Dimens.loaderSize});

  factory Loader.sm({Key? key}) => Loader(key: key, size: Dimens.loaderSizeSm);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator.adaptive(strokeCap: StrokeCap.round),
      ),
    );
  }
}

class IconLoader extends StatelessWidget {
  const IconLoader({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      LucideIcons.loader,
      color: color,
      size: Dimens.iconSizeSm,
    ).animate(onPlay: (controller) => controller.repeat()).rotate(duration: const Duration(seconds: 2));
  }
}
