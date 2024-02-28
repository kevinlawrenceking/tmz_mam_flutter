part of 'app_scaffold.dart';

class MenuDrawerHeader extends StatelessWidget {
  final ValueNotifier<bool> isCollapsed;
  final VoidCallback? onTap;

  MenuDrawerHeader({
    super.key,
    ValueNotifier<bool>? isCollapsed,
    this.onTap,
  }) : isCollapsed = isCollapsed ?? ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final theme = MenuDrawerTheme.of(context);
    final padding =
        (theme.itemData.padding ?? EdgeInsets.zero).resolve(TextDirection.ltr);

    return Material(
      color: Colors.transparent,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: ValueListenableBuilder(
            valueListenable: isCollapsed,
            builder: (context, isCollapsed, _) {
              return AnimatedContainer(
                alignment:
                    isCollapsed ? Alignment.centerLeft : Alignment.center,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutQuad,
                padding: padding,
                child: Icon(
                  MdiIcons.menu,
                  color: theme.itemData.style.iconColor,
                  size: theme.itemData.style.iconSize,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
