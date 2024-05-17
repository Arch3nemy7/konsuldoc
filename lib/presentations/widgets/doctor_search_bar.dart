import 'package:flutter/material.dart';

class DoctorSearchBar extends StatelessWidget {
  const DoctorSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SearchBar(
      leading: const Icon(Icons.search),
      elevation: const MaterialStatePropertyAll(0),
      backgroundColor: MaterialStatePropertyAll(
        theme.colorScheme.surfaceVariant,
      ),
      padding: const MaterialStatePropertyAll(EdgeInsets.only(left: 14)),
      constraints: const BoxConstraints.tightFor(height: 48),
      hintText: 'Pencarian',
      trailing: [
        IconButton(
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
          color: theme.colorScheme.onSecondaryContainer,
          style: IconButton.styleFrom(
            backgroundColor: theme.colorScheme.secondaryContainer,
            elevation: 4,
            shadowColor: theme.colorScheme.shadow,
          ),
          icon: const Icon(Icons.tune),
        )
      ],
    );
  }
}
