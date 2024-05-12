part of 'app_scaffold.dart';

class MenuDrawerStyle {
  final Color? backgroundColor;
  final Decoration? decoration;

  const MenuDrawerStyle({
    this.backgroundColor,
    this.decoration = const BoxDecoration(
      color: Color(0xFF2A2A2A),
      border: Border(
        right: BorderSide(
          color: Color(0xFF1D1D1D),
          width: 2,
        ),
      ),
    ),
  });
}
