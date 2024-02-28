import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class InventoryItemThumbnail extends StatefulWidget {
  final String url;

  const InventoryItemThumbnail({
    super.key,
    required this.url,
  });

  @override
  State<InventoryItemThumbnail> createState() => _InventoryItemThumbnailState();
}

class _InventoryItemThumbnailState extends State<InventoryItemThumbnail> {
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
            child: ExtendedImage.network(
              widget.url,
              key: ValueKey(widget.url),
              cacheKey: widget.url,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
              cancelToken: _cancelToken,
              printError: false,
              retries: 1,
              timeLimit: const Duration(seconds: 3),
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
            ),
          ),
      ],
    );
  }
}
