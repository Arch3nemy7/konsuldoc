import 'package:flutter/material.dart';

class DangerButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;

  const DangerButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade800,
          foregroundColor: theme.colorScheme.onPrimary,
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
