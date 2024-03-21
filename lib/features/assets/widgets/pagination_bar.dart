import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/features/assets/bloc/bloc.dart';
import 'package:tmz_damz/shared/widgets/dropdown_selector.dart';

class PaginationBar extends StatelessWidget {
  static final kResultsPerPage = [10, 25, 50, 100, 250];
  static const kDefaultResultsPerPage = 100;

  const PaginationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetsBloc, BlocState>(
      buildWhen: (_, state) => state is PaginationChangedState,
      builder: (context, state) {
        PaginationInfo paginationInfo;

        if (state is PaginationChangedState) {
          paginationInfo = PaginationInfo.fromOffsetLimit(
            offset: state.offset,
            limit: state.limit,
            totalRecords: state.totalRecords,
          );
        } else {
          paginationInfo = PaginationInfo.fromOffsetLimit(
            offset: 0,
            limit: kDefaultResultsPerPage,
            totalRecords: 0,
          );
        }

        final theme = Theme.of(context);

        return Container(
          decoration: const BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: Color(0xFF454647),
              ),
            ),
            color: Color(0xFF353637),
          ),
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 2.0,
            right: 10.0,
            bottom: 2.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        'Assets',
                        style: theme.textTheme.labelMedium,
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        '( ${NumberFormat('#,##0').format(
                          paginationInfo.totalRecords,
                        )} )',
                        style: theme.textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              ),
              _buildFirstPageButton(
                context: context,
                paginationInfo: paginationInfo,
              ),
              const SizedBox(width: 10),
              _buildPreviousPageButton(
                context: context,
                paginationInfo: paginationInfo,
              ),
              const SizedBox(width: 10),
              ..._buildPageButtons(
                context: context,
                theme: theme,
                paginationInfo: paginationInfo,
              ),
              const SizedBox(width: 10),
              _buildNextPageButton(
                context: context,
                paginationInfo: paginationInfo,
              ),
              const SizedBox(width: 10),
              _buildLastPageButton(
                context: context,
                paginationInfo: paginationInfo,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Results per page:',
                        style: theme.textTheme.labelMedium,
                      ),
                      const SizedBox(width: 10),
                      _buildResultsPerPageSelector(
                        context: context,
                        paginationInfo: paginationInfo,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFirstPageButton({
    required BuildContext context,
    required PaginationInfo paginationInfo,
  }) {
    final enabled = paginationInfo.currentPage > 0;

    return IconButton(
      onPressed: enabled
          ? () {
              BlocProvider.of<AssetsBloc>(context).add(
                PaginationChangedEvent(
                  offset: 0,
                  limit: paginationInfo.limit,
                ),
              );
            }
          : null,
      icon: Icon(
        MdiIcons.chevronDoubleLeft,
        color: enabled ? const Color(0x99FFFFFF) : const Color(0x40FFFFFF),
      ),
    );
  }

  Widget _buildLastPageButton({
    required BuildContext context,
    required PaginationInfo paginationInfo,
  }) {
    final enabled =
        paginationInfo.currentPage < (paginationInfo.totalPages - 1);

    return IconButton(
      onPressed: enabled
          ? () {
              BlocProvider.of<AssetsBloc>(context).add(
                PaginationChangedEvent(
                  offset: paginationInfo.lastPageOffset(),
                  limit: paginationInfo.limit,
                ),
              );
            }
          : null,
      icon: Icon(
        MdiIcons.chevronDoubleRight,
        color: enabled ? const Color(0x99FFFFFF) : const Color(0x40FFFFFF),
      ),
    );
  }

  Widget _buildNextPageButton({
    required BuildContext context,
    required PaginationInfo paginationInfo,
  }) {
    final enabled =
        paginationInfo.currentPage < (paginationInfo.totalPages - 1);

    return TextButton(
      onPressed: enabled
          ? () {
              BlocProvider.of<AssetsBloc>(context).add(
                PaginationChangedEvent(
                  offset: paginationInfo.nextPageOffset(),
                  limit: paginationInfo.limit,
                ),
              );
            }
          : null,
      child: Text(
        'NEXT',
        style: TextStyle(
          color: enabled ? const Color(0x99FFFFFF) : const Color(0x40FFFFFF),
        ),
      ),
    );
  }

  List<Widget> _buildPageButtons({
    required BuildContext context,
    required ThemeData theme,
    required PaginationInfo paginationInfo,
  }) {
    final pageButtonCount = min(paginationInfo.totalPages, 7);
    var firstPage = max(paginationInfo.currentPage - 3, 0);

    if (paginationInfo.currentPage > paginationInfo.totalPages - 4) {
      firstPage = max(paginationInfo.totalPages - pageButtonCount, 0);
    }

    return List.generate(
      pageButtonCount,
      (index) {
        final page = firstPage + index;
        final selected = page == paginationInfo.currentPage;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: selected ? const Color(0x29FA6060) : null,
              shape: BoxShape.circle,
            ),
            child: TextButton(
              onPressed: !selected
                  ? () {
                      BlocProvider.of<AssetsBloc>(context).add(
                        PaginationChangedEvent(
                          offset: page * paginationInfo.limit,
                          limit: paginationInfo.limit,
                        ),
                      );
                    }
                  : null,
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(48, 48)),
                maximumSize: MaterialStateProperty.all(const Size(48, 48)),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1000),
                  ),
                ),
              ),
              child: Text(
                '${page + 1}',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: !selected ? const Color(0x99FFFFFF) : null,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPreviousPageButton({
    required BuildContext context,
    required PaginationInfo paginationInfo,
  }) {
    final enabled = paginationInfo.currentPage > 0;

    return TextButton(
      onPressed: enabled
          ? () {
              BlocProvider.of<AssetsBloc>(context).add(
                PaginationChangedEvent(
                  offset: paginationInfo.previousPageOffset(),
                  limit: paginationInfo.limit,
                ),
              );
            }
          : null,
      child: Text(
        'PREV',
        style: TextStyle(
          color: enabled ? const Color(0x99FFFFFF) : const Color(0x40FFFFFF),
        ),
      ),
    );
  }

  Widget _buildResultsPerPageSelector({
    required BuildContext context,
    required PaginationInfo paginationInfo,
  }) {
    return SizedBox(
      width: 100,
      child: DropdownSelector<int>(
        initialValue: paginationInfo.limit,
        items: kResultsPerPage,
        itemBuilder: (value) {
          return Text(value.toString());
        },
        onSelectionChanged: (value) {
          if (value == null) {
            return;
          }

          BlocProvider.of<AssetsBloc>(context).add(
            PaginationChangedEvent(
              offset: 0,
              limit: value,
            ),
          );
        },
      ),
    );
  }
}

class PaginationInfo {
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
      totalPages: (totalRecords / limit).ceil(),
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
