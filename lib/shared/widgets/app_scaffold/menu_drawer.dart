part of 'app_scaffold.dart';

class MenuDrawer extends StatefulWidget {
  final ValueNotifier<bool> isCollapsed;
  final ScrollPhysics scrollPhysics;
  final MenuDrawerStyle? style;
  final Widget? header;
  final List<Widget> topItems;
  final List<Widget> contextualItems;
  final List<Widget> bottomItems;

  const MenuDrawer({
    super.key,
    required this.isCollapsed,
    this.scrollPhysics = const AlwaysScrollableScrollPhysics(
      parent: BouncingScrollPhysics(),
    ),
    this.style,
    this.header,
    required this.topItems,
    required this.contextualItems,
    required this.bottomItems,
  });

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = MenuDrawerTheme.of(context);

    return DecoratedBox(
      decoration: widget.style?.decoration ??
          theme.style.decoration ??
          BoxDecoration(
            color: widget.style?.backgroundColor ?? theme.style.backgroundColor,
          ),
      child: Padding(
        padding: (widget.header == null)
            ? const EdgeInsets.symmetric(vertical: 8.0)
            : const EdgeInsets.only(bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            widget.header ?? const SizedBox.shrink(),
            ...widget.topItems,
            if (widget.contextualItems.isNotEmpty) ...[
              const Divider(
                color: Color(0x50000000),
              ),
              ...widget.contextualItems,
            ],
            const Spacer(),
            ChangeNotifierProvider(
              create: (context) => widget.isCollapsed,
              builder: (context, child) {
                if (!widget.isCollapsed.value) {
                  return FutureBuilder(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        final version = snapshot.data!.version;
                        final buildNumber =
                            snapshot.data!.buildNumber.isNotEmpty
                                ? '+${snapshot.data!.buildNumber}'
                                : '';
                        return Text(
                          'Version $version$buildNumber',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(height: 20.0),
            ...widget.bottomItems,
          ],
        ),
      ),
    );
  }
}
