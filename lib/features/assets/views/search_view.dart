import 'package:auto_route/annotations.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

  late final FocusNode _focusNode;
  late final ScrollController _scrollController;
  late final TextEditingController _searchTermController;

  String _searchTerm = '';
  AssetSortFieldEnum _sortField = AssetSortFieldEnum.createdAt;
  SortDirectionEnum _sortDirection = SortDirectionEnum.descending;
  LayoutModeEnum _layoutMode = LayoutModeEnum.tile;
  ThumbnailSizeEnum _thumbnailSize = ThumbnailSizeEnum.medium;

  int _lastStateHash = 0;
  bool _favoritesVisible = false;
  bool _assetDetailsVisible = false;

  String? _collectionID;
  List<String> _selectIDs = [];
  AssetDetailsModel? _currentModel;

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    _searchTermController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
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
      child: BlocListener<AssetsBloc, BlocState>(
        listenWhen: (_, state) =>
            state is AddAssetsToCollectionFailureState ||
            state is AddAssetsToCollectionSuccessState ||
            state is RemoveAssetsFromCollectionFailureState ||
            state is RemoveAssetsFromCollectionSuccessState ||
            state is SearchFailureState,
        listener: (context, state) {
          if (state is AddAssetsToCollectionFailureState) {
            Toast.showNotification(
              showDuration: const Duration(seconds: 3),
              type: ToastTypeEnum.error,
              title: 'Failed to Add Assets to Collection',
              message: state.failure.message,
            );
          } else if (state is AddAssetsToCollectionSuccessState) {
            Toast.showNotification(
              showDuration: const Duration(seconds: 3),
              type: ToastTypeEnum.success,
              message: 'Assets added to collection!',
            );
          } else if (state is RemoveAssetsFromCollectionFailureState) {
            Toast.showNotification(
              showDuration: const Duration(seconds: 3),
              type: ToastTypeEnum.error,
              title: 'Failed to Remove Assets from Collection',
              message: state.failure.message,
            );
          } else if (state is RemoveAssetsFromCollectionSuccessState) {
            Toast.showNotification(
              showDuration: const Duration(seconds: 3),
              type: ToastTypeEnum.success,
              message: 'Assets removed from collection!',
            );
          } else if (state is SearchFailureState) {
            Toast.showNotification(
              showDuration: const Duration(seconds: 3),
              type: ToastTypeEnum.error,
              title: 'Failed to Load Results',
              message: state.failure.message,
            );
          }
        },
        child: BlocBuilder<AssetsBloc, BlocState>(
          buildWhen: (_, state) => state is InitialState,
          builder: (context, state) {
            return Focus(
              onKeyEvent: (node, event) {
                if ((event is! KeyDownEvent) ||
                    (FocusManager.instance.primaryFocus != node)) {
                  return KeyEventResult.ignored;
                }

                if ((event.logicalKey == LogicalKeyboardKey.delete) ||
                    (event.physicalKey == PhysicalKeyboardKey.delete)) {
                  if ((_collectionID != null) && _selectIDs.isNotEmpty) {
                    _showAssetRemovalConfirmation(
                      context: context,
                      onConfirm: () {
                        BlocProvider.of<AssetsBloc>(context).add(
                          RemoveAssetsFromCollectionEvent(
                            collectionID: _collectionID!,
                            assetIDs: _selectIDs,
                          ),
                        );
                      },
                    );
                  }

                  return KeyEventResult.handled;
                } else if ((event.logicalKey == LogicalKeyboardKey.f5) ||
                    (event.physicalKey == PhysicalKeyboardKey.f5)) {
                  BlocProvider.of<AssetsBloc>(context).add(
                    ReloadCurrentPageEvent(),
                  );

                  return KeyEventResult.handled;
                } else if (HardwareKeyboard.instance.isControlPressed &&
                    ((event.logicalKey == LogicalKeyboardKey.keyR) ||
                        (event.physicalKey == PhysicalKeyboardKey.keyR))) {
                  BlocProvider.of<AssetsBloc>(context).add(
                    ReloadCurrentPageEvent(),
                  );

                  return KeyEventResult.handled;
                } else {
                  return KeyEventResult.ignored;
                }
              },
              focusNode: _focusNode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildToolbar(),
                  const PaginationBar(),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildCollections(context),
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
            );
          },
        ),
      ),
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

  Widget _buildCollections(BuildContext blocContext) {
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
                scrollController: _scrollController,
                config: GetIt.instance<Config>(),
                assets: state.assets,
                layoutMode: _layoutMode,
                thumbnailSize: _thumbnailSize,
                onDoubleTap: (model) {
                  setState(() {
                    _assetDetailsVisible = true;
                    _currentModel = model;
                  });
                },
                onSelectionChanged: (selectedIDs) {
                  _focusNode.requestFocus();

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
                  sortField: _sortField,
                  sortDirection: _sortDirection,
                  searchTerm: '',
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

  void _showAssetRemovalConfirmation({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    BotToast.showAnimationWidget(
      animationDuration: const Duration(milliseconds: 100),
      allowClick: false,
      clickClose: false,
      crossPage: false,
      onlyOne: true,
      wrapToastAnimation: (controller, cancelFunc, child) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () => cancelFunc(),
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.black26,
                ),
                child: SizedBox.expand(),
              ),
            ),
            child
                .animate(
                  controller: controller,
                )
                .move(
                  curve: Curves.decelerate,
                  begin: const Offset(0, 20),
                  end: Offset.zero,
                ),
          ],
        )
            .animate(
              controller: controller,
            )
            .fadeIn(
              curve: Curves.decelerate,
              begin: 0.0,
            );
      },
      toastBuilder: (cancelFunc) {
        final theme = Theme.of(context);

        return Center(
          child: Container(
            width: 500,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF1D1E1F),
              ),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: kElevationToShadow[24],
              color: const Color(0xFF232323),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  color: const Color(0xFF1D1E1F),
                  child: Text(
                    'Are you sure you want to remove the selected assets?',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: Colors.blue,
                      letterSpacing: 1.0,
                    ),
                    softWrap: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    top: 20.0,
                    right: 20.0,
                    bottom: 10.0,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        MdiIcons.helpCircleOutline,
                        color: Colors.blue,
                        size: 36.0,
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Text(
                          'This will remove the selected assets from the active collection only.',
                          style: theme.textTheme.bodySmall,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const Spacer(),
                      SizedBox(
                        width: 100.0,
                        child: TextButton(
                          onPressed: cancelFunc,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color(0x30FFFFFF),
                            ),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 6.0,
                              ),
                            ),
                            shape: MaterialStateProperty.resolveWith(
                              (states) {
                                return RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Color(0x80000000),
                                  ),
                                  borderRadius: BorderRadius.circular(6.0),
                                );
                              },
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                            ),
                            child: Text(
                              'Cancel',
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      SizedBox(
                        width: 100.0,
                        child: TextButton(
                          onPressed: () {
                            cancelFunc();
                            onConfirm.call();
                          },
                          style: theme.textButtonTheme.style,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                            ),
                            child: Text(
                              'Confirm',
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
