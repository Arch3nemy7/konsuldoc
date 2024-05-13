import 'package:flutter/material.dart';

class OptionItem extends StatelessWidget {
  final bool selected;
  final VoidCallback onPressed;
  final IconData? icon;
  final IconData? activeIcon;
  final String label;
  final double margin;

  const OptionItem({
    super.key,
    required this.selected,
    required this.onPressed,
    this.icon,
    this.activeIcon,
    required this.label,
    this.margin = 7,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentIcon = selected ? activeIcon : icon;

    return Padding(
      padding: EdgeInsets.all(margin),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          textStyle: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          backgroundColor:
              selected ? theme.colorScheme.primary : theme.colorScheme.surface,
          foregroundColor: selected
              ? theme.colorScheme.onPrimary
              : theme.colorScheme.onSurface,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (currentIcon != null)
              Padding(
                padding: const EdgeInsets.only(right: 7),
                child: Icon(
                  currentIcon,
                  size: 18,
                ),
              ),
            Text(label),
          ],
        ),
      ),
    );
  }
}
