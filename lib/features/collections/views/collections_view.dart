import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmz_damz/data/models/access_control_permission_map.dart';
import 'package:tmz_damz/data/models/collection_sort_field_enum.dart';
import 'package:tmz_damz/data/models/sort_direction_enum.dart';
import 'package:tmz_damz/data/sources/auth.dart';
import 'package:tmz_damz/features/collections/bloc/bloc.dart';
import 'package:tmz_damz/features/collections/widgets/collection_data_view.dart';
import 'package:tmz_damz/features/collections/widgets/pagination_bar.dart';
import 'package:tmz_damz/features/collections/widgets/toolbar.dart';
import 'package:tmz_damz/shared/widgets/confirmation_prompt.dart';
import 'package:tmz_damz/shared/widgets/toast.dart';

@RoutePage(name: 'CollectionsViewRoute')
class CollectionsView extends StatefulWidget {
  const CollectionsView({super.key});

  @override
  State<CollectionsView> createState() => _CollectionsViewState();
}

class _CollectionsViewState extends State<CollectionsView> {
  static const kDefaultResultsPerPage = 100;

  late final ScrollController _scrollController;
  late final TextEditingController _searchTermController;

  String _searchTerm = '';
  CollectionSortFieldEnum _sortField = CollectionSortFieldEnum.updatedAt;
  SortDirectionEnum _sortDirection = SortDirectionEnum.descending;
  List<String> _selectedIDs = [];

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
    final theme = Theme.of(context);

    final auth = GetIt.instance<IAuthDataSource>();

