import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/data/models/collection.dart';
import 'package:tmz_damz/features/assets/bloc/collection_bloc.dart';
import 'package:tmz_damz/shared/widgets/copy_text.dart';
import 'package:tmz_damz/shared/widgets/file_thumbnail.dart';
import 'package:tmz_damz/utils/config.dart';

class CollectionHeader extends StatelessWidget {
  static const kHeaderHeight = 120.0;

  final String collectionID;
  final void Function(CollectionModel collection) onCollectionLoaded;

  const CollectionHeader({
    super.key,
    required this.collectionID,
    required this.onCollectionLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = GetIt.instance<CollectionBloc>();

        bloc.add(
          LoadCollectionEvent(
            collectionID: collectionID,
          ),
        );

        return bloc;
      },
      child: BlocListener<CollectionBloc, CollectionBlocState>(
        listener: (context, state) async {
          if (state is CollectionLoadedState) {
            final config = GetIt.instance<Config>();
            final provider = ExtendedNetworkImageProvider(
              '${config.apiBaseUrl}/collection/$collectionID/thumbnail',
            );

            // evict the image cache in case the "poster asset" has changed
            await provider.evict();

            onCollectionLoaded(state.model);
          }
        },
        child: BlocBuilder<CollectionBloc, CollectionBlocState>(
          builder: (context, state) {
            if (state is CollectionLoadedState) {
              final theme = Theme.of(context);

              return _buildContainer(
                child: Row(
                  children: [
                    _buildThumbnail(
                      collectionID: state.model.id,
                    ),
                    const SizedBox(width: 20.0),
                    state.model.favorited
                        ? Icon(
                            MdiIcons.star,
                            color: const Color(0xFFFFA600),
                            shadows: kElevationToShadow[1],
                          )
                        : Icon(
                            MdiIcons.starOutline,
                            color: theme.colorScheme.primary.withAlpha(40),
                            shadows: kElevationToShadow[1],
                          ),
                    const SizedBox(width: 20.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CopyText(
                            state.model.name,
                            maxLines: 1,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (state.model.description.isNotEmpty) ...[
                            const SizedBox(height: 4.0),
                            Opacity(
                              opacity: 0.7,
                              child: CopyText(
                                state.model.description,
                                maxLines: 2,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  letterSpacing: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (state.model.isPrivate || state.model.autoClear)
                      const SizedBox(width: 20.0),
                    if (state.model.isPrivate)
                      SizedBox(
                        width: 40.0,
                        child: Center(
                          child: Icon(
                            MdiIcons.eyeLock,
                            color: const Color(0xFFFFA600),
                            shadows: kElevationToShadow[1],
                          ),
                        ),
                      ),
                    if (state.model.autoClear)
                      SizedBox(
                        width: 40.0,
                        child: Center(
                          child: Icon(
                            MdiIcons.deleteClockOutline,
                            color: const Color(0xFF0084FF),
                            shadows: kElevationToShadow[1],
                          ),
                        ),
                      ),
                    const SizedBox(width: 40.0),
                    Table(
                      columnWidths: const {
                        0: IntrinsicColumnWidth(),
                        1: FixedColumnWidth(40.0),
                        2: IntrinsicColumnWidth(),
                      },
                      children: [
                        TableRow(
                          children: [
                            _buildInfoCell(
                              context: context,
                              theme: theme,
                              canCopy: true,
                              label: 'OWNER',
                              value: () {
                                final firstName = state.model.ownedBy.firstName;
                                final lastName = state.model.ownedBy.lastName;
                                return '$firstName $lastName'.trim();
                              }(),
                            ),
                            const SizedBox.shrink(),
                            _buildInfoCell(
                              context: context,
                              theme: theme,
                              canCopy: true,
                              label: 'CREATED',
                              value: DateFormat.yMd()
                                  .add_jms()
                                  .format(state.model.createdAt.toLocal()),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            _buildInfoCell(
                              context: context,
                              theme: theme,
                              canCopy: false,
                              label: 'ASSETS',
                              value: (state.model.totalAssets > 0)
                                  ? NumberFormat('#,##0').format(
                                      state.model.totalAssets,
                                    )
                                  : '-',
                            ),
                            const SizedBox.shrink(),
                            _buildInfoCell(
                              context: context,
                              theme: theme,
                              canCopy: true,
                              label: 'UPDATED',
                              value: DateFormat.yMd()
                                  .add_jms()
                                  .format(state.model.updatedAt.toLocal()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (state is CollectionLoadingState) {
              return _buildContainer(
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is LoadCollectionFailureState) {
              return _buildContainer(
                child: Center(
                  child: Icon(
                    MdiIcons.alert,
                    color: const Color(0xFF303030),
                    size: 40,
                  ),
                ),
              );
            } else {
              return _buildContainer();
            }
          },
        ),
      ),
    );
  }

  Widget _buildContainer({
    Widget? child,
  }) {
    return Container(
      height: kHeaderHeight,
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 20.0,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(),
        ),
        color: Color(0xFF353637),
      ),
      child: child,
    );
  }

  Widget _buildInfoCell({
    required BuildContext context,
    required ThemeData theme,
    required bool canCopy,
    required String label,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 5.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Opacity(
            opacity: 0.4,
            child: Text(
              label,
              maxLines: 1,
              softWrap: false,
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),
          canCopy
              ? CopyText(
                  value,
                  maxLines: 1,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text(
                    value,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildThumbnail({
    required String collectionID,
  }) {
    final config = GetIt.instance<Config>();

    return Container(
      width: ((kHeaderHeight - 20) * (16.0 / 9.0)).floorToDouble(),
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Container(
        color: Colors.black,
        child: FileThumbnail(
          url: '${config.apiBaseUrl}/collection/$collectionID/thumbnail',
          errorWidget: Center(
            child: Icon(
              MdiIcons.imageMultiple,
              color: const Color(0xFF303030),
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}
