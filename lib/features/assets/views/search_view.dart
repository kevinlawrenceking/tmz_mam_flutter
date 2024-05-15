import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/data/models/asset_sort_field_enum.dart';
import 'package:tmz_damz/data/models/sort_direction_enum.dart';
import 'package:tmz_damz/features/asset_details/widgets/asset_details.dart';
import 'package:tmz_damz/features/assets/bloc/bloc.dart';
import 'package:tmz_damz/features/assets/widgets/asset_data_view.dart';
import 'package:tmz_damz/features/assets/widgets/layout_mode_selector.dart';
import 'package:tmz_damz/features/assets/widgets/pagination_bar.dart';
import 'package:tmz_damz/features/assets/widgets/thumbnail_size_selector.dart';
import 'package:tmz_damz/features/assets/widgets/toolbar.dart';
import 'package:tmz_damz/features/user_collections/widgets/add_assets_to_collection_modal.dart';
import 'package:tmz_damz/features/user_collections/widgets/user_collections.dart';
import 'package:tmz_damz/shared/widgets/confirmation_prompt.dart';
import 'package:tmz_damz/shared/widgets/toast.dart';
import 'package:tmz_damz/utils/config.dart';

@RoutePage(name: 'AssetsSearchRoute')
class SearchView extends StatefulWidget {
  final String? collectionID;

  const SearchView({
    super.key,
    @PathParam('collectionID') this.collectionID,
  });

  @override
  State<SearchView> createState() => _SearchViewState();

  static bool refreshResults = false;
}

class _SearchViewState extends State<SearchView> {
  static const kDefaultResultsPerPage = 100;

  late final ScrollController _scrollController;
  late final TextEditingController _searchTermController;

  String _searchTerm = '';
  AssetSortFieldEnum _sortField = AssetSortFieldEnum.createdAt;
  SortDirectionEnum _sortDirection = SortDirectionEnum.descending;
  LayoutModeEnum _layoutMode = LayoutModeEnum.tile;
  ThumbnailSizeEnum _thumbnailSize = ThumbnailSizeEnum.medium;

  bool _favoritesVisible = false;
  bool _assetDetailsVisible = false;

  String? _collectionID;
  List<String> _selectedIDs = [];
  AssetDetailsModel? _currentModel;

