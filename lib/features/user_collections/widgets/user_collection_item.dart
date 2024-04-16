import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/data/models/collection.dart';
import 'package:tmz_damz/features/user_collections/bloc/bloc.dart';
import 'package:tmz_damz/shared/widgets/confirmation_prompt.dart';

class UserCollectionItem extends StatelessWidget {
  final CollectionModel model;
  final bool selected;
  final void Function(CollectionModel model) onTap;

  const UserCollectionItem({
    super.key,
    required this.model,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: selected ? const Color(0xFF5F2A2A) : null,
      child: InkWell(
        onTap: () => onTap(model),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      model.name,
                      style: theme.textTheme.labelMedium,
                    ),
                    Opacity(
                      opacity: 0.4,
                      child: Text(
                        '${model.totalAssets} '
                        'asset${model.totalAssets != 1 ? 's' : ''}',
                        style: theme.textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: IconButton(
                    onPressed: () {
                      showConfirmationPrompt(
                        context: context,
                        title:
                            'Are you sure you want to remove this collection?',
                        message:
                            'This will remove the collection from your favorites.',
                        onConfirm: () {
                          BlocProvider.of<UserCollectionsBloc>(context).add(
                            RemoveCollectionFromFavoritesEvent(
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
      ),
    );
  }
}
