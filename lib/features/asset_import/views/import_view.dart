import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmz_damz/app_router.gr.dart';
import 'package:tmz_damz/data/models/asset_import_session_file.dart';
import 'package:tmz_damz/features/asset_import/bloc/bloc.dart';
import 'package:tmz_damz/shared/widgets/app_scaffold/app_scaffold.dart';
import 'package:tmz_damz/shared/widgets/file_thumbnail.dart';
import 'package:tmz_damz/shared/widgets/masked_scroll_view.dart';
import 'package:tmz_damz/utils/config.dart';

@RoutePage(name: 'AssetImportRoute')
class ImportView extends StatefulWidget {
  final String? sessionID;

  const ImportView({
    super.key,
    @PathParam('sessionID') this.sessionID,
  });

  @override
  State<ImportView> createState() => _ImportViewState();
}

class _ImportViewState extends State<ImportView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      content: BlocProvider<AssetImportBloc>(
        create: (context) {
          final bloc = GetIt.instance<AssetImportBloc>();

          if (widget.sessionID != null) {
            bloc.add(GetSessionDetailsEvent(widget.sessionID!));
          }

          return bloc;
        },
        child: BlocListener<AssetImportBloc, BlocState>(
          listenWhen: (_, state) => state is GetSessionDetailsFailureState,
          listener: (context, state) async {
            if (state is GetSessionDetailsFailureState) {
              await AutoRouter.of(context).navigate(AssetImportRoute());
            }
          },
          child: BlocBuilder<AssetImportBloc, BlocState>(
            buildWhen: (_, state) => state is SessionDetailsState,
            builder: (context, state) {
              if (state is SessionDetailsState) {
                final config = GetIt.instance<Config>();
                final theme = Theme.of(context);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: const Color(0x10FFFFFF),
                      ),
                      height: 200,
                      margin: const EdgeInsets.all(20.0),
                    ),
                    Expanded(
                      child: MaskedScrollView(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...List.generate(
                              state.session.files.length,
                              (index) => _buildFileContainer(
                                theme: theme,
                                apiBaseUrl: config.apiBaseUrl,
                                file: state.session.files[index],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else if (widget.sessionID != null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Text('empty');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFileContainer({
    required ThemeData theme,
    required String apiBaseUrl,
    required AssetImportSessionFileModel file,
  }) {
    return Container(
      key: ValueKey(file.id),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: const Color(0x10FFFFFF),
      ),
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          SizedBox(
            height: 70.0,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: Colors.black,
                child: FileThumbnail(
                  url:
                      '$apiBaseUrl/asset/import/session/${file.sessionID}/file/${file.id}/thumbnail',
                ),
              ),
            ),
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  file.originalFileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: theme.textTheme.titleSmall,
                ),
                Opacity(
                  opacity: 0.4,
                  child: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    text: TextSpan(
                      style: theme.textTheme.bodySmall,
                      children: [
                        const TextSpan(
                          text: 'Size: ',
                        ),
                        TextSpan(
                          text: (file.fileInfo.sizeOnDisk.toDouble() / 1000.0)
                              .ceil()
                              .toString(),
                        ),
                        const TextSpan(
                          text: ' kb',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10.0),
          (() {
            if (file.status == AssetImportSessionFileStatusEnum.error) {
              return Text(
                'ERROR',
                maxLines: 1,
                softWrap: false,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              );
            } else if (file.status ==
                AssetImportSessionFileStatusEnum.imported) {
              return Text(
                'IMPORTED',
                maxLines: 1,
                softWrap: false,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              );
            } else if (file.status ==
                AssetImportSessionFileStatusEnum.processing) {
              return const SizedBox(
                height: 32.0,
                width: 32.0,
                child: CircularProgressIndicator(),
              );
            } else if (file.status == AssetImportSessionFileStatusEnum.ready) {
              return Text(
                'READY',
                maxLines: 1,
                softWrap: false,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              );
            } else {
              return const SizedBox();
            }
          })(),
          const SizedBox(width: 10.0),
          // TODO: add "remove file" button
        ],
      ),
    );
  }
}
