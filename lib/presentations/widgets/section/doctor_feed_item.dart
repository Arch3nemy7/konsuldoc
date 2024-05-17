import 'package:flutter/material.dart';
import 'package:konsuldoc/core/utils/formatter.dart';
import 'package:konsuldoc/domain/entities/appointment.dart';
import 'package:konsuldoc/presentations/widgets/item/list_item.dart';

class DoctorFeedItem extends StatelessWidget {
  final String title;
  final String trailing;
  final List<Appointment> appointments;

  const DoctorFeedItem({
    super.key,
    required this.title,
    required this.trailing,
    required this.appointments,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(7).copyWith(bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(trailing, style: theme.textTheme.labelSmall),
              ],
            ),
          ),
          ...appointments.map(
            (appointment) => ListItem(
              avatar: appointment.member.avatar,
              title: appointment.member.name,
              bottom: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.schedule,
                    size: 15,
                    color: theme.colorScheme.secondary,
                  ),
                  const SizedBox(width: 3.5),
                  Text(
                    appointment.date.toTimeString(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: theme.colorScheme.secondary,
                ),
              ),
            ),
            margin: const EdgeInsets.only(right: 7),
            child: Text(
              'tampilkan lebih',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.secondary,
              ),
            ),
          )
        ],
      ),
    );
  }
}
