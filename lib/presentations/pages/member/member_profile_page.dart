import 'dart:js';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konsuldoc/core/router/member_router.gr.dart';
import 'package:konsuldoc/domain/entities/member.dart';
import 'package:konsuldoc/presentations/controllers/auth_controller.dart';
import 'package:konsuldoc/presentations/providers/user_state_provider.dart';
import 'package:konsuldoc/presentations/widgets/error_view.dart';
import 'package:konsuldoc/presentations/widgets/loader.dart';

@RoutePage()
class MemberProfilePage extends ConsumerWidget {
  const MemberProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ref.watch(userStateProvider).when(
            data: (data) {
              final member = data as Member;

              return Column(
                children: [
                  _profilePict(member.avatar),
                  Text(
                    member.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    member.phone ?? 'Tidak ada',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  _editProfile(context, member),
                  _history(),
                  _signOut(ref),
                ],
              );
            },
            error: (error, stackTrace) {
              return ErrorView(
                message: error.toString(),
              );
            },
            loading: () => const Loader(),
          ),
    );
  }

  _profilePict(String? avatar) {
    return  Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child:avatar == null ? null : CircleAvatar(
                backgroundImage:  NetworkImage(
                    avatar),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _editProfile(BuildContext context, Member member) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
            onPressed: () {
              context.pushRoute(MemberFormRoute(member: member));
            },
            child: const Row(
              children: [
                Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
                SizedBox(width: 15),
                Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
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

  _signOut(WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
            onPressed: () {
              ref.read(authControllerProvider).signOut();
            },
            child: const Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                SizedBox(width: 15),
                Text(
                  'Logout',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Spacer(),
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

  _history() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
            onPressed: () {},
            child: const Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: Colors.black,
                ),
                SizedBox(width: 15),
                Text(
                  'History',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
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