  @override
  void dispose() {
    _scrollController.dispose();
    _searchTermController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _searchTermController = TextEditingController();
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
      child: _buildAssetsBlocListener(
        child: BlocBuilder<AssetsBloc, BlocState>(
          buildWhen: (_, state) =>
              state is InitialState || state is SearchResultsLoadedState,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildToolbar(),
                const PaginationBar(),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildCollections(
                        blocContext: context,
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
            );
          },
        ),
      ),
    );
  }

  BlocListener<AssetsBloc, BlocState> _buildAssetsBlocListener({
    required Widget child,
  }) {
    return BlocListener<AssetsBloc, BlocState>(
      listener: (context, state) {
        if (state is AddAssetsToCollectionFailureState) {
          Toast.showNotification(
            showDuration: const Duration(seconds: 6),
            type: ToastTypeEnum.error,
            title: 'Failed to Add Asset(s) to Collection',
            message: state.failure.message,
          );
        } else if (state is AddAssetsToCollectionSuccessState) {
          Toast.showNotification(
            showDuration: const Duration(seconds: 3),
            type: ToastTypeEnum.success,
            message: 'Asset(s) added to collection!',
          );
        } else if (state is DeleteAssetFailureState) {
          Toast.showNotification(
            showDuration: const Duration(seconds: 6),
            type: ToastTypeEnum.error,
            title: 'Failed to Delete Asset(s)',
            message: state.failure.message,
          );
        } else if (state is DeleteAssetSuccessState) {
          Toast.showNotification(
            showDuration: const Duration(seconds: 3),
            type: ToastTypeEnum.success,
            message: 'Asset(s) deleted!',
          );
        } else if (state is MoveAssetsToCollectionFailureState) {
          Toast.showNotification(
            showDuration: const Duration(seconds: 6),
            type: ToastTypeEnum.error,
            title: 'Failed to Move Asset(s) to Collection',
            message: state.failure.message,
          );
        } else if (state is MoveAssetsToCollectionSuccessState) {
          Toast.showNotification(
            showDuration: const Duration(seconds: 3),
            type: ToastTypeEnum.success,
            message: 'Asset(s) moved to collection!',
          );
        } else if (state is RemoveAssetsFromCollectionFailureState) {
          Toast.showNotification(
            showDuration: const Duration(seconds: 6),
            type: ToastTypeEnum.error,
            title: 'Failed to Remove Asset(s) from Collection',
            message: state.failure.message,
          );
        } else if (state is RemoveAssetsFromCollectionSuccessState) {
          Toast.showNotification(
            showDuration: const Duration(seconds: 3),
            type: ToastTypeEnum.success,
            message: 'Asset(s) removed from collection!',
          );
        } else if (state is SearchFailureState) {
          Toast.showNotification(
            showDuration: const Duration(seconds: 6),
            type: ToastTypeEnum.error,
            title: 'Failed to Load Results',
            message: state.failure.message,
          );
        } else if (state is SearchResultsLoadingState) {
          setState(() {
            _selectedIDs.clear();
          });
        }
      },
      child: child,
    );
  }

  Widget _buildAssetDetails() {
    const expandedWidth = 600.0;

    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 200),
      width: _assetDetailsVisible ? expandedWidth : 0.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          color: const Color(0xFF232323),
          width: expandedWidth,
          child: AssetDetails(
            key: ValueKey(_currentModel?.id),
            assetID: _currentModel?.id,
            onClose: () {
              setState(() {
                _assetDetailsVisible = false;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAssetDetailsSplitter() {
    return Container(
      width: 16.0,
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
          offset: const Offset(-4.0, 0.0),
          child: Icon(
            !_assetDetailsVisible ? MdiIcons.menuLeft : MdiIcons.menuRight,
            size: 22.0,
          ),
        ),
      ),
    );
  }

  Widget _buildCollections({
    required BuildContext blocContext,
  }) {
    const expandedWidth = 300.0;

    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 200),
      width: _favoritesVisible ? expandedWidth : 0.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          color: const Color(0xFF232323),
          width: expandedWidth,
          child: UserCollections(
            onSelectionChanged: (model) {
              _collectionID = model?.id;

              BlocProvider.of<AssetsBloc>(blocContext).add(
                SetCurrentCollectionEvent(
                  collectionID: model?.id,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCollectionsSplitter() {
    return Container(
      width: 16.0,
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
          offset: const Offset(-4.0, 0.0),
          child: Icon(
            !_favoritesVisible ? MdiIcons.menuRight : MdiIcons.menuLeft,
            size: 22.0,
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
        final assetsBloc = BlocProvider.of<AssetsBloc>(context);

        if (SearchView.refreshResults) {
          SearchView.refreshResults = false;
          assetsBloc.add(
            RefreshEvent(),
          );
        }

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
            final assets = state.assets;

            return AssetDataView(
              scrollController: _scrollController,
              config: GetIt.instance<Config>(),
              collectionID: _collectionID,
              assets: assets,
              selectedIDs: _selectedIDs,
              layoutMode: _layoutMode,
              thumbnailSize: _thumbnailSize,
              onTap: (model) {
                if (_assetDetailsVisible) {
                  setState(() {
                    _currentModel = model;
                  });
                }
              },
              onDoubleTap: (model) {
                setState(() {
                  _assetDetailsVisible = true;
                  _currentModel = model;
                });
              },
              onSelectionChanged: (selectedIDs) {
                setState(() {
                  _selectedIDs = selectedIDs;
                });
              },
              onAddSelectedToCollection: (selectedIDs) {
                showDialog<void>(
                  context: context,
                  barrierColor: Colors.black54,
                  barrierDismissible: false,
                  builder: (context) {
                    final theme = Theme.of(context);

                    return OverflowBox(
                      minWidth: 600.0,
                      maxWidth: 600.0,
                      child: Center(
                        child: AddAssetsToCollectionModal(
                          theme: theme,
                          title:
                              // ignore: lines_longer_than_80_chars
                              'Add selected${selectedIDs.length > 1 ? '  ( ${selectedIDs.length} ) ' : ''} asset${selectedIDs.length > 1 ? 's' : ''} to collection...',
                          onCancel: () {
                            Navigator.of(context).pop();
                          },
                          onConfirm: (collectionID) {
                            assetsBloc.add(
                              AddAssetsToCollectionEvent(
                                collectionID: collectionID,
                                assetIDs: selectedIDs,
                              ),
                            );

                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              onMoveSelectedToCollection: (selectedIDs) {
                if ((_collectionID == null) || selectedIDs.isEmpty) {
                  return;
                }

                final sourceCollectionID = _collectionID!;

                showDialog<void>(
                  context: context,
                  barrierColor: Colors.black54,
                  barrierDismissible: false,
                  builder: (context) {
                    final theme = Theme.of(context);

                    return OverflowBox(
                      minWidth: 600.0,
                      maxWidth: 600.0,
                      child: Center(
                        child: AddAssetsToCollectionModal(
                          theme: theme,
                          title:
                              // ignore: lines_longer_than_80_chars
                              'Move selected${selectedIDs.length > 1 ? '  ( ${selectedIDs.length} ) ' : ''} asset${selectedIDs.length > 1 ? 's' : ''} to collection...',
                          confirmButtonLabel: 'Move',
                          onCancel: () {
                            Navigator.of(context).pop();
                          },
                          onConfirm: (collectionID) {
                            if (collectionID == sourceCollectionID) {
                              Toast.showNotification(
                                showDuration: const Duration(seconds: 6),
                                type: ToastTypeEnum.information,
                                message:
                                    // ignore: lines_longer_than_80_chars
                                    'You must select a collection that is not the same as the current collection.',
                              );
                              return;
                            }

                            assetsBloc.add(
                              MoveAssetsToCollectionEvent(
                                sourceCollectionID: sourceCollectionID,
                                targetCollectionID: collectionID,
                                assetIDs: selectedIDs,
                              ),
                            );

                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              onDeleteSelected: (selectedIDs) {
                if (selectedIDs.isEmpty) {
                  return;
                }

                showConfirmationPrompt(
                  context: context,
                  title:
                      // ignore: lines_longer_than_80_chars
                      'Delete asset${selectedIDs.length > 1 ? 's' : ''}...',
                  message:
                      // ignore: lines_longer_than_80_chars
                      'Are you sure you want to delete the selected${selectedIDs.length > 1 ? '  ( ${selectedIDs.length} ) ' : ''} asset${selectedIDs.length > 1 ? 's' : ''}?',
                  onConfirm: () {
                    assetsBloc.add(
                      DeleteAssetEvent(
                        assetIDs: selectedIDs,
                      ),
                    );
                  },
                );
              },
              onRemoveSelectedFromCollection: (selectedIDs) {
                if ((_collectionID == null) || selectedIDs.isEmpty) {
                  return;
                }

                showConfirmationPrompt(
                  context: context,
                  title:
                      // ignore: lines_longer_than_80_chars
                      'Remove asset${selectedIDs.length > 1 ? 's' : ''} from current collection...',
                  message:
                      // ignore: lines_longer_than_80_chars
                      'Are you sure you want to remove the selected${selectedIDs.length > 1 ? '  ( ${selectedIDs.length} ) ' : ''} asset${selectedIDs.length > 1 ? 's' : ''} from the current collection?',
                  onConfirm: () {
                    assetsBloc.add(
                      RemoveAssetsFromCollectionEvent(
                        collectionID: _collectionID!,
                        assetIDs: selectedIDs,
                      ),
                    );
                  },
                );
              },
              onReload: () {
                assetsBloc.add(
                  ReloadCurrentPageEvent(),
                );
              },
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
        return Toolbar(
          searchTermController: _searchTermController,
          sortField: _sortField,
          sortDirection: _sortDirection,
          layoutMode: _layoutMode,
          thumbnailSize: _thumbnailSize,
          onReload: () {
            BlocProvider.of<AssetsBloc>(context).add(
              ReloadCurrentPageEvent(),
            );
          },
          onSearchTermClear: () {
            _searchTermController.clear();

            if (_searchTerm.isNotEmpty) {
              setState(() {
                _searchTerm = '';
              });

              BlocProvider.of<AssetsBloc>(context).add(
                SearchEvent(
                  searchTerm: '',
                  sortField: _sortField,
                  sortDirection: _sortDirection,
                ),
              );
            }
          },
          onSearchTermChange: (searchTerm) {
            setState(() {
              _searchTerm = searchTerm;
            });

            BlocProvider.of<AssetsBloc>(context).add(
              SearchEvent(
                searchTerm: searchTerm,
                sortField: _sortField,
                sortDirection: _sortDirection,
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
