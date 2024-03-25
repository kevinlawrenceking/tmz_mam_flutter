import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/data/models/collection.dart';
import 'package:tmz_damz/features/user_collections/bloc/bloc.dart';

class UserCollections extends StatelessWidget {
  final VoidCallback? onAddSelectedAssetsToCollection;
  final void Function(CollectionModel model) onCollectionTap;

  const UserCollections({
    super.key,
    required this.onAddSelectedAssetsToCollection,
    required this.onCollectionTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      child: BlocProvider<UserCollectionsBloc>(
        create: (context) {
          final bloc = GetIt.instance<UserCollectionsBloc>();

          bloc.add(LoadCollectionsEvent());

          return bloc;
        },
        child: BlocBuilder<UserCollectionsBloc, BlocState>(
          builder: (context, state) {
            List<CollectionModel> collections;

            if (state is CollectionsLoadedState) {
              collections = state.collections;
            } else {
              collections = [];
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Opacity(
                          opacity: (onAddSelectedAssetsToCollection != null)
                              ? 1.0
                              : 0.4,
                          child: TextButton(
                            onPressed: onAddSelectedAssetsToCollection,
                            style: theme.textButtonTheme.style,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Text(
                                'Add selected assets to collection...',
                                style: theme.textTheme.bodySmall,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: collections.length,
                    itemBuilder: (context, index) {
                      return _buildItem(
                        context: context,
                        model: collections[index],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildItem({
    required BuildContext context,
    required CollectionModel model,
  }) {
    return InkWell(
      onTap: () => onCollectionTap(model),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          top: 10.0,
          right: 10.0,
          bottom: 10.0,
        ),
        child: Row(
          children: [
            if (model.isPrivate) ...[
              Icon(
                MdiIcons.eyeLock,
                color: const Color(0xFFFFA600),
                size: 18.0,
              ),
              const SizedBox(
                width: 10.0,
              ),
            ],
            Expanded(
              child: Text(
                model.name,
              ),
            ),
            Center(
              child: SizedBox(
                height: 24.0,
                width: 24.0,
                child: IconButton(
                  onPressed: () {
                    _showRemovalConfirmation(
                      context: context,
                      onConfirm: () {
                        BlocProvider.of<UserCollectionsBloc>(context).add(
                          RemoveCollectionEvent(
                            collectionID: model.id,
                          ),
                        );
                      },
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
                    MdiIcons.minus,
                    size: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRemovalConfirmation({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    BotToast.showAnimationWidget(
      animationDuration: const Duration(milliseconds: 250),
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
                decoration: BoxDecoration(color: Colors.black26),
                child: SizedBox.expand(),
              ),
            ),
            child
                .animate(
                  controller: controller,
                )
                .move(
                  curve: Curves.decelerate,
                  begin: const Offset(0, 40),
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
                    'Are you sure you want to remove this collection?',
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
                          'This will remove the collection from your favorites.',
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
