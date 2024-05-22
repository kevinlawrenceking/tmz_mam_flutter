import 'dart:math';

class PaginationInfo {
  static const kMaxResults = 15000;

  final int currentPage;
  final int limit;
  final int totalPages;
  final int totalRecords;

  PaginationInfo({
    required this.currentPage,
    required this.limit,
    required this.totalPages,
    required this.totalRecords,
  });

  factory PaginationInfo.fromOffsetLimit({
    required int offset,
    required int limit,
    required int totalRecords,
  }) {
    final info = PaginationInfo(
      currentPage: (offset / limit).floor(),
      limit: limit,
      totalPages: (min(totalRecords, kMaxResults) / limit).ceil(),
      totalRecords: totalRecords,
    );

    return info;
  }

  int currentPageOffset() => max(
        currentPage * limit,
        0,
      );

  int lastPageOffset() => max(
        (totalPages - 1) * limit,
        0,
      );

  int nextPageOffset() => min(
        (currentPage + 1) * limit,
        totalPages * limit,
      );

  int previousPageOffset() => max(
        (currentPage - 1) * limit,
        0,
      );
}
