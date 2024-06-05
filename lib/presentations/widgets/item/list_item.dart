import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String? avatar;
  final String title;
  final String? subtitle;
  final Widget? bottom;
  final Widget? trailing;
  final bool enabled;
  final VoidCallback? onTap;
  final ShapeBorder avatarShape;
  final IconData? leadingIcon;

  const ListItem({
    super.key,
    this.avatar,
    required this.title,
    this.subtitle,
    this.bottom,
    this.trailing,
    this.enabled = true,
    this.onTap,
    this.avatarShape = const CircleBorder(),
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: enabled ? onTap : null,
        splashColor: theme.colorScheme.primary.withOpacity(0.2),
        highlightColor: theme.colorScheme.primary.withOpacity(0.1),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            gradient: enabled
                ? LinearGradient(
                    colors: [
                      theme.colorScheme.primaryContainer.withOpacity(0.9),
                      theme.colorScheme.secondaryContainer.withOpacity(0.9),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: !enabled
                ? theme.colorScheme.onBackground.withOpacity(0.1)
                : null,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              if (leadingIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    leadingIcon,
                    color: enabled
                        ? theme.colorScheme.onPrimaryContainer
                        : theme.colorScheme.onSurface.withOpacity(0.5),
                    size: 30,
                  ),
                ),
              if (avatar != null)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Material(
                    elevation: 4,
                    shape: avatarShape,
                    clipBehavior: Clip.antiAlias,
                    child: Ink.image(
                      image: NetworkImage(avatar!),
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                      child: InkWell(
                        onTap: enabled ? onTap : null,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: enabled
                            ? theme.colorScheme.onPrimaryContainer
                            : theme.colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                    if (subtitle != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Text(
                          subtitle!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: enabled
                                ? theme.colorScheme.onPrimaryContainer
                                : theme.colorScheme.onSurface.withOpacity(0.5),
                          ),
                        ),
                      ),
                    if (bottom != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: bottom!,
                      ),
                  ],
                ),
              ),
              if (trailing != null)
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: trailing!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
