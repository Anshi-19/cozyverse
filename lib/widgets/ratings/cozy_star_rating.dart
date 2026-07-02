import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class CozyStarRating extends StatelessWidget {
  const CozyStarRating({
    super.key,
    required this.rating,
    required this.onRatingChanged,
    this.starSize = 36,
    this.spacing = 8,
  });

  final int rating;
  final ValueChanged<int> onRatingChanged;
  final double starSize;
  final double spacing;

  static const activeColor = Color(0xFFE8C468);
  static const inactiveColor = Color(0xFFE8DFF5);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starValue = index + 1;
        final isFilled = starValue <= rating;

        return Padding(
          padding: EdgeInsets.only(right: index < 4 ? spacing : 0),
          child: _StarButton(
            isFilled: isFilled,
            starSize: starSize,
            onTap: () => onRatingChanged(starValue),
          ),
        );
      }),
    );
  }
}

class _StarButton extends StatefulWidget {
  const _StarButton({
    required this.isFilled,
    required this.starSize,
    required this.onTap,
  });

  final bool isFilled;
  final double starSize;
  final VoidCallback onTap;

  @override
  State<_StarButton> createState() => _StarButtonState();
}

class _StarButtonState extends State<_StarButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.88 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOutCubic,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: Icon(
            widget.isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
            key: ValueKey(widget.isFilled),
            size: widget.starSize,
            color: widget.isFilled
                ? CozyStarRating.activeColor
                : CozyStarRating.inactiveColor,
          ),
        ),
      ),
    );
  }
}

class CozyStarDisplay extends StatelessWidget {
  const CozyStarDisplay({
    super.key,
    required this.rating,
    this.starSize = 22,
    this.showNumeric = true,
  });

  final double rating;
  final double starSize;
  final bool showNumeric;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '★★★★★',
          style: TextStyle(
            fontSize: starSize,
            color: CozyStarRating.activeColor,
            letterSpacing: 1,
            height: 1,
          ),
        ),
        if (showNumeric) ...[
          const SizedBox(width: 10),
          Text(
            rating.toStringAsFixed(1),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
          ),
        ],
      ],
    );
  }
}
