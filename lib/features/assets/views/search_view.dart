import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/data/models/asset_sort_field_enum.dart';
import 'package:tmz_damz/data/models/sort_direction_enum.dart';
import 'package:tmz_damz/features/asset_details/views/asset_details_drawer.dart';
import 'package:tmz_damz/features/assets/bloc/bloc.dart';
import 'package:tmz_damz/features/assets/widgets/asset_data_view.dart';
import 'package:tmz_damz/features/assets/widgets/layout_mode_selector.dart';
import 'package:tmz_damz/features/assets/widgets/pagination_bar.dart';
import 'package:tmz_damz/features/assets/widgets/thumbnail_size_selector.dart';
import 'package:tmz_damz/features/assets/widgets/toolbar.dart';
import 'package:tmz_damz/features/user_collections/widgets/add_assets_to_collection.dart';
import 'package:tmz_damz/features/user_collections/widgets/user_collections.dart';
import 'package:tmz_damz/shared/widgets/masked_scroll_view.dart';
import 'package:tmz_damz/shared/widgets/toast.dart';
import 'package:tmz_damz/utils/config.dart';

@RoutePage(name: 'AssetsSearchRoute')
class SearchView extends StatefulWidget {
  final String? collectionID;
  final bool? refresh;

  const SearchView({
    super.key,
    @PathParam('collectionID') this.collectionID,
    @PathParam('refresh') this.refresh,
  });

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  static const kDefaultResultsPerPage = 100;

  ScrollController? _scrollController;
  AssetSortFieldEnum _sortField = AssetSortFieldEnum.createdAt;
  SortDirectionEnum _sortDirection = SortDirectionEnum.descending;
  LayoutModeEnum _layoutMode = LayoutModeEnum.tile;
  ThumbnailSizeEnum _thumbnailSize = ThumbnailSizeEnum.medium;
  int _lastStateHash = 0;
  bool _favoritesVisible = false;
  bool _assetDetailsVisible = false;
  List<String> _selectIDs = [];
  AssetDetailsModel? _currentModel;

