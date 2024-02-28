part of 'app_scaffold.dart';

class MenuDrawerTheme extends StatelessWidget {
  final MenuDrawerThemeData data;
  final Widget child;

  const MenuDrawerTheme({
    super.key,
    required this.data,
    required this.child,
  });

  static MenuDrawerThemeData of(BuildContext context) {
    final inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_MenuDrawerInheritedTheme>();
    return inheritedTheme?.theme.data ?? const MenuDrawerThemeData();
  }

  @override
  Widget build(BuildContext context) {
    return _MenuDrawerInheritedTheme(
      theme: this,
      child: child,
    );
  }
}

class MenuDrawerThemeData {
  final MenuDrawerStyle style;
  final MenuDrawerItemThemeData itemData;

  const MenuDrawerThemeData({
    this.style = const MenuDrawerStyle(),
    this.itemData = const MenuDrawerItemThemeData(),
  });
}

class _MenuDrawerInheritedTheme extends InheritedTheme {
  const _MenuDrawerInheritedTheme({
    required this.theme,
    required super.child,
  });

  final MenuDrawerTheme theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    return MenuDrawerTheme(
      data: theme.data,
      child: child,
    );
  }

  @override
  bool updateShouldNotify(_MenuDrawerInheritedTheme old) =>
      theme.data != old.theme.data;
}
