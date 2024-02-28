import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_mam_flutter/app_router.gr.dart';

part 'menu_drawer.dart';
part 'menu_drawer_header.dart';
part 'menu_drawer_item.dart';
part 'menu_drawer_item_style.dart';
part 'menu_drawer_item_theme_data.dart';
part 'menu_drawer_style.dart';
part 'menu_drawer_theme.dart';

class AppScaffold extends StatefulWidget {
  final Widget content;

  const AppScaffold({
    super.key,
    required this.content,
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold>
    with SingleTickerProviderStateMixin {
  static const _iconSize = 26.0;
  static const _menuExpandedWidth = 200;
  static const _menuItemPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 10,
  );

  late final AnimationController _animationController;
  late final CurvedAnimation _animation;
  late final ValueNotifier<bool> _isMenuCollapsed;

  @override
  void initState() {
    super.initState();

    _isMenuCollapsed = ValueNotifier<bool>(true);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      value: _isMenuCollapsed.value ? 0 : 1,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutQuad,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_animationController.value != (_isMenuCollapsed.value ? 0 : 1)) {
      _animationController.value = _isMenuCollapsed.value ? 0 : 1;
    }

    return Material(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          final collapsedWidth =
              _menuItemPadding.resolve(TextDirection.ltr).horizontal +
                  _iconSize;
          final menuWidth = collapsedWidth +
              ((_menuExpandedWidth - collapsedWidth) * _animation.value);

          return Stack(
            children: [
              Positioned.fill(
                left: menuWidth,
                child: widget.content,
              ),
              SizedBox(
                width: menuWidth,
                child: _buildMenuDrawer(context),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMenuDrawer(BuildContext context) {
    final router = AutoRouter.of(context);

    final topItems = [
      _MenuItem(
        icon: MdiIcons.viewDashboard,
        title: 'Assets',
        isActive: router.current.name == AssetsSearchRoute.name,
        onTap: () {
          AutoRouter.of(context).navigate(const AssetsSearchRoute());
        },
      ),
      _MenuItem(
        icon: MdiIcons.folderMultiple,
        title: 'Collections',
        isActive: false /* router.current.name == CollectionsRoute.name */,
        onTap: () {
          // AutoRouter.of(context).navigate(const CollectionsRoute());
        },
      ),
      _MenuItem(
        icon: MdiIcons.progressUpload,
        title: 'Upload',
        isActive: false /* router.current.name == UploadRoute.name */,
        onTap: () {
          // AutoRouter.of(context).navigate(const UploadRoute());
        },
      ),
    ];

    final bottomItems = [
      _MenuItem(
        icon: MdiIcons.shieldAccountVariant,
        title: 'Admin',
        isActive: false /* router.current.name == AdminRoute.name */,
        onTap: () {
          // AutoRouter.of(context).navigate(const AdminRoute());
        },
      ),
      _MenuItem(
        icon: MdiIcons.cog,
        title: 'Settings',
        isActive: false /* router.current.name == SettingsRoute.name */,
        onTap: () {
          // AutoRouter.of(context).navigate(const SettingsRoute());
        },
      ),
      _MenuItem(
        icon: MdiIcons.logout,
        title: 'Logout',
        isActive: false,
        onTap: () {
          // TODO: prompt user to confirm they really want to logout...
          // TODO: clear session auth token from secure storage

          AutoRouter.of(context).replace(const AuthenticationLoginRoute());
        },
      ),
    ];

    return MenuDrawerTheme(
      data: MenuDrawerThemeData(
        style: MenuDrawerStyle(
          decoration: BoxDecoration(
            color: const Color(0xFF8E0000),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
        ),
        itemData: const MenuDrawerItemThemeData(
          padding: _menuItemPadding,
          iconSpacing: 8,
          style: MenuDrawerItemStyle(
            iconColor: Color(0xFF202020),
            iconSize: _iconSize,
            labelTextStyle: TextStyle(
              color: Color(0xFF202020),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          activeStyle: MenuDrawerItemStyle(
            iconColor: Color(0xFFDEFFFF),
            labelTextStyle: TextStyle(
              color: Color(0xFFDEFFFF),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          disabledStyle: MenuDrawerItemStyle(
            iconColor: Color(0xFF505050),
            labelTextStyle: TextStyle(
              color: Color(0xFF505050),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      child: MenuDrawer(
        isCollapsed: _isMenuCollapsed,
        header: MenuDrawerHeader(
          isCollapsed: _isMenuCollapsed,
          onTap: () {
            final isMenuCollapsed = !_isMenuCollapsed.value;

            if (isMenuCollapsed) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }

            _isMenuCollapsed.value = isMenuCollapsed;
          },
        ),
        topItems: topItems.map((e) {
          return MenuDrawerItem(
            icon: e.icon,
            title: e.title,
            isActive: e.isActive,
            isCollapsed: _isMenuCollapsed,
            onTap: e.onTap,
          );
        }).toList(),
        bottomItems: bottomItems.map((e) {
          return MenuDrawerItem(
            icon: e.icon,
            title: e.title,
            isActive: e.isActive,
            isCollapsed: _isMenuCollapsed,
            onTap: e.onTap,
          );
        }).toList(),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final bool isActive;
  final VoidCallback? onTap;

  _MenuItem({
    required this.icon,
    required this.title,
    required this.isActive,
    required this.onTap,
  });
}
