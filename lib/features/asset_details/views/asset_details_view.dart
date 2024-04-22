import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:photo_view/photo_view.dart';
import 'package:tmz_damz/data/models/asset_details.dart';
import 'package:tmz_damz/data/models/asset_image.dart';
import 'package:tmz_damz/data/models/asset_metadata.dart';
import 'package:tmz_damz/data/sources/auth.dart';
import 'package:tmz_damz/features/asset_details/bloc/bloc.dart';
import 'package:tmz_damz/features/asset_details/widgets/metadata_form.dart';
import 'package:tmz_damz/features/asset_details/widgets/metadata_summary.dart';
import 'package:tmz_damz/features/asset_details/widgets/photo_info.dart';
import 'package:tmz_damz/features/asset_details/widgets/toolbar.dart';
import 'package:tmz_damz/shared/widgets/copy_text.dart';
import 'package:tmz_damz/shared/widgets/file_thumbnail.dart';
import 'package:tmz_damz/shared/widgets/masked_scroll_view.dart';
import 'package:tmz_damz/shared/widgets/toast.dart';
import 'package:tmz_damz/utils/config.dart';

@RoutePage(name: 'AssetDetailsRoute')
class AssetDetailsView extends StatefulWidget {
  final String assetID;

  const AssetDetailsView({
    super.key,
    @PathParam('assetID') required this.assetID,
  });

  @override
  State<AssetDetailsView> createState() => _AssetDetailsViewState();
}

class _AssetDetailsViewState extends State<AssetDetailsView> {
  late final MetadataFormController _metadataFormController;
  late final PhotoViewControllerBase _photoViewController;

  bool _editing = false;
  bool _saving = false;
  bool _imageLoaded = false;

  @override
  void dispose() {
    _metadataFormController.dispose();
    _photoViewController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _metadataFormController = MetadataFormController();
    _photoViewController = PhotoViewController();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBloc(context);
  }

