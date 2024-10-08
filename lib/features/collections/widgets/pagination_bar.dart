import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tmz_damz/data/models/access_control_permission_map.dart';
import 'package:tmz_damz/data/models/pagination_info.dart';
import 'package:tmz_damz/features/collections/bloc/bloc.dart';
import 'package:tmz_damz/features/collections/widgets/create_collection_modal.dart';
import 'package:tmz_damz/shared/widgets/change_notifier_listener.dart';
import 'package:tmz_damz/shared/widgets/dropdown_selector.dart';
import 'package:tmz_damz/utils/route_change_notifier.dart';

class PaginationBar extends StatelessWidget {
  static final kResultsPerPage = [10, 25, 50, 100, 250];
  static const kDefaultResultsPerPage = 100;

  final AccessControlPermissionMapModel? permissions;

  const PaginationBar({
    super.key,
    required this.permissions,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionsBloc, BlocState>(
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
              _buildNewCollectionButton(
                context: context,
                theme: theme,
              ),
              const SizedBox(width: 20.0),
              Text(
                'Collections',
                style: theme.textTheme.labelMedium,
              ),
              const SizedBox(width: 10.0),
              Text(
                '( ${NumberFormat('#,##0').format(
                  paginationInfo.totalRecords,
                )} )',
                style: theme.textTheme.labelMedium,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                          constraints: constraints,
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
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(width: 10.0),
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
        );
      },
    );
  }

  Widget _buildNewCollectionButton({
    required BuildContext context,
    required ThemeData theme,
  }) {
    return TextButton(
      onPressed: () async {
        await _showCreateCollectionDialog(
          context: context,
          theme: theme,
        );
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          const Color(0xFF11853F),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 6.0,
          ),
        ),
        shape: WidgetStateProperty.resolveWith(
          (states) {
            return RoundedRectangleBorder(
              side: const BorderSide(
                color: Color(0xB0000000),
              ),
              borderRadius: BorderRadius.circular(6.0),
            );
          },
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 8.0,
        ),
        child: Text(
          'New',
          style: theme.textTheme.bodySmall,
        ),
      ),
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
              BlocProvider.of<CollectionsBloc>(context).add(
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
              BlocProvider.of<CollectionsBloc>(context).add(
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
              BlocProvider.of<CollectionsBloc>(context).add(
                PaginationChangedEvent(
                  offset: paginationInfo.nextPageOffset(),
                  limit: paginationInfo.limit,
                ),
              );
            }
          : null,
      style: Theme.of(context).textButtonTheme.style?.copyWith(
            backgroundColor: WidgetStateProperty.all(
              Colors.transparent,
            ),
            padding: WidgetStateProperty.all(const EdgeInsets.all(14.0)),
            shape: WidgetStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
            ),
          ),
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
    required BoxConstraints constraints,
    required ThemeData theme,
    required PaginationInfo paginationInfo,
  }) {
    var maxPageButtons = 0;

    if (constraints.maxWidth > 900) {
      maxPageButtons = 6;
    } else if (constraints.maxWidth > 800) {
      maxPageButtons = 5;
    } else if (constraints.maxWidth > 700) {
      maxPageButtons = 4;
    } else if (constraints.maxWidth > 600) {
      maxPageButtons = 3;
    } else if (constraints.maxWidth > 500) {
      maxPageButtons = 2;
    } else if (constraints.maxWidth > 400) {
      maxPageButtons = 1;
    }

    final pageButtonCount =
        min(paginationInfo.totalPages, (maxPageButtons * 2) + 1);

    var firstPage = max(paginationInfo.currentPage - maxPageButtons, 0);

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
                      BlocProvider.of<CollectionsBloc>(context).add(
                        PaginationChangedEvent(
                          offset: page * paginationInfo.limit,
                          limit: paginationInfo.limit,
                        ),
                      );
                    }
                  : null,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Colors.transparent,
                ),
                minimumSize: WidgetStateProperty.all(const Size(48, 48)),
                maximumSize: WidgetStateProperty.all(const Size(48, 48)),
                padding: WidgetStateProperty.all(EdgeInsets.zero),
                shape: WidgetStateProperty.all(
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
              BlocProvider.of<CollectionsBloc>(context).add(
                PaginationChangedEvent(
                  offset: paginationInfo.previousPageOffset(),
                  limit: paginationInfo.limit,
                ),
              );
            }
          : null,
      style: Theme.of(context).textButtonTheme.style?.copyWith(
            backgroundColor: WidgetStateProperty.all(
              Colors.transparent,
            ),
            padding: WidgetStateProperty.all(const EdgeInsets.all(14.0)),
            shape: WidgetStateProperty.all(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
            ),
          ),
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

          BlocProvider.of<CollectionsBloc>(context).add(
            PaginationChangedEvent(
              offset: 0,
              limit: value,
            ),
          );
        },
      ),
    );
  }

  Future<void> _showCreateCollectionDialog({
    required BuildContext context,
    required ThemeData theme,
  }) async {
    final notifier = Provider.of<RouteChangeNotifier>(
      context,
      listen: false,
    );

    await showDialog<void>(
      context: context,
      barrierColor: Colors.black54,
      barrierDismissible: false,
      builder: (_) {
        return ChangeNotifierListener(
          notifier: notifier,
          listener: () {
            Navigator.of(context).pop();
          },
          child: OverflowBox(
            minWidth: 600.0,
            maxWidth: 600.0,
            child: Center(
              child: CreateCollectionModal(
                theme: theme,
                permissions: permissions,
                onCancel: () {
                  Navigator.of(context).pop();
                },
                onCreate: (params) {
                  BlocProvider.of<CollectionsBloc>(context).add(
                    CreateCollectionEvent(
                      name: params.name,
                      description: params.description,
                      isPrivate: params.isPrivate,
                      autoClear: params.autoClear,
                      addToFavorites: params.addToFavorites,
                    ),
                  );

                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
