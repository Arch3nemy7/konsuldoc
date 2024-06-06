import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:konsuldoc/presentations/widgets/error_view.dart';
import 'package:konsuldoc/presentations/widgets/loader.dart';

class PaginatedChildBuilderDelegate<PageKeyType, ItemType>
    extends PagedChildBuilderDelegate<ItemType> {
  final String? emptyTitle;
  final String emptyMessage;

  PaginatedChildBuilderDelegate({
    double? loaderHeight,
    this.emptyTitle,
    this.emptyMessage = 'Tidak menemukan data',
    required super.itemBuilder,
    required PagingController<PageKeyType, ItemType> pagingController,
  }) : super(
          noItemsFoundIndicatorBuilder: (context) => ErrorView(
            icon: Image.asset('assets/images/not-found.png'),
            title: emptyTitle,
            message: emptyMessage,
          ),
          firstPageProgressIndicatorBuilder: (context) => SizedBox(
            height: loaderHeight,
            child: const Loader(),
          ),
          firstPageErrorIndicatorBuilder: (context) => ErrorView(
            message: pagingController.error.toString(),
            onRetry: pagingController.retryLastFailedRequest,
          ),
          newPageErrorIndicatorBuilder: (context) => ErrorView(
            message: pagingController.error.toString(),
          ),
        );
}
