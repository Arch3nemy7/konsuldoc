import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final Widget icon;
  final String? title;
  final String message;
  final VoidCallback? onRetry;

  const ErrorView({
    super.key,
    this.icon = const Icon(
      Icons.error_outline_outlined,
      size: 30,
    ),
    this.title,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 4),
          if (title != null)
            Text(
              title!,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium,
            ),
          const SizedBox(height: 15),
          Text(
            message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          if (onRetry != null)
            FilledButton(
              style: FilledButton.styleFrom(
                visualDensity: VisualDensity.compact,
              ),
              onPressed: onRetry!,
              child: const Text('Try again'),
            )
        ],
      ),
    );
  }
}
