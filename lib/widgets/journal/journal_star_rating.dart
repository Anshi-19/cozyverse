import 'package:flutter/material.dart';

class JournalStarRating extends StatelessWidget {
  const JournalStarRating({
    super.key,
    required this.rating,
    required this.onRatingChanged,
  });

  final int rating;
  final ValueChanged<int> onRatingChanged;

  static const _activeColor = Color(0xFFE8C468);
  static const _inactiveColor = Color(0xFFE8DFF5);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final starValue = index + 1;
        final isFilled = starValue <= rating;

        return Padding(
          padding: EdgeInsets.only(right: index < 4 ? 8 : 0),
          child: _StarButton(
            isFilled: isFilled,
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
    required this.onTap,
  });

  final bool isFilled;
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
            size: 36,
            color: widget.isFilled
                ? JournalStarRating._activeColor
                : JournalStarRating._inactiveColor,
          ),
        ),
      ),
    );
  }
}
