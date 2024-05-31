import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konsuldoc/core/utils/formatter.dart';
import 'package:konsuldoc/presentations/controllers/member_controller.dart';
import 'package:konsuldoc/presentations/widgets/button/history_button.dart';

@RoutePage()
class MemberDetailPage extends ConsumerWidget {
  final String id;

  const MemberDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memberStream = ref.watch(fetchMemberByIdProvider(id));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Pasien'),
        centerTitle: true,
      ),
      body: memberStream.when(
        data: (member) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 75,
                  backgroundImage: member.avatar != null
                      ? NetworkImage(member.avatar!)
                      : null,
                ),
                const SizedBox(height: 20),
                buildDetailRow('Nama', member.name),
                buildDetailRow('Nomor Ponsel', member.phone ?? '-'),
                buildDetailRow('Jenis Kelamin', member.gender?.label ?? '-'),
                buildDetailRow(
                    'Tanggal Lahir', member.dob?.toDateString() ?? '-'),
                buildDetailRow(
                  'Alamat',
                  member.address ?? '-',
                  isMultiline: true,
                ),
                HistoryButton(member: member),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
      ),
    );
  }

  Widget buildDetailRow(
    String title,
    String value, {
    bool isMultiline = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment:
            isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Inter',
              ),
              maxLines: isMultiline ? null : 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildScheduleBox(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF71787E),
        borderRadius: BorderRadius.circular(5),
        boxShadow: kElevationToShadow[4],
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
