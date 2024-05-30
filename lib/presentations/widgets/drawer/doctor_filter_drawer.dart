import 'package:flutter/material.dart';
import 'package:konsuldoc/domain/enums/specialist.dart';
import 'package:konsuldoc/presentations/widgets/button/primary_button.dart';
import 'package:konsuldoc/presentations/widgets/item/option_item.dart';

class DoctorFilterDrawer extends StatefulWidget {
  final Specialist? value;
  final void Function(Specialist?) onApply;

  const DoctorFilterDrawer({super.key, this.value, required this.onApply});

  @override
  State<DoctorFilterDrawer> createState() => _DoctorFilterDrawerState();
}

class _DoctorFilterDrawerState extends State<DoctorFilterDrawer> {
  late Specialist? selected = widget.value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 7),
            Expanded(
              child: Wrap(
                spacing: 7,
                children: Specialist.values
                    .map(
                      (specialist) => OptionItem(
                        selected: selected == specialist,
                        onPressed: () {
                          setState(() {
                            selected =
                                selected == specialist ? null : specialist;
                          });
                        },
                        icon: specialist.icon,
                        activeIcon: specialist.activeIcon,
                        label: specialist.label,
                        margin: 3.5,
                      ),
                    )
                    .toList(),
              ),
            ),
            PrimaryButton(
              onPressed: () {
                widget.onApply(selected);
                Navigator.pop(context);
              },
              label: 'Terapkan',
            )
          ],
        ),
      ),
    );
  }
}
