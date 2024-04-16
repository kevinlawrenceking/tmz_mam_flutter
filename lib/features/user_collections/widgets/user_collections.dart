import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/data/models/collection.dart';
import 'package:tmz_damz/features/user_collections/bloc/bloc.dart';
import 'package:tmz_damz/features/user_collections/widgets/add_collection_to_favorites.dart';
import 'package:tmz_damz/features/user_collections/widgets/user_collection_item.dart';
import 'package:tmz_damz/shared/widgets/toast.dart';

class UserCollections extends StatefulWidget {
  final void Function(CollectionModel? model) onSelectionChanged;

  const UserCollections({
    super.key,
    required this.onSelectionChanged,
  });

  @override
  State<UserCollections> createState() => _UserCollectionsState();
}

class _UserCollectionsState extends State<UserCollections> {
  late final FocusNode _focusNode;

  CollectionModel? _selectedCollection;

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocProvider<UserCollectionsBloc>(
        create: (context) {
          final bloc = GetIt.instance<UserCollectionsBloc>();

          bloc.add(LoadCollectionsEvent());

          return bloc;
        },
        child: BlocListener<UserCollectionsBloc, BlocState>(
          listenWhen: (_, state) =>
              state is AddCollectionToFavoritesFailureState ||
              state is AddCollectionToFavoritesSuccessState ||
              state is CreateCollectionFailureState ||
              state is CreateCollectionSuccessState ||
              state is LoadCollectionsFailureState ||
              state is RemoveCollectionFromFavoritesFailureState ||
              state is RemoveCollectionFromFavoritesSuccessState,
          listener: (context, state) {
            if (state is AddCollectionToFavoritesFailureState) {
              Toast.showNotification(
                showDuration: const Duration(seconds: 3),
                type: ToastTypeEnum.error,
                title: 'Failed to Add Collection to Favorites',
                message: state.failure.message,
              );
            } else if (state is AddCollectionToFavoritesSuccessState) {
              Toast.showNotification(
                showDuration: const Duration(seconds: 3),
                type: ToastTypeEnum.success,
                message: 'Collection added to favorites!',
              );
            } else if (state is CreateCollectionFailureState) {
              Toast.showNotification(
                showDuration: const Duration(seconds: 3),
                type: ToastTypeEnum.error,
                title: 'Failed to Create Collection',
                message: state.failure.message,
              );
            } else if (state is CreateCollectionSuccessState) {
              Toast.showNotification(
                showDuration: const Duration(seconds: 3),
                type: ToastTypeEnum.success,
                message: 'Collection created and added to favorites!',
              );
            } else if (state is LoadCollectionsFailureState) {
              Toast.showNotification(
                showDuration: const Duration(seconds: 3),
                type: ToastTypeEnum.error,
                title: 'Failed to Load Collection Favorites',
                message: state.failure.message,
              );
            } else if (state is RemoveCollectionFromFavoritesFailureState) {
              Toast.showNotification(
                showDuration: const Duration(seconds: 3),
                type: ToastTypeEnum.error,
                title: 'Failed to Remove Collection from Favorites',
                message: state.failure.message,
              );
            } else if (state is RemoveCollectionFromFavoritesSuccessState) {
              Toast.showNotification(
                showDuration: const Duration(seconds: 3),
                type: ToastTypeEnum.information,
                message: 'Collection removed from favorites!',
              );
            }
          },
          child: BlocBuilder<UserCollectionsBloc, BlocState>(
            builder: (context, state) {
              List<CollectionModel> collections;

              if (state is CollectionsLoadingState) {
                return const Center(
                  child: SizedBox(
                    height: 32.0,
                    width: 32.0,
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is CollectionsLoadedState) {
                collections = state.collections;
              } else {
                collections = [];
              }

              return Focus(
                onKeyEvent: (node, event) {
                  if ((event is! KeyDownEvent) ||
                      (FocusManager.instance.primaryFocus != node)) {
                    return KeyEventResult.ignored;
                  }

                  if ((event.logicalKey == LogicalKeyboardKey.f5) ||
                      (event.physicalKey == PhysicalKeyboardKey.f5)) {
                    BlocProvider.of<UserCollectionsBloc>(context).add(
                      LoadCollectionsEvent(),
                    );

                    return KeyEventResult.handled;
                  } else if (HardwareKeyboard.instance.isControlPressed &&
                      ((event.logicalKey == LogicalKeyboardKey.keyR) ||
                          (event.physicalKey == PhysicalKeyboardKey.keyR))) {
                    BlocProvider.of<UserCollectionsBloc>(context).add(
                      LoadCollectionsEvent(),
                    );

                    return KeyEventResult.handled;
                  } else {
                    return KeyEventResult.ignored;
                  }
                },
                focusNode: _focusNode,
                child: _buildContent(
                  context: context,
                  collections: collections,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAddCollectionToFavoritesButton(BuildContext context) {
    return SizedBox(
      height: 24.0,
      width: 24.0,
      child: IconButton(
        onPressed: () {
          _showAddCollectionToFavoritesDialog(context);
        },
        padding: EdgeInsets.zero,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            const Color(0xFF11853F),
          ),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
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
        icon: Icon(
          MdiIcons.plus,
          size: 16.0,
        ),
      ),
    );
  }

  Widget _buildContent({
    required BuildContext context,
    required List<CollectionModel> collections,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 14.0,
            top: 14.0,
            right: 10.0,
            bottom: 14.0,
          ),
          child: Row(
            children: [
              SizedBox(
                height: 24.0,
                width: 24.0,
                child: IconButton(
                  onPressed: () {
                    BlocProvider.of<UserCollectionsBloc>(context).add(
                      LoadCollectionsEvent(),
                    );
                  },
                  padding: EdgeInsets.zero,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0x30FFFFFF),
                    ),
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
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
                  icon: Icon(
                    MdiIcons.rotateRight,
                    size: 16.0,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Collections',
                  style: theme.textTheme.labelMedium,
                ),
              ),
              _buildAddCollectionToFavoritesButton(context),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: collections.length,
            itemBuilder: (context, index) {
              return BlocProvider.value(
                value: BlocProvider.of<UserCollectionsBloc>(context),
                child: UserCollectionItem(
                  model: collections[index],
                  selected: _selectedCollection?.id == collections[index].id,
                  onTap: (model) {
                    if (_selectedCollection?.id == model.id) {
                      _selectedCollection = null;
                    } else {
                      _selectedCollection = model;
                    }

                    widget.onSelectionChanged(_selectedCollection);

                    setState(() {});

                    _focusNode.requestFocus();
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showAddCollectionToFavoritesDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierColor: Colors.black26,
      barrierDismissible: false,
      builder: (_) {
        return Center(
          child: AddCollectionToFavorites(
            theme: Theme.of(context),
            onCancel: () {
              Navigator.of(context).pop();
            },
            onAdd: (collectionID) {
              BlocProvider.of<UserCollectionsBloc>(context).add(
                AddCollectionToFavoritesEvent(
                  collectionID: collectionID,
                ),
              );

              Navigator.of(context).pop();
            },
            onCreate: (params) {
              BlocProvider.of<UserCollectionsBloc>(context).add(
                CreateCollectionEvent(
                  name: params.name,
                  description: params.description,
                  isPrivate: params.isPrivate,
                  autoClear: params.autoClear,
                ),
              );

              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}
