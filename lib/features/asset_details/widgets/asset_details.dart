import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/data/models/asset_image.dart';
import 'package:tmz_damz/features/asset_details/bloc/bloc.dart';
import 'package:tmz_damz/features/asset_details/widgets/metadata_summary.dart';
import 'package:tmz_damz/features/asset_details/widgets/photo_info.dart';
import 'package:tmz_damz/shared/widgets/copy_text.dart';
import 'package:tmz_damz/shared/widgets/file_thumbnail.dart';
import 'package:tmz_damz/shared/widgets/masked_scroll_view.dart';
import 'package:tmz_damz/shared/widgets/toast.dart';
import 'package:tmz_damz/utils/config.dart';

class AssetDetails extends StatelessWidget {
  final String? assetID;
  final VoidCallback onClose;

  const AssetDetails({
    super.key,
    required this.assetID,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return _buildBloc(context);
  }

  Widget _buildBloc(BuildContext context) {
    return BlocProvider<AssetDetailsBloc>(
      create: (context) {
        final bloc = GetIt.instance<AssetDetailsBloc>();

        if (assetID != null) {
          bloc.add(
            LoadAssetDetailsEvent(
              assetID: assetID!,
            ),
          );
        }

        return bloc;
      },
      child: BlocListener<AssetDetailsBloc, BlocState>(
        listenWhen: (_, state) => state is AssetDetailsFailureState,
        listener: (context, state) {
          if (state is AssetDetailsFailureState) {
            Toast.showNotification(
              showDuration: const Duration(seconds: 6),
              type: ToastTypeEnum.error,
              title: 'Failed to Load Details',
              message: state.failure.message,
            );
          }
        },
        child: BlocBuilder<AssetDetailsBloc, BlocState>(
          buildWhen: (_, state) =>
              state is AssetDetailsLoadedState ||
              state is AssetDetailsLoadingState,
          builder: (context, state) {
            if (state is AssetDetailsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AssetDetailsLoadedState) {
              return _buildContent(
                context: context,
                model: state.model,
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildContent({
    required BuildContext context,
    required AssetDetailsModel model,
  }) {
    final apiBaseUrl = GetIt.instance<Config>().apiBaseUrl;
    final theme = Theme.of(context);

    String? imageUrl;

    final image = model.images.firstWhereOrNull(
          (_) => _.type == AssetImageTypeEnum.hd1080,
        ) ??
        model.images.firstWhereOrNull(
          (_) =>
              (_.type == AssetImageTypeEnum.source) &&
              (_.width <= 1920) &&
              (_.height <= 1080),
        );

    if (image != null) {
      imageUrl = '$apiBaseUrl/asset/${model.id}/image/${image.id}';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 10.0,
            right: 10.0,
            bottom: 10.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: CopyText(
                  model.headline,
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              const SizedBox(width: 10.0),
              IconButton(
                icon: Icon(MdiIcons.close),
                onPressed: onClose,
              ),
            ],
          ),
        ),
        Expanded(
          child: MaskedScrollView(
            padding: const EdgeInsets.only(
              left: 20.0,
              top: 10.0,
              right: 20.0,
              bottom: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    color: Colors.black,
                    child: FileThumbnail(
                      url:
                          imageUrl ?? '$apiBaseUrl/asset/${model.id}/thumbnail',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'CATEGORIES:',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.textTheme.labelSmall?.color
                              ?.withOpacity(0.4),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        model.categories.isNotEmpty
                            ? model.categories.join(', ')
                            : '-',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        'APPEARS IN:',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.textTheme.labelSmall?.color
                              ?.withOpacity(0.4),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        model.appearsIn.isNotEmpty
                            ? model.appearsIn.map((_) => _.name).join(', ')
                            : '-',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(6.0),
                    color: const Color(0x20000000),
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: MetadataSummary(
                    model: model,
                  ),
                ),
                const SizedBox(height: 20),
                PhotoInfo(
                  model: model,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
