import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tmz_damz/app_router.gr.dart';
import 'package:tmz_damz/data/models/access_control_permission_map.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/data/models/asset_search_data.dart';
import 'package:tmz_damz/data/models/asset_sort_field_enum.dart';
import 'package:tmz_damz/data/models/collection.dart';
import 'package:tmz_damz/data/models/send_to.dart';
import 'package:tmz_damz/data/models/shared.dart';
import 'package:tmz_damz/data/sources/auth.dart';
import 'package:tmz_damz/features/asset_details/widgets/asset_details.dart';
import 'package:tmz_damz/features/assets/bloc/assets_bloc.dart';
import 'package:tmz_damz/features/assets/widgets/asset_data_view.dart';
import 'package:tmz_damz/features/assets/widgets/collection_header.dart';
import 'package:tmz_damz/features/assets/widgets/layout_mode_selector.dart';
import 'package:tmz_damz/features/assets/widgets/pagination_bar.dart';
import 'package:tmz_damz/features/assets/widgets/thumbnail_size_selector.dart';
import 'package:tmz_damz/features/assets/widgets/toolbar.dart';
import 'package:tmz_damz/features/bulk_update/widgets/bulk_update_modal.dart';
import 'package:tmz_damz/features/user_collections/widgets/add_assets_to_collection_modal.dart';
import 'package:tmz_damz/features/user_collections/widgets/user_collections.dart';
import 'package:tmz_damz/shared/widgets/change_notifier_listener.dart';
import 'package:tmz_damz/shared/widgets/confirmation_prompt.dart';
import 'package:tmz_damz/shared/widgets/toast.dart';
import 'package:tmz_damz/utils/route_change_notifier.dart';

@RoutePage(name: 'AssetsSearchRoute')
class SearchView extends StatefulWidget {
  final String? collectionID;

  const SearchView({
    super.key,
    @QueryParam('collectionID') this.collectionID,
  });

  @override
  State<SearchView> createState() => _SearchViewState();

  static bool refreshResults = false;
}

class _SearchViewState extends State<SearchView> {
  late final ScrollController _scrollController;
  late final TextEditingController _searchTermController;

  AssetSearchDataModel? _advancedSearchData;
  String _simpleSearchTerm = '';

  AssetSortFieldEnum _sortField = AssetSortFieldEnum.createdAt;
  SortDirectionEnum _sortDirection = SortDirectionEnum.descending;
  LayoutModeEnum _layoutMode = LayoutModeEnum.tile;
  ThumbnailSizeEnum _thumbnailSize = ThumbnailSizeEnum.medium;

  bool _favoritesVisible = false;
  bool _assetDetailsVisible = false;

  List<SendToModel> _sendToOptions = [];
  List<String> _selectedIDs = [];
  AssetDetailsModel? _currentAsset;
  CollectionModel? _currentCollection;

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
    final auth = GetIt.instance<IAuthDataSource>();

