import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:konsuldoc/core/utils/handle_error.dart';

class PaginatedView<K, T> extends StatefulWidget {
  final PagingController<K, T> pagingController;
  final int perPage;
  final Future<List<T>> Function(K pageKey, int perPage) fetchData;
  final K Function(K? lastPage, List<T> items) getPageKey;
  final Widget child;

  const PaginatedView({
    super.key,
    required this.pagingController,
    required this.perPage,
    required this.fetchData,
    required this.getPageKey,
    required this.child,
  });

  @override
  State<PaginatedView<K, T>> createState() => _PaginatedViewState<K, T>();
}

class _PaginatedViewState<K, T> extends State<PaginatedView<K, T>> {
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
        return true;

      default:
        return false;
    }
  }

  void _fetch(K page) async {
    final result = await handleError(widget.fetchData(page, widget.perPage));
    if (!mounted) return;

    result.fold(
      (error) => widget.pagingController.error = error.message,
      (data) {
        if (data.length < widget.perPage) {
          widget.pagingController.appendLastPage(data);
        } else {
          widget.pagingController
              .appendPage(data, widget.getPageKey(page, data));
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
