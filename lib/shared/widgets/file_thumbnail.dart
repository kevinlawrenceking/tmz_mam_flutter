import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/data/sources/auth.dart';
import 'package:tmz_damz/utils/service_locator.dart';

class FileThumbnail extends StatefulWidget {
  final String url;
  final void Function(Size imageSize)? onLoaded;

  const FileThumbnail({
    super.key,
    required this.url,
    this.onLoaded,
  });

  @override
  State<FileThumbnail> createState() => _FileThumbnailState();
}

class _FileThumbnailState extends State<FileThumbnail> {
  final _authDataSource = GetIt.instance<IAuthDataSource>();

  CancellationToken? _cancelToken;
  bool _error = false;
  bool _loading = true;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    _cancelToken = CancellationToken();
  }

  @override
  void dispose() {
    _cancelToken?.cancel();
    _cancelToken = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        if (_loading)
          const Center(
            child: CircularProgressIndicator(),
          ),
        if (_error)
          Center(
            child: Icon(
              MdiIcons.alert,
              color: const Color(0xFF303030),
              size: 40,
            ),
          ),
        if (!_error)
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _opacity,
            child: FutureBuilder(
              future: () async {
                final result = await _authDataSource.getAuthToken();
                final authToken = result.fold(
                  (failure) => null,
                  (authToken) => authToken,
                );
                return authToken;
              }(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                }

                final authToken = snapshot.data;

                return ExtendedImage.network(
                  widget.url,
                  key: ValueKey(widget.url),
                  cacheKey: widget.url,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                  cancelToken: _cancelToken,
                  printError: false,
                  retries: 1,
                  timeLimit: const Duration(seconds: 3),
                  headers: (authToken != null)
                      ? {
                          'authorization': 'Bearer $authToken',
                          'x-app': GetIt.instance<AppIdentifier>().value,
                        }
                      : null,
                  loadStateChanged: (state) {
                    if (state.wasSynchronouslyLoaded ||
                        (state.extendedImageLoadState == LoadState.completed)) {
                      if (!_loading) {
                        return null;
                      }

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (!mounted) {
                          return;
                        }

                        setState(() {
                          _loading = false;
                          _opacity = 1.0;
                        });

                        widget.onLoaded?.call(
                          Size(
                            state.extendedImageInfo?.image.width.toDouble() ??
                                0.0,
                            state.extendedImageInfo?.image.height.toDouble() ??
                                0.0,
                          ),
                        );
                      });

                      return null;
                    }

                    if (state.extendedImageLoadState == LoadState.failed) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (!mounted) {
                          return;
                        }

                        setState(() {
                          _loading = false;
                          _error = true;
                        });
                      });
                      return null;
                    }

                    return null;
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
