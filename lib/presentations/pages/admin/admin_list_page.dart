import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:konsuldoc/core/router/admin_router.gr.dart';
import 'package:konsuldoc/domain/entities/admin.dart';
import 'package:konsuldoc/presentations/controllers/admin_controller.dart';
import 'package:konsuldoc/presentations/controllers/auth_controller.dart';
import 'package:konsuldoc/presentations/widgets/error_view.dart';
import 'package:konsuldoc/presentations/widgets/loader.dart';

@RoutePage()
class AdminListPage extends ConsumerStatefulWidget {
  const AdminListPage({super.key});

  @override
  ConsumerState<AdminListPage> createState() => _AdminListPageState();
}

class _AdminListPageState extends ConsumerState<AdminListPage> {
  String? query;

  void search(String value) {
    setState(() {
      query = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Admin',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authControllerProvider).signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              onSubmitted: search,
              leading: const Icon(Icons.search),
              elevation: const MaterialStatePropertyAll(0),
              backgroundColor: MaterialStatePropertyAll(
                theme.colorScheme.surfaceVariant,
              ),
              padding:
                  const MaterialStatePropertyAll(EdgeInsets.only(left: 14)),
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
            ),
          ),
          Expanded(
            child: ref.watch(fetchAllAdminProvider).when(
                  data: (data) {
                    final filtered = query == null
                        ? data
                        : data
                            .filter((t) => t.name
                                .toLowerCase()
                                .contains(query!.toLowerCase()))
                            .toList();

                    if (filtered.isEmpty) {
                      return const ErrorView(message: 'Data tidak ditemukan');
                    }

                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final admin = filtered[index];

                        return ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 40),
                          onTap: () {
                            _showDetailAdmin(admin);
                          },
                          leading: CircleAvatar(
                            backgroundImage: admin.avatar == null
                                ? null
                                : NetworkImage(admin.avatar!),
                            radius: 25,
                          ),
                          title: Text(
                            admin.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: filtered.length,
                    );
                  },
                  error: (error, stackTrace) {
                    return ErrorView(message: error.toString());
                  },
                  loading: () => const Loader(),
                ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'admin-list',
        onPressed: () {
          context.pushRoute(AdminFormRoute());
        },
        backgroundColor: const Color(0xFFF9E287),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDetailAdmin(Admin admin) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.42,
          minChildSize: 0.3,
          maxChildSize: 0.7,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('Admin',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        )),
                    const Divider(
                      color: Colors.black38,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 120,
                              width: 120,
                              child: CircleAvatar(
                                  backgroundImage: admin.avatar == null
                                      ? null
                                      : NetworkImage(admin.avatar!)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          admin.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(admin.email),
                        Text(admin.phone ?? 'Tidak ada'),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 140,
                            child: ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(authControllerProvider)
                                    .deleteUser(admin.id)
                                    .then((value) {
                                  if (value) context.maybePop();
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 207, 31, 31)),
                                shadowColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return Colors.grey.withOpacity(0.8);
                                  },
                                ),
                                elevation:
                                    MaterialStateProperty.resolveWith<double>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return 0;
                                    }
                                    return 5;
                                  },
                                ),
                              ),
                              child: const Text(
                                'Hapus',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          SizedBox(
                            width: 140,
                            child: ElevatedButton(
                              onPressed: () {
                                context
                                    .pushRoute(AdminFormRoute(admin: admin))
                                    .then((value) => context.maybePop());
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(34, 100, 136, 1)),
                                shadowColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    return Colors.grey.withOpacity(0.8);
                                  },
                                ),
                                elevation:
                                    MaterialStateProperty.resolveWith<double>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return 0;
                                    }
                                    return 5;
                                  },
                                ),
                              ),
                              child: const Text(
                                'Edit',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
