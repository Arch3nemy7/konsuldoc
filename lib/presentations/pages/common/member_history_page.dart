import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:konsuldoc/core/dependencies/repositories.dart';
import 'package:konsuldoc/core/router/doctor_router.gr.dart' as doctor_router;
import 'package:konsuldoc/core/router/member_router.gr.dart' as member_router;
import 'package:konsuldoc/core/utils/comparator.dart';
import 'package:konsuldoc/core/utils/formatter.dart';
import 'package:konsuldoc/domain/entities/appointment.dart';
import 'package:konsuldoc/domain/enums/role.dart';
import 'package:konsuldoc/presentations/providers/user_role_provider.dart';
import 'package:konsuldoc/presentations/widgets/item/list_item.dart';
import 'package:konsuldoc/presentations/widgets/pagination/paginated_child_builder_delegate.dart';
import 'package:konsuldoc/presentations/widgets/pagination/paginated_view.dart';

@RoutePage()
class MemberHistoryPage extends ConsumerStatefulWidget {
  final String id;

  const MemberHistoryPage({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<MemberHistoryPage> createState() => _MemberHistoryPageState();
}

class _MemberHistoryPageState extends ConsumerState<MemberHistoryPage> {
  final _pagingController = PagingController<int, Appointment>(firstPageKey: 1);
  late final dates = getNextFiveDays();
  DateTime date = DateTime.now();

  bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  List<DateTime> getNextFiveDays() {
    List<DateTime> weekdays = [];
    DateTime currentDate = DateTime.now();

    while (weekdays.length < 5) {
      if (!isWeekend(currentDate)) {
        weekdays.add(currentDate);
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return weekdays;
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<List<Appointment>> fetchData(int page, int perPage) {
    return ref.read(appointmentRepositoryProvider).fetch(
          memberId: widget.id,
          page: page,
          perPage: perPage,
        );
  }

  void updateDate(DateTime value) {
    if (date.isSameDate(value)) return;

    setState(() {
      date = value;
    });
    _pagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final role = ref.watch(userRoleProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        centerTitle: true,
        leading: const AutoLeadingButton(),
      ),
      body: PaginatedView(
        pagingController: _pagingController,
        perPage: 10,
        fetchData: fetchData,
        child: PagedListView(
          pagingController: _pagingController,
          builderDelegate: PaginatedChildBuilderDelegate(
            itemBuilder: (context, item, index) {
              return ListItem(
                onTap: () {
                  if(role == Role.member) {
                    context.pushRoute(
                    member_router.AppointmentDetailRoute(id: item.id),
                  );
                  } else {
                    context.pushRoute(
                    doctor_router.AppointmentDetailRoute(id: item.id),
                  );
                  }
                },
                avatar: item.member.avatar,
                title: item.member.name,
                bottom: Row(
                  children: [
                    Text(
                      "Sesi ${item.number}",
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      item.date.toDateString(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                trailing: Text("#${item.number.toString()}"),
              );
            },
            pagingController: _pagingController,
          ),
        ),
      ),
    );
  }
}
