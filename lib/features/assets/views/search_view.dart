import 'package:auto_route/annotations.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmz_mam_flutter/data/models/inventory.dart';
import 'package:tmz_mam_flutter/data/models/inventory_sort_field_enum.dart';
import 'package:tmz_mam_flutter/data/models/sort_direction_enum.dart';
import 'package:tmz_mam_flutter/features/assets/bloc/bloc.dart';
import 'package:tmz_mam_flutter/features/assets/views/inventory_details_view.dart';
import 'package:tmz_mam_flutter/features/assets/widgets/inventory_data_view.dart';
import 'package:tmz_mam_flutter/features/assets/widgets/layout_mode_selector.dart';
import 'package:tmz_mam_flutter/features/assets/widgets/pagination_bar.dart';
import 'package:tmz_mam_flutter/features/assets/widgets/thumbnail_size_selector.dart';
import 'package:tmz_mam_flutter/features/assets/widgets/toolbar.dart';
import 'package:tmz_mam_flutter/shared/widgets/app_scaffold/app_scaffold.dart';
import 'package:tmz_mam_flutter/shared/widgets/toast.dart';

@RoutePage(name: 'AssetsSearchRoute')
class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  ScrollController? _scrollController;
  InventorySortFieldEnum? _sortField;
  SortDirectionEnum _sortDirection = SortDirectionEnum.descending;
  LayoutModeEnum _layoutMode = LayoutModeEnum.tile;
  ThumbnailSizeEnum _thumbnailSize = ThumbnailSizeEnum.medium;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    _scrollController = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      content: BlocProvider<AssetsBloc>(
        create: (context) {
          final bloc = GetIt.instance<AssetsBloc>();

          bloc.add(
            PaginationChangedEvent(
              limit: 10,
              offset: 0,
            ),
          );

          return bloc;
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlocBuilder<AssetsBloc, BlocState>(
                    builder: (context, state) {
                      return Toolbar(
                        sortField: _sortField,
                        sortDirection: _sortDirection,
                        layoutMode: _layoutMode,
                        thumbnailSize: _thumbnailSize,
                        onSearch: (searchTerm) {
                          BlocProvider.of<AssetsBloc>(context).add(
                            SearchEvent(
                              sortField: _sortField,
                              sortDirection: _sortDirection,
                              searchTerm: searchTerm,
                            ),
                          );
                        },
                        onSortChanged: (field, direction) {
                          setState(() {
                            _sortField = field;
                            _sortDirection = direction;
                          });
                        },
                        onLayoutChange: (mode) {
                          setState(() => _layoutMode = mode);
                        },
                        onThumbnailSizeChange: (size) {
                          setState(() => _thumbnailSize = size);
                        },
                      );
                    },
                  ),
                  const PaginationBar(),
                  Expanded(
                    child: _buildSearchResults(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return BlocBuilder<AssetsBloc, BlocState>(
      buildWhen: (_, state) =>
          state is SearchFailureState ||
          state is SearchResultsLoadedState ||
          state is SearchResultsLoadingState,
      builder: (context, state) {
        if (state is SearchFailureState) {
          Toast.showNotification(
            showDuration: const Duration(seconds: 8),
            type: ToastTypeEnum.error,
            title: 'Failed to Load Results',
            message: state.failure.message,
          );

          return Center(
            child: Text('Error: ${state.failure.message}'),
          );
        } else if (state is SearchResultsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchResultsLoadedState) {
          if (state.items.isNotEmpty) {
            return _buildLoadedState(
              context: context,
              items: state.items,
            );
          } else {
            return const Center(
              child: Text('No Results'),
            );
          }
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildLoadedState({
    required BuildContext context,
    required List<InventoryModel> items,
  }) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: InventoryDataView(
        scrollController: _scrollController ?? ScrollController(),
        items: items,
        layoutMode: _layoutMode,
        thumbnailSize: _thumbnailSize,
        onItemClicked: (model) {
          BlocProvider.of<AssetsBloc>(context).add(
            LoadInventoryDetailsEvent(
              itemID: model.id,
            ),
          );

          BotToast.showAnimationWidget(
            crossPage: false,
            onlyOne: true,
            animationDuration: const Duration(milliseconds: 150),
            wrapToastAnimation: (controller, cancelFunc, child) {
              return child
                  .animate(
                    controller: controller,
                  )
                  .move(
                    curve: Curves.decelerate,
                    begin: const Offset(300, 0),
                    end: Offset.zero,
                  )
                  .fadeIn(
                    curve: Curves.decelerate,
                    begin: 0.0,
                  );
            },
            toastBuilder: (cancelFunc) {
              return _buildInventoryDetailsDrawer(
                context: context,
                cancelFunc: cancelFunc,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildInventoryDetailsDrawer({
    required BuildContext context,
    required void Function() cancelFunc,
  }) {
    return Stack(
      children: [
        GestureDetector(
          onTap: cancelFunc,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: 800,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 16,
                        offset: const Offset(-4, 0),
                      ),
                    ],
                    color: const Color(0xFF232323),
                  ),
                  child: MouseRegion(
                    child: _buildInventoryDetailsPanel(
                      context: context,
                      cancelFunc: cancelFunc,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInventoryDetailsPanel({
    required BuildContext context,
    required void Function() cancelFunc,
  }) {
    return Material(
      child: BlocProvider<AssetsBloc>.value(
        value: BlocProvider.of<AssetsBloc>(context),
        child: BlocListener<AssetsBloc, BlocState>(
          listenWhen: (_, state) => state is InventoryDetailsFailureState,
          listener: (context, state) {
            if (state is InventoryDetailsFailureState) {
              Toast.showNotification(
                showDuration: const Duration(seconds: 8),
                type: ToastTypeEnum.error,
                title: 'Failed to Load Details',
                message: state.failure.message,
              );

              cancelFunc();
            }
          },
          child: BlocBuilder<AssetsBloc, BlocState>(
            buildWhen: (_, state) =>
                state is InventoryDetailsLoadedState ||
                state is InventoryDetailsLoadingState,
            builder: (context, state) {
              if (state is InventoryDetailsLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is InventoryDetailsLoadedState) {
                return InventoryDetailsView(
                  model: state.model,
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}