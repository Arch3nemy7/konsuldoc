import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:konsuldoc/core/utils/handle_error.dart';

class PaginatedView<T> extends StatefulWidget {
  final PagingController<int, T> pagingController;
  final int perPage;
  final Future<List<T>> Function(int page, int perPage) fetchData;
  final Widget child;

  const PaginatedView({
    super.key,
    required this.pagingController,
    required this.perPage,
    required this.fetchData,
    required this.child,
  });

  @override
  State<PaginatedView<T>> createState() => _PaginatedViewState<T>();
}

class _PaginatedViewState<T> extends State<PaginatedView<T>> {
  bool refreshable = false;

  @override
  void initState() {
    super.initState();
    widget.pagingController.addPageRequestListener((pageKey) {
      _fetch(pageKey);
    });
    widget.pagingController.addStatusListener((status) {
      final newStatus = isRefreshable(status);
      if (newStatus == refreshable) return;

      setState(() {
        refreshable = newStatus;
      });
    });
  }

  bool isRefreshable(PagingStatus status) {
    switch (status) {
      case PagingStatus.completed:
      case PagingStatus.ongoing:
      case PagingStatus.subsequentPageError:
      case PagingStatus.noItemsFound:
        return true;

      default:
        return false;
    }
  }

  void _fetch(int page) async {
    final result = await handleError(widget.fetchData(page, widget.perPage));
    if (!mounted) return;

    result.fold(
      (error) => widget.pagingController.error = error.message,
      (data) {
        if (data.length < widget.perPage) {
          widget.pagingController.appendLastPage(data);
        } else {
          widget.pagingController.appendPage(data, page + 1);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      notificationPredicate: (_) => refreshable,
      onRefresh: () => Future.sync(widget.pagingController.refresh),
      child: widget.child,
    );
  }
}
