part of 'app_scaffold.dart';

class MenuDrawerItem extends StatelessWidget {
  final IconData? icon;
  final String? title;

  final bool isActive;
  final bool isDisabled;
  final ValueNotifier<bool> isCollapsed;

  final MenuDrawerItemStyle? style;
  final MenuDrawerItemStyle? activeStyle;
  final MenuDrawerItemStyle? disabledStyle;
  final VoidCallback? onTap;

  const MenuDrawerItem({
    super.key,
    this.icon,
    this.title,
    this.isActive = false,
    this.isDisabled = false,
    required this.isCollapsed,
    this.style,
    this.activeStyle,
    this.disabledStyle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = MenuDrawerTheme.of(context);
    final iconSize = _getIconSize(theme) ?? 0;
    final padding =
        (theme.itemData.padding ?? EdgeInsets.zero).resolve(TextDirection.ltr);

    return Container(
      color: _getBackgroundColor(theme),
      child: Material(
        color: !isDisabled && isActive
            ? Theme.of(context).highlightColor
            : Colors.transparent,
        child: InkWell(
          hoverColor: const Color(0x30FFFFFF),
          mouseCursor: !isDisabled ? SystemMouseCursors.click : null,
          onTap: !isDisabled ? () => onTap?.call() : null,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Positioned.fill(
                child: ValueListenableBuilder(
                  valueListenable: isCollapsed,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: padding.horizontal + iconSize,
                      top: padding.top,
                      right: padding.right,
                      bottom: padding.bottom,
                    ),
                    child: _buildTitle(theme),
                  ),
                  builder: (context, isCollapsed, child) {
                    return AnimatedScale(
                      alignment: Alignment.centerLeft,
                      duration: const Duration(milliseconds: 300),
                      scale: isCollapsed ? 0.5 : 1,
                      child: AnimatedOpacity(
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                        opacity: isCollapsed ? 0 : 1,
                        child: child,
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: padding,
                child: _buildIcon(theme),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(MenuDrawerThemeData theme) {
    return (icon != null)
        ? Icon(
            icon,
            color: _getIconColor(theme),
            size: _getIconSize(theme),
          )
        : const SizedBox();
  }

  Widget _buildTitle(MenuDrawerThemeData theme) {
    TextStyle? textStyle;

    if (isDisabled) {
      textStyle = disabledStyle?.labelTextStyle ??
          theme.itemData.disabledStyle?.labelTextStyle;
    } else if (isActive) {
      textStyle ??= activeStyle?.labelTextStyle ??
          theme.itemData.activeStyle?.labelTextStyle;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text(
        title ?? '',
        softWrap: true,
        style: textStyle ??
            style?.labelTextStyle ??
            theme.itemData.style.labelTextStyle,
      ),
    );
  }

  Color? _getBackgroundColor(MenuDrawerThemeData theme) {
    Color? backgroundColor;

    if (isDisabled) {
      backgroundColor = disabledStyle?.backgroundColor ??
          theme.itemData.disabledStyle?.backgroundColor;
    } else if (isActive) {
      backgroundColor ??= activeStyle?.backgroundColor ??
          theme.itemData.activeStyle?.backgroundColor;
    }

    return backgroundColor ??
        style?.backgroundColor ??
        theme.itemData.style.backgroundColor;
  }

  Color? _getIconColor(MenuDrawerThemeData theme) {
    Color? iconColor;

    if (isDisabled) {
      iconColor =
          disabledStyle?.iconColor ?? theme.itemData.disabledStyle?.iconColor;
    } else if (isActive) {
      iconColor ??=
          activeStyle?.iconColor ?? theme.itemData.activeStyle?.iconColor;
    }

    return iconColor ?? style?.iconColor ?? theme.itemData.style.iconColor;
  }

  double? _getIconSize(MenuDrawerThemeData theme) {
    double? iconSize;

    if (isDisabled) {
      iconSize =
          disabledStyle?.iconSize ?? theme.itemData.disabledStyle?.iconSize;
    } else if (isActive) {
      iconSize ??=
          activeStyle?.iconSize ?? theme.itemData.activeStyle?.iconSize;
    }

    return iconSize ?? style?.iconSize ?? theme.itemData.style.iconSize;
  }
}
