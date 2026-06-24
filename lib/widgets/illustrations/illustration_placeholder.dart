import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// Shared container for CozyVerse header illustrations.
///
/// Designed to swap the [child] for a transparent PNG illustration later
/// while keeping the soft ambient backdrop and decorative shapes.
class IllustrationPlaceholder extends StatelessWidget {
  const IllustrationPlaceholder({
    super.key,
    required this.height,
    required this.gradientColors,
    required this.decorations,
    this.child,
    this.borderRadius = 24,
  });

  final double height;
  final List<Color> gradientColors;
  final List<Widget> decorations;
  final Widget? child;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          border: Border.all(
            color: AppColors.lavenderLight.withValues(alpha: 0.45),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.lavender.withValues(alpha: 0.14),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ...decorations,
              if (child != null)
                Center(child: child!)
              else
                const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Responsive illustration height tuned for header slots.
double illustrationHeight(
  BuildContext context, {
  double min = 160,
  double max = 200,
  double widthFactor = 0.48,
}) {
  final width = MediaQuery.sizeOf(context).width;
  return (width * widthFactor).clamp(min, max);
}

/// Hero-sized illustration height (220–260px).
double heroIllustrationHeight(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  return (width * 0.58).clamp(220.0, 260.0);
}

class IllustrationGlowOrb extends StatelessWidget {
  const IllustrationGlowOrb({
    super.key,
    required this.size,
    required this.color,
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  final double size;
  final Color color;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color.withValues(alpha: 0.55),
              color.withValues(alpha: 0.12),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}

class IllustrationStar extends StatelessWidget {
  const IllustrationStar({
    super.key,
    required this.size,
    required this.top,
    required this.left,
    this.opacity = 0.6,
  });

  final double size;
  final double top;
  final double left;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Icon(
        Icons.star_rounded,
        size: size,
        color: AppColors.lavenderDark.withValues(alpha: opacity),
      ),
    );
  }
}
