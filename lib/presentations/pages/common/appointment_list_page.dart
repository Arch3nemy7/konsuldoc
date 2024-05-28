import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:konsuldoc/core/dependencies/repositories.dart';
import 'package:konsuldoc/core/router/member_router.gr.dart';
import 'package:konsuldoc/core/utils/formatter.dart';
import 'package:konsuldoc/domain/entities/appointment.dart';
import 'package:konsuldoc/domain/enums/appointment_filter.dart';
import 'package:konsuldoc/presentations/providers/auth_state_provider.dart';
import 'package:konsuldoc/presentations/widgets/item/list_item.dart';
import 'package:konsuldoc/presentations/widgets/item/option_item.dart';
import 'package:konsuldoc/presentations/widgets/pagination/paginated_child_builder_delegate.dart';
import 'package:konsuldoc/presentations/widgets/pagination/paginated_view.dart';

@RoutePage()
class AppointmentListPage extends ConsumerStatefulWidget {
  const AppointmentListPage({super.key});

  @override
  ConsumerState<AppointmentListPage> createState() =>
      _AppointmentListPageState();
}

class _AppointmentListPageState extends ConsumerState<AppointmentListPage> {
  final _pagingController =
      PagingController<DateTime?, Appointment>(firstPageKey: null);
  AppointmentFilter filter = AppointmentFilter.upcoming;

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<List<Appointment>> fetchData(DateTime? after, int perPage) {
    return ref.read(appointmentRepositoryProvider).fetch(
          memberId: ref.read(authStateProvider)?.id,
          filter: filter,
          after: after,
          perPage: perPage,
        );
  }

  void updateFilter(AppointmentFilter value) {
    if (value == filter) return;

    setState(() {
      filter = value;
    });
    _pagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(14).copyWith(bottom: 0),
              child: Text(
                'Daftar janji temu',
                style: theme.textTheme.titleMedium,
              ),
            ),
            SizedBox(
              height: 63,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(7),
                child: Row(
                  children: [
                    ...(AppointmentFilter.values.map(
                      (e) => OptionItem(
                        selected: filter == e,
                        onPressed: () => updateFilter(e),
                        label: e.label,
                      ),
                    ))
                  ],
                ),
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: PaginatedView(
                pagingController: _pagingController,
                perPage: 10,
                fetchData: fetchData,
                getPageKey: (lastPage, items) => items.lastOrNull?.date,
                child: PagedListView(
                  pagingController: _pagingController,
                  builderDelegate: PaginatedChildBuilderDelegate(
                    itemBuilder: (context, item, index) {
                      return ListItem(
                        onTap: () {
                          context.pushRoute(
                            AppointmentDetailRoute(id: item.id),
                          );
                        },
                        avatar: item.doctor.avatar,
                        title: item.doctor.name,
                        subtitle: item.doctor.specialist.label,
                        bottom: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.schedule, size: 15),
                            const SizedBox(width: 3.5),
                            Text(
                              item.date.toTimeString(),
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              item.date.toDateString(),
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 7),
                          ],
                        ),
                      );
                    },
                    pagingController: _pagingController,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
