part of 'app_scaffold.dart';

class MenuDrawerItemThemeData {
  final EdgeInsetsGeometry? padding;
  final double? iconSpacing;
  final MenuDrawerItemStyle style;
  final MenuDrawerItemStyle? activeStyle;
  final MenuDrawerItemStyle? disabledStyle;

  const MenuDrawerItemThemeData({
    this.padding,
    this.iconSpacing,
    this.style = const MenuDrawerItemStyle(),
    this.activeStyle,
    this.disabledStyle,
  });
}