  Widget _buildBloc(BuildContext context) {
    return BlocProvider<AssetDetailsBloc>(
      create: (context) {
        final bloc = GetIt.instance<AssetDetailsBloc>();

        bloc.add(
          LoadAssetDetailsEvent(
            assetID: widget.assetID,
          ),
        );

        return bloc;
      },
      child: BlocListener<AssetDetailsBloc, BlocState>(
        listenWhen: (_, state) =>
            state is AddToCollectionFailureState ||
            state is AddToCollectionSuccessState ||
            state is AssetDetailsFailureState ||
            state is AssetDetailsLoadedState ||
            state is DeleteAssetFailureState ||
            state is DeleteAssetSuccessState ||
            state is MetadataUpdatedState ||
            state is UpdateMetadataFailureState,
        listener: (context, state) {
          if (state is AddToCollectionFailureState) {
            Toast.showNotification(
              showDuration: const Duration(seconds: 6),
              type: ToastTypeEnum.error,
              title: 'Failed to Add Asset to Collection',
              message: state.failure.message,
            );
          } else if (state is AddToCollectionSuccessState) {
            Toast.showNotification(
              showDuration: const Duration(seconds: 3),
              type: ToastTypeEnum.success,
              message: 'Asset added to collection!',
            );
          } else if (state is AssetDetailsLoadedState) {
            _metadataFormController.setFrom(
              headline: state.model.headline,
              metadata: state.model.metadata,
            );
          } else if (state is AssetDetailsFailureState) {
            Toast.showNotification(
              showDuration: const Duration(seconds: 6),
              type: ToastTypeEnum.error,
              title: 'Failed to Load Details',
              message: state.failure.message,
            );
          } else if (state is DeleteAssetFailureState) {
            Toast.showNotification(
              showDuration: const Duration(seconds: 6),
              type: ToastTypeEnum.error,
              title: 'Failed to Delete Asset',
              message: state.failure.message,
            );
          } else if (state is DeleteAssetSuccessState) {
            Toast.showNotification(
              showDuration: const Duration(seconds: 3),
              type: ToastTypeEnum.success,
              message: 'Asset deleted!',
            );

            Navigator.of(context).pop();
          } else if (state is MetadataUpdatedState) {
            Toast.showNotification(
              showDuration: const Duration(seconds: 3),
              type: ToastTypeEnum.success,
              message: 'Metadata updated!',
            );

            setState(() {
              _editing = false;
              _saving = false;

              _metadataFormController.setFrom(
                headline: state.headline,
                metadata: state.metadata,
              );
            });
          } else if (state is UpdateMetadataFailureState) {
            Toast.showNotification(
              showDuration: const Duration(seconds: 6),
              type: ToastTypeEnum.error,
              title: 'Failed to Update Metadata',
              message: state.failure.message,
            );

            setState(() => _saving = false);
          }
        },
        child: BlocBuilder<AssetDetailsBloc, BlocState>(
          buildWhen: (_, state) =>
              state is AssetDetailsLoadedState ||
              state is AssetDetailsLoadingState ||
              state is AssetDetailsReloadingState,
          builder: (context, state) {
            if (state is AssetDetailsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is AssetDetailsLoadedState) {
              return _buildContent(
                context: context,
                model: state.model,
                reloading: false,
              );
            } else if (state is AssetDetailsReloadingState) {
              return _buildContent(
                context: context,
                model: state.model,
                reloading: true,
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
    required bool reloading,
  }) {
    final theme = Theme.of(context);

    final auth = GetIt.instance<IAuthDataSource>();

    return FutureBuilder(
      future: auth.getPermissions(),
      builder: (context, snapshot) {
        final permissions = snapshot.data?.fold(
          (failure) => null,
          (permissions) => permissions,
        );

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Toolbar(
                      permissions: permissions,
                      model: model,
                      onAddToCollection: (collectionID, assetID) {
                        BlocProvider.of<AssetDetailsBloc>(context).add(
                          AddToCollectionEvent(
                            collectionID: collectionID,
                            assetID: assetID,
                          ),
                        );
                      },
                      onDelete: (assetID) {
                        BlocProvider.of<AssetDetailsBloc>(context).add(
                          DeleteAssetEvent(
                            assetID: assetID,
                          ),
                        );
                      },
                      onEdit: () {
                        setState(() => _editing = true);
                      },
                    ),
                    const SizedBox(height: 10.0),
                    Expanded(
                      child: _buildImagePreview(
                        model: model,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    PhotoInfo(
                      model: model,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
              SizedBox(
                width: 600,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_editing)
                      SizedBox(
                        height: 54.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 100.0,
                              child: _buildSaveButton(
                                context: context,
                                theme: theme,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            SizedBox(
                              width: 100.0,
                              child: _buildCancelButton(
                                context: context,
                                theme: theme,
                                model: model,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            SizedBox(
                              width: 100.0,
                              child: _buildResetButton(
                                context: context,
                                theme: theme,
                                model: model,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (!_editing)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CopyText(
                          model.headline,
                          style: theme.textTheme.headlineMedium,
                        ),
                      ),
                    const SizedBox(height: 10.0),
                    Expanded(
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.5),
                              borderRadius: BorderRadius.circular(6.0),
                              color: _editing
                                  ? const Color(0x10FFFFFF)
                                  : const Color(0x20000000),
                            ),
                            child: reloading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : MaskedScrollView(
                                    padding: const EdgeInsets.all(20.0),
                                    child: _editing
                                        ? MetadataForm(
                                            controller: _metadataFormController,
                                          )
                                        : MetadataSummary(
                                            model: model,
                                          ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImagePreview({
    required AssetDetailsModel model,
  }) {
    final apiBaseUrl = GetIt.instance<Config>().apiBaseUrl;

    String? imageUrl;

    final image = model.images.firstWhereOrNull(
          (_) =>
              (_.type == AssetImageTypeEnum.source) &&
              (_.width <= 4096) &&
              (_.height <= 4096),
        ) ??
        model.images.firstWhereOrNull(
          (_) => _.type == AssetImageTypeEnum.hd1080,
        );

    if (image != null) {
      imageUrl = '$apiBaseUrl/asset/${model.id}/image/${image.id}';
    }

    const minScale = 1.0;
    const maxScale = 10.0;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(6.0),
        color: Colors.black,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Listener(
              onPointerSignal: (event) {
                if (event is PointerScrollEvent && _imageLoaded) {
                  final delta = event.scrollDelta.dy *
                      -(0.002 +
                          (0.002 *
                              (_photoViewController.scale ?? 1 / maxScale)));
                  final scale = ((_photoViewController.scale ?? 1) + delta)
                      .clamp(minScale, maxScale);

                  _photoViewController.scale = scale;
                }
              },
              child: PhotoView.customChild(
                controller: _photoViewController,
                basePosition: Alignment.center,
                initialScale: PhotoViewComputedScale.contained,
                minScale: minScale,
                maxScale: maxScale,
                child: FileThumbnail(
                  url: imageUrl ?? '$apiBaseUrl/asset/${model.id}/thumbnail',
                  onLoaded: (imageSize) {
                    setState(() => _imageLoaded = true);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCancelButton({
    required BuildContext context,
    required ThemeData theme,
    required AssetDetailsModel model,
  }) {
    return TextButton(
      onPressed: !_saving
          ? () {
              setState(() => _editing = false);

              _metadataFormController.reset();
            }
          : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0x30FFFFFF)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: const BorderSide(
              color: Color(0x80000000),
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        child: Text(
          'CANCEL',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildResetButton({
    required BuildContext context,
    required ThemeData theme,
    required AssetDetailsModel model,
  }) {
    return TextButton(
      onPressed: !_saving
          ? () {
              BlocProvider.of<AssetDetailsBloc>(context).add(
                ReloadAssetDetailsEvent(
                  model: model,
                ),
              );
            }
          : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0x30FFFFFF)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: const BorderSide(
              color: Color(0x80000000),
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        child: Text(
          'RESET',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton({
    required BuildContext context,
    required ThemeData theme,
  }) {
    return TextButton(
      onPressed: !_saving
          ? () {
              final headline = _metadataFormController.headline;

              if (headline.isEmpty) {
                Toast.showNotification(
                  showDuration: const Duration(seconds: 6),
                  type: ToastTypeEnum.error,
                  title: 'Missing Information',
                  message: 'Headline is required!',
                );

                return;
              }

              final metadata = _metadataFormController.getMetadata();

              if (metadata.rights == AssetMetadataRightsEnum.unknown) {
                Toast.showNotification(
                  showDuration: const Duration(seconds: 6),
                  type: ToastTypeEnum.error,
                  title: 'Missing Information',
                  message: 'Rights Summary is required!',
                );

                return;
              }

              if (metadata.rights != AssetMetadataRightsEnum.freeTMZ) {
                if ((metadata.agency?.isEmpty ?? false) &&
                    !(metadata.credit?.isNotEmpty ?? false)) {
                  Toast.showNotification(
                    showDuration: const Duration(seconds: 6),
                    type: ToastTypeEnum.error,
                    title: 'Missing Information',
                    message: 'Agency and/or Credit is required',
                  );

                  return;
                }
              }

              setState(() => _saving = true);

              BlocProvider.of<AssetDetailsBloc>(context).add(
                SaveMetadataEvent(
                  assetID: widget.assetID,
                  headline: headline,
                  metadata: metadata,
                ),
              );
            }
          : null,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color(0x30FFFFFF)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: const BorderSide(
              color: Color(0x80000000),
            ),
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        child: Text(
          'SAVE',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }
}