    return FutureBuilder(
      future: auth.getPermissions(),
      builder: (_, snapshot) {
        final permissions = snapshot.data?.fold(
          (failure) => null,
          (permissions) => permissions,
        );

        return BlocProvider<AssetsBloc>(
          create: (context) {
            final bloc = GetIt.instance<AssetsBloc>();

            bloc.add(
              SetCurrentCollectionEvent(
                collectionID: widget.collectionID,
              ),
            );

            return bloc;
          },
          child: _buildAssetsBlocListener(
            child: BlocBuilder<AssetsBloc, AssetsBlocState>(
              buildWhen: (_, state) =>
                  state is InitialState || state is SearchResultsLoadedState,
              builder: (context, state) {
                if (state is SearchResultsLoadedState) {
                  if ((_currentCollection != null) &&
                      (_currentCollection!.id != widget.collectionID)) {
                    _currentCollection = null;

                    final assetsBloc = BlocProvider.of<AssetsBloc>(context);

                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      assetsBloc.add(
                        SetCurrentCollectionEvent(
                          collectionID: widget.collectionID,
                        ),
                      );
                    });
                  }
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.collectionID != null)
                      CollectionHeader(
                        key: ValueKey(widget.collectionID!),
                        collectionID: widget.collectionID!,
                        onCollectionLoaded: (collection) {
                          if (!mounted) {
                            return;
                          }

                          setState(() {
                            _currentCollection = collection;
                          });
                        },
                      ),
                    _buildToolbar(),
                    PaginationBar(
                      advancedSearchData: _advancedSearchData,
                      onAdvancedSearch: (searchData) {
                        setState(() {
                          _advancedSearchData = searchData;
                          _simpleSearchTerm = '';
                        });

                        if (searchData != null) {
                          BlocProvider.of<AssetsBloc>(context).add(
                            SearchAdvancedEvent(
                              searchData: searchData,
                            ),
                          );
                        } else {
                          BlocProvider.of<AssetsBloc>(context).add(
                            SearchSimpleEvent(
                              searchTerm: _simpleSearchTerm,
                              sortField: _sortField,
                              sortDirection: _sortDirection,
                            ),
                          );
                        }
                      },
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildCollections(
                            context: context,
                            permissions: permissions,
                          ),
                          _buildCollectionsSplitter(),
                          Expanded(
                            child: _buildSearchResults(
                              permissions: permissions,
                              sendToOptions: _sendToOptions,
                            ),
                          ),
                          if (_currentAsset != null)
                            _buildAssetDetailsSplitter(),
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
      },
    );
  }

  BlocListener<AssetsBloc, AssetsBlocState> _buildAssetsBlocListener({
    required Widget child,
  }) {
    return BlocListener<AssetsBloc, AssetsBlocState>(
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
        } else if (state is AssetsSentState) {
          Toast.showNotification(
            showDuration: const Duration(seconds: 3),
            type: ToastTypeEnum.success,
            message: 'Asset(s) sent!',
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
          if (!mounted) {
            return;
          }

          setState(() {
            _selectedIDs.clear();
          });
        } else if (state is SendToOptionsState) {
          if (!mounted) {
            return;
          }

          _sendToOptions = state.options;
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
            key: ValueKey(_currentAsset?.id),
            assetID: _currentAsset?.id,
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
              backgroundColor: WidgetStateProperty.all(
                const Color(0xFF353637),
              ),
              padding: WidgetStateProperty.all(EdgeInsets.zero),
              shape: WidgetStateProperty.all(
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
    required BuildContext context,
    required AccessControlPermissionMapModel? permissions,
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
            permissions: permissions,
            selectedCollectionID: widget.collectionID,
            onSelectionChanged: (selectedID) async {
              final assetsBloc = BlocProvider.of<AssetsBloc>(context);

              setState(() {
                _currentCollection = null;
              });

              await AutoRouter.of(context).navigate(
                AssetsSearchRoute(
                  collectionID: selectedID,
                ),
              );

              assetsBloc.add(
                SetCurrentCollectionEvent(
                  collectionID: selectedID,
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
              backgroundColor: WidgetStateProperty.all(
                const Color(0xFF353637),
              ),
              padding: WidgetStateProperty.all(EdgeInsets.zero),
              shape: WidgetStateProperty.all(
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

  Widget _buildSearchResults({
    required AccessControlPermissionMapModel? permissions,
    required List<SendToModel>? sendToOptions,
  }) {
    return BlocBuilder<AssetsBloc, AssetsBlocState>(
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
              permissions: permissions,
              sendToOptions: sendToOptions,
              collection: _currentCollection,
              assets: assets,
              selectedIDs: _selectedIDs,
              layoutMode: _layoutMode,
              thumbnailSize: _thumbnailSize,
              onTap: (model) {
                if (_assetDetailsVisible) {
                  setState(() {
                    _currentAsset = model;
                  });
                }
              },
              onDoubleTap: (model) {
                setState(() {
                  _assetDetailsVisible = true;
                  _currentAsset = model;
                });
              },
              onSelectionChanged: (selectedIDs) {
                setState(() {
                  _selectedIDs = selectedIDs;
                });
              },
              onBulkUpdate: (selectedIDs) async {
                await _showBulkEditDialog(
                  context: context,
                  selectedIDs: selectedIDs,
                );
              },
              onSendTo: (selectedIDs, sendToID) async {
                assetsBloc.add(
                  SendAssetsToEvent(
                    assetIDs: selectedIDs,
                    sendToID: sendToID,
                  ),
                );
              },
              onAddSelectedToCollection: (selectedIDs) async {
                await _showAddSelectedToCollection(
                  context: context,
                  selectedIDs: selectedIDs,
                );
              },
              onMoveSelectedToCollection: (selectedIDs) async {
                if ((widget.collectionID == null) || selectedIDs.isEmpty) {
                  return;
                }

                await _showMoveSelectedToCollection(
                  context: context,
                  sourceCollectionID: widget.collectionID!,
                  selectedIDs: selectedIDs,
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
                if ((widget.collectionID == null) || selectedIDs.isEmpty) {
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
                        collectionID: widget.collectionID!,
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
    return BlocBuilder<AssetsBloc, AssetsBlocState>(
      builder: (context, state) {
        return Toolbar(
          searchTermController: _searchTermController,
          advancedSearch: _advancedSearchData != null,
          sortField: _sortField,
          sortDirection: _sortDirection,
          layoutMode: _layoutMode,
          thumbnailSize: _thumbnailSize,
          onClearSearchParams: () {
            _searchTermController.clear();

            if (_simpleSearchTerm.isNotEmpty || (_advancedSearchData != null)) {
              setState(() {
                _advancedSearchData = null;
                _simpleSearchTerm = '';
              });

              BlocProvider.of<AssetsBloc>(context).add(
                SearchSimpleEvent(
                  searchTerm: '',
                  sortField: _sortField,
                  sortDirection: _sortDirection,
                ),
              );
            }
          },
          onReload: () {
            BlocProvider.of<AssetsBloc>(context).add(
              ReloadCurrentPageEvent(),
            );
          },
          onSearchTermChange: (searchTerm) {
            setState(() {
              _advancedSearchData = null;
              _simpleSearchTerm = searchTerm;
            });

            BlocProvider.of<AssetsBloc>(context).add(
              SearchSimpleEvent(
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
              SearchSimpleEvent(
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

  Future<void> _showAddSelectedToCollection({
    required BuildContext context,
    required List<String> selectedIDs,
  }) async {
    final theme = Theme.of(context);

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
              child: AddAssetsToCollectionModal(
                theme: theme,
                title:
                    // ignore: lines_longer_than_80_chars
                    'Add selected${selectedIDs.length > 1 ? '  ( ${selectedIDs.length} ) ' : ''} asset${selectedIDs.length > 1 ? 's' : ''} to collection...',
                onCancel: () {
                  Navigator.of(context).pop();
                },
                onConfirm: (collectionID) {
                  BlocProvider.of<AssetsBloc>(context).add(
                    AddAssetsToCollectionEvent(
                      collectionID: collectionID,
                      assetIDs: selectedIDs,
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

  Future<void> _showBulkEditDialog({
    required BuildContext context,
    required List<String> selectedIDs,
  }) async {
    final theme = Theme.of(context);

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
            minWidth: 900.0,
            maxWidth: 900.0,
            child: Center(
              child: BulkUpdateModal(
                theme: theme,
                assetIDs: selectedIDs,
                onClose: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showMoveSelectedToCollection({
    required BuildContext context,
    required String sourceCollectionID,
    required List<String> selectedIDs,
  }) async {
    final theme = Theme.of(context);

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

                  BlocProvider.of<AssetsBloc>(context).add(
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
          ),
        );
      },
    );
  }
}
