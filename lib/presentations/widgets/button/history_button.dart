import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konsuldoc/core/router/member_router.gr.dart' as member_router;
import 'package:konsuldoc/core/router/doctor_router.gr.dart' as doctor_router;
import 'package:konsuldoc/domain/entities/member.dart';
import 'package:konsuldoc/domain/enums/role.dart';
import 'package:konsuldoc/presentations/providers/user_role_provider.dart';

class HistoryButton extends ConsumerWidget {
  final Member member;

  const HistoryButton({
    super.key,
    required this.member,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(userRoleProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
            onPressed: () {
              if(role == Role.member) {
                context.pushRoute(member_router.MemberHistoryRoute(id: member.id));
              } else {
                context.pushRoute(doctor_router.MemberHistoryRoute(id: member.id));
              }
            },
            child: const Row(
              children: [
                Icon(
                  Icons.schedule,
                ),
                SizedBox(width: 15),
                Text(
                  'History',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        const Divider(
          indent: 20,
          endIndent: 20,
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }
}