  @override
  void dispose() {
    _scrollController?.dispose();
    _scrollController = null;

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AssetsBloc>(
      create: (context) {
        final bloc = GetIt.instance<AssetsBloc>();

        bloc.add(
          PaginationChangedEvent(
            limit: kDefaultResultsPerPage,
            offset: 0,
          ),
        );

        return bloc;
      },
      child: BlocListener<AssetsBloc, BlocState>(
        listenWhen: (_, state) =>
            state is AddAssetsToCollectionFailureState ||
            state is AddAssetsToCollectionSuccessState ||
            state is SearchFailureState,
        listener: (context, state) {
          if (state is AddAssetsToCollectionFailureState) {
            Toast.showNotification(
              showDuration: const Duration(seconds: 5),
              type: ToastTypeEnum.error,
              title: 'Failed to Add Assets to Collection',
              message: state.failure.message,
            );
          } else if (state is AddAssetsToCollectionSuccessState) {
            Toast.showNotification(
              showDuration: const Duration(seconds: 5),
              type: ToastTypeEnum.success,
              message: 'Assets Added to Collection',
            );
          } else if (state is SearchFailureState) {
            Toast.showNotification(
              showDuration: const Duration(seconds: 5),
              type: ToastTypeEnum.error,
              title: 'Failed to Load Results',
              message: state.failure.message,
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildToolbar(),
            const PaginationBar(),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlocBuilder<AssetsBloc, BlocState>(
                    builder: (context, state) => _buildCollections(context),
                  ),
                  _buildCollectionsSplitter(),
                  Expanded(
                    child: _buildSearchResults(),
                  ),
                  if (_currentModel != null) _buildAssetDetailsSplitter(),
                  _buildAssetDetails(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetDetails() {
    return AnimatedCrossFade(
      firstCurve: Curves.decelerate,
      secondCurve: Curves.decelerate,
      sizeCurve: Curves.fastOutSlowIn,
      crossFadeState: _assetDetailsVisible
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: kThemeAnimationDuration,
      firstChild: const SizedBox(height: 0.0),
      secondChild: AssetDetailsDrawer(
        key: ValueKey(_currentModel?.id),
        model: _currentModel,
        onClose: () {
          setState(() {
            _assetDetailsVisible = false;
          });
        },
      ),
    );
  }

  Widget _buildAssetDetailsSplitter() {
    return Container(
      width: 10.0,
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(),
          right: BorderSide(),
        ),
      ),
      child: IconButton(
        onPressed: () {
          setState(() {
            _assetDetailsVisible = !_assetDetailsVisible;
          });
        },
        padding: EdgeInsets.zero,
        style: Theme.of(context).textButtonTheme.style?.copyWith(
              backgroundColor: MaterialStateProperty.all(
                const Color(0xFF353637),
              ),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(),
              ),
            ),
        icon: Transform.translate(
          offset: const Offset(-3.0, 0.0),
          child: Icon(
            !_assetDetailsVisible ? MdiIcons.menuLeft : MdiIcons.menuRight,
            size: 14.0,
          ),
        ),
      ),
    );
  }

  Widget _buildCollections(BuildContext blocContext) {
    return AnimatedCrossFade(
      firstCurve: Curves.decelerate,
      secondCurve: Curves.decelerate,
      sizeCurve: Curves.fastOutSlowIn,
      crossFadeState: _favoritesVisible
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: kThemeAnimationDuration,
      firstChild: const SizedBox(height: 0.0),
      secondChild: Container(
        width: 300.0,
        color: const Color(0xFF333333),
        child: UserCollections(
          onAddSelectedAssetsToCollection: _selectIDs.isNotEmpty
              ? () {
                  showDialog<void>(
                    context: context,
                    barrierColor: Colors.black26,
                    barrierDismissible: false,
                    builder: (context) {
                      final theme = Theme.of(context);

                      return Center(
                        child: AddAssetsToCollection(
                          theme: theme,
                          onCancel: () {
                            Navigator.of(context).pop();
                          },
                          onConfirm: (collectionID) {
                            if (_selectIDs.isEmpty) {
                              return;
                            }

                            BlocProvider.of<AssetsBloc>(blocContext).add(
                              AddAssetsToCollectionEvent(
                                collectionID: collectionID,
                                assetIDs: _selectIDs,
                              ),
                            );

                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                  );
                }
              : null,
          onCollectionTap: (model) {
            //
          },
        ),
      ),
    );
  }

  Widget _buildCollectionsSplitter() {
    return Container(
      width: 10.0,
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(),
          right: BorderSide(),
        ),
      ),
      child: IconButton(
        onPressed: () {
          setState(() {
            _favoritesVisible = !_favoritesVisible;
          });
        },
        padding: EdgeInsets.zero,
        style: Theme.of(context).textButtonTheme.style?.copyWith(
              backgroundColor: MaterialStateProperty.all(
                const Color(0xFF353637),
              ),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(),
              ),
            ),
        icon: Transform.translate(
          offset: const Offset(-3.0, 0.0),
          child: Icon(
            !_favoritesVisible ? MdiIcons.menuRight : MdiIcons.menuLeft,
            size: 14.0,
          ),
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
          return Center(
            child: Text('Error: ${state.failure.message}'),
          );
        } else if (state is SearchResultsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchResultsLoadedState) {
          if (state.assets.isNotEmpty) {
            return MaskedScrollView(
              controller: _scrollController,
              padding: EdgeInsets.zero,
              child: AssetDataView(
                scrollController: _scrollController ?? ScrollController(),
                config: GetIt.instance<Config>(),
                assets: state.assets,
                layoutMode: _layoutMode,
                thumbnailSize: _thumbnailSize,
                onItemClicked: (model) {
                  setState(() {
                    if (_currentModel == null) {
                      _assetDetailsVisible = true;
                    }
                    _currentModel = model;
                  });
                },
                onSelectionChanged: (selectedIDs) {
                  setState(() {
                    _selectIDs = selectedIDs;
                  });
                },
              ),
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

  Widget _buildToolbar() {
    return BlocBuilder<AssetsBloc, BlocState>(
      builder: (context, state) {
        if (widget.refresh ?? false) {
          if ((state is SearchResultsLoadedState) &&
              (_lastStateHash == state.hashCode)) {
            BlocProvider.of<AssetsBloc>(context).add(
              RefreshEvent(),
            );
          }
        }

        if (state is SearchResultsLoadedState) {
          _lastStateHash = state.hashCode;
        }

        return Toolbar(
          sortField: _sortField,
          sortDirection: _sortDirection,
          layoutMode: _layoutMode,
          thumbnailSize: _thumbnailSize,
          onReload: () {
            BlocProvider.of<AssetsBloc>(context).add(
              ReloadCurrentPageEvent(),
            );
          },
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

            BlocProvider.of<AssetsBloc>(context).add(
              SearchEvent(
                sortField: _sortField,
                sortDirection: _sortDirection,
              ),
            );
          },
          onLayoutChange: (mode) {
            setState(() {
              _layoutMode = mode;
            });
          },
          onThumbnailSizeChange: (size) {
            setState(() {
              _thumbnailSize = size;
            });
          },
        );
      },
    );
  }
}