    return FutureBuilder(
      future: auth.getPermissions(),
      builder: (_, snapshot) {
        final permissions = snapshot.data?.fold(
          (failure) => null,
          (permissions) => permissions,
        );

        return BlocProvider<CollectionsBloc>(
          create: (context) {
            final bloc = GetIt.instance<CollectionsBloc>();

            bloc.add(
              PaginationChangedEvent(
                limit: kDefaultResultsPerPage,
                offset: 0,
              ),
            );

            return bloc;
          },
          child: _buildCollectionsBlocListener(
            child: BlocBuilder<CollectionsBloc, BlocState>(
              buildWhen: (_, state) =>
                  state is InitialState || state is SearchResultsLoadedState,
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildToolbar(),
                    PaginationBar(
                      permissions: permissions,
                    ),
                    Expanded(
                      child: _buildDataTable(
                        theme: theme,
                        permissions: permissions,
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

  BlocListener<CollectionsBloc, BlocState> _buildCollectionsBlocListener({
    required Widget child,
  }) {
    return BlocListener<CollectionsBloc, BlocState>(
      listener: (context, state) {
        if (state is SortOptionsChangedState) {
          setState(() {
            _sortField = state.sortField;
            _sortDirection = state.sortDirection;
          });
        }

        if (state is AddCollectionToFavoritesFailureState) {
          Toast.showNotification(
            showDuration: const Duration(seconds: 6),
            type: ToastTypeEnum.error,
            title:
                // ignore: lines_longer_than_80_chars
                'Failed to Add Collection to favorites',
            message: state.failure.message,
          );
        } else if (state is AddCollectionToFavoritesSuccessState) {
          Toast.showNotification(
            showDuration: const Duration(seconds: 3),
            type: ToastTypeEnum.success,
            message:
                // ignore: lines_longer_than_80_chars
                'Added  ( ${state.collectionIDs.length} )  collection${state.collectionIDs.length > 1 ? 's' : ''} to favorites!',
          );
        } else if (state is CreateCollectionFailureState) {
          Toast.showNotification(
            showDuration: const Duration(seconds: 6),
            type: ToastTypeEnum.error,
            title: 'Failed to Create Collection',
            message: state.failure.message,
          );
        } else if (state is CreateCollectionSuccessState) {
          Toast.showNotification(
            showDuration: const Duration(seconds: 3),
            type: ToastTypeEnum.success,
            message: 'Collection created!',
          );
        } else if (state is DeleteCollectionFailureState) {
          Toast.showNotification(
            showDuration: const Duration(seconds: 6),
            type: ToastTypeEnum.error,
            title:
                // ignore: lines_longer_than_80_chars
                'Failed to Delete Collection',
            message: state.failure.message,
          );
        } else if (state is DeleteCollectionSuccessState) {
          Toast.showNotification(
            showDuration: const Duration(seconds: 3),
            type: ToastTypeEnum.success,
            message:
                // ignore: lines_longer_than_80_chars
                '( ${state.collectionIDs.length} )  collection${state.collectionIDs.length > 1 ? 's' : ''} deleted!',
          );
        } else if (state is RemoveCollectionFromFavoritesFailureState) {
          Toast.showNotification(
            showDuration: const Duration(seconds: 6),
            type: ToastTypeEnum.error,
            title:
                // ignore: lines_longer_than_80_chars
                'Failed to Remove Collection from favorites',
            message: state.failure.message,
          );
        } else if (state is RemoveCollectionFromFavoritesSuccessState) {
          Toast.showNotification(
            showDuration: const Duration(seconds: 3),
            type: ToastTypeEnum.success,
            message:
                // ignore: lines_longer_than_80_chars
                'Removed  ( ${state.collectionIDs.length} )  collection${state.collectionIDs.length > 1 ? 's' : ''} from favorites!',
          );
        } else if (state is SaveCollectionFailureState) {
          Toast.showNotification(
            showDuration: const Duration(seconds: 6),
            type: ToastTypeEnum.error,
            title: 'Failed to Update Collection Details',
            message: state.failure.message,
          );
        } else if (state is SaveCollectionSuccessState) {
          Toast.showNotification(
            showDuration: const Duration(seconds: 3),
            type: ToastTypeEnum.success,
            message: 'Collection details updated!',
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

  Widget _buildDataTable({
    required ThemeData theme,
    required AccessControlPermissionMapModel? permissions,
  }) {
    return BlocBuilder<CollectionsBloc, BlocState>(
      buildWhen: (_, state) =>
          state is SearchFailureState ||
          state is SearchResultsLoadedState ||
          state is SearchResultsLoadingState,
      builder: (context, state) {
        final collectionsBloc = BlocProvider.of<CollectionsBloc>(context);

        if (state is SearchFailureState) {
          return Center(
            child: Text('Error: ${state.failure.message}'),
          );
        } else if (state is SearchResultsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchResultsLoadedState) {
          final collections = state.collections;

          return CollectionDataView(
            scrollController: _scrollController,
            permissions: permissions,
            collections: collections,
            selectedIDs: _selectedIDs,
            onSelectionChanged: (selectedIDs) {
              setState(() {
                _selectedIDs = selectedIDs;
              });
            },
            onAddSelectedToFavorites: (selectedIDs) {
              collectionsBloc.add(
                AddCollectionToFavoritesEvent(
                  collectionIDs: selectedIDs,
                ),
              );
            },
            onRemoveSelectedFromFavorites: (selectedIDs) {
              if (selectedIDs.isEmpty) {
                return;
              }

              showConfirmationPrompt(
                context: context,
                title:
                    // ignore: lines_longer_than_80_chars
                    'Remove collection${selectedIDs.length > 1 ? 's' : ''} from favorites...',
                message:
                    // ignore: lines_longer_than_80_chars
                    'Are you sure you want to remove the selected collection${selectedIDs.length > 1 ? 's' : ''} from your favorites?',
                onConfirm: () {
                  collectionsBloc.add(
                    RemoveCollectionFromFavoritesEvent(
                      collectionIDs: selectedIDs,
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
                width: 550.0,
                title:
                    // ignore: lines_longer_than_80_chars
                    'Delete collection${selectedIDs.length > 1 ? 's' : ''}...',
                message:
                    // ignore: lines_longer_than_80_chars
                    'Are you sure you want to delete the selected${selectedIDs.length > 1 ? '  ( ${selectedIDs.length} ) ' : ''} collection${selectedIDs.length > 1 ? 's' : ''}?\n\nThis will not delete any associated assets.',
                onConfirm: () {
                  collectionsBloc.add(
                    DeleteCollectionEvent(
                      collectionIDs: selectedIDs,
                    ),
                  );
                },
              );
            },
            onReload: () {
              collectionsBloc.add(
                ReloadCurrentPageEvent(),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildToolbar() {
    return BlocBuilder<CollectionsBloc, BlocState>(
      builder: (context, state) {
        return Toolbar(
          searchTermController: _searchTermController,
          sortField: _sortField,
          sortDirection: _sortDirection,
          onReload: () {
            BlocProvider.of<CollectionsBloc>(context).add(
              ReloadCurrentPageEvent(),
            );
          },
          onSearchTermClear: () {
            _searchTermController.clear();

            if (_searchTerm.isNotEmpty) {
              setState(() {
                _searchTerm = '';
              });

              BlocProvider.of<CollectionsBloc>(context).add(
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

            BlocProvider.of<CollectionsBloc>(context).add(
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

            BlocProvider.of<CollectionsBloc>(context).add(
              SearchEvent(
                sortField: _sortField,
                sortDirection: _sortDirection,
              ),
            );
          },
        );
      },
    );
  }
}
