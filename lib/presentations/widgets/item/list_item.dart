import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String? avatar;
  final String title;
  final String? subtitle;
  final Widget? bottom;
  final Widget? trailing;
  final bool enabled;
  final VoidCallback? onTap;

  const ListItem({
    super.key,
    this.avatar,
    required this.title,
    this.subtitle,
    this.bottom,
    this.trailing,
    this.enabled = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: enabled
            ? theme.colorScheme.secondaryContainer
            : theme.colorScheme.outline,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: CircleAvatar(
                backgroundImage: avatar == null ? null : NetworkImage(avatar!),
                radius: 27,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: theme.textTheme.labelSmall,
                    ),
                  if (bottom != null) bottom!
                ],
              ),
            ),
            if (trailing != null) trailing!
          ],
        ),
      ),
    );
  }
}
