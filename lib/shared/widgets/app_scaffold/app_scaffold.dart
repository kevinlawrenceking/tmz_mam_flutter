import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:tmz_damz/app_router.dart';
import 'package:tmz_damz/app_router.gr.dart';
import 'package:tmz_damz/shared/bloc/auth_session_bloc.dart';
import 'package:tmz_damz/shared/widgets/toast.dart';
import 'package:tmz_damz/utils/auth_session_manager.dart';
import 'package:tmz_damz/utils/route_change_notifier.dart';

part 'menu_drawer.dart';
part 'menu_drawer_header.dart';
part 'menu_drawer_item.dart';
part 'menu_drawer_item_style.dart';
part 'menu_drawer_item_theme_data.dart';
part 'menu_drawer_style.dart';
part 'menu_drawer_theme.dart';

class AppScaffold extends StatefulWidget {
  final AppRouter router;

  const AppScaffold({
    super.key,
    required this.router,
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold>
    with SingleTickerProviderStateMixin {
  static const _iconSize = 26.0;
  static const _menuExpandedWidth = 300;
  static const _menuItemPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 10,
  );

  static bool isMenuCollapsed = true;

  late final AnimationController _animationController;
  late final CurvedAnimation _animation;
  late final ValueNotifier<bool> _isMenuCollapsed;

  @override
  void dispose() {
    widget.router.removeListener(_onRouteChanged);

    _animationController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    widget.router.addListener(_onRouteChanged);

    _isMenuCollapsed = ValueNotifier<bool>(isMenuCollapsed);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      value: _isMenuCollapsed.value ? 0 : 1,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _onRouteChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.router.current.name == AuthenticationLoginRoute.name) {
      return Container();
    }

    if (_animationController.value != (_isMenuCollapsed.value ? 0 : 1)) {
      _animationController.value = _isMenuCollapsed.value ? 0 : 1;
    }

    return BlocProvider.value(
      value: GetIt.instance<AuthSessionBloc>(),
      child: BlocListener<AuthSessionBloc, AuthSessionBlocState>(
        listener: (context, state) async {
          if (state is SessionExpiredState) {
            Toast.showNotification(
              showDuration: null,
              type: ToastTypeEnum.information,
              message: 'Session expired.',
            );

            await widget.router.replace(
              const AuthenticationLoginRoute(),
            );
          } else if (state is UserLoggedOutState) {
            await widget.router.replace(
              const AuthenticationLoginRoute(),
            );
          }
        },
        child: Material(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, _) {
              final collapsedWidth =
                  _menuItemPadding.resolve(TextDirection.ltr).horizontal +
                      _iconSize;
              final menuWidth = collapsedWidth +
                  ((_menuExpandedWidth - collapsedWidth) * _animation.value);

              return SizedBox(
                width: menuWidth,
                child: _buildMenuDrawer(context),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMenuDrawer(BuildContext context) {
    final notifier = Provider.of<RouteChangeNotifier>(
      context,
      listen: false,
    );

    final topItems = [
      _MenuItem(
        icon: MdiIcons.viewDashboard,
        title: 'Assets',
        isActive: widget.router.current.name == AssetsSearchRoute.name,
        onTap: () async {
          notifier.notify();
          await widget.router.navigate(AssetsSearchRoute());
        },
      ),
      _MenuItem(
        icon: MdiIcons.folderMultiple,
        title: 'Collections',
        isActive: widget.router.current.name == CollectionsViewRoute.name,
        onTap: () async {
          notifier.notify();
          await widget.router.navigate(const CollectionsViewRoute());
        },
      ),
      _MenuItem(
        icon: MdiIcons.progressUpload,
        title: 'Import Images',
        isActive: (widget.router.current.name == AssetImportRoute.name) ||
            (widget.router.current.name == AssetImportSessionRoute.name),
        onTap: () async {
          notifier.notify();
          await widget.router.navigate(const AssetImportRoute());
        },
      ),
    ];

    final contextualItems = <_MenuItem>[
      // NOTE: left this here is for future reference when
      // needing to add contextual menu items (if any)...

      // if (widget.router.current.name == AssetsSearchRoute.name) ...[
      //   _MenuItem(
      //     icon: MdiIcons.trayArrowDown,
      //     title: 'Download Selected Images',
      //     isActive: false,
      //     onTap: () {
      //       BlocProvider.of<GlobalBloc>(context).add(
      //         DownloadSelectedAssetsEvent(),
      //       );
      //     },
      //   ),
      // ],
    ];

    final bottomItems = [
      // _MenuItem(
      //   icon: MdiIcons.shieldAccountVariant,
      //   title: 'Admin',
      //   isActive: false /* widget.router.current.name == AdminRoute.name */,
      //   onTap: () {
      //     // widget.router.navigate(const AdminRoute());
      //   },
      // ),
      // _MenuItem(
      //   icon: MdiIcons.cog,
      //   title: 'Settings',
      //   isActive: false /* widget.router.current.name == SettingsRoute.name */,
      //   onTap: () {
      //     // widget.router.navigate(const SettingsRoute());
      //   },
      // ),
      _MenuItem(
        icon: MdiIcons.logout,
        title: 'Logout',
        isActive: false,
        onTap: () async {
          // TODO: prompt user to confirm they really want to logout...

          final manager = GetIt.instance<AuthSessionManager>();
          await manager.logout();
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
              fontWeight: FontWeight.w600,
            ),
          ),
          activeStyle: MenuDrawerItemStyle(
            iconColor: Color(0xFFDEFFFF),
            labelTextStyle: TextStyle(
              color: Color(0xFFDEFFFF),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          disabledStyle: MenuDrawerItemStyle(
            iconColor: Color(0xFF505050),
            labelTextStyle: TextStyle(
              color: Color(0xFF505050),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      child: MenuDrawer(
        isCollapsed: _isMenuCollapsed,
        header: MenuDrawerHeader(
          isCollapsed: _isMenuCollapsed,
          onTap: () {
            final collapsed = !_isMenuCollapsed.value;

            if (collapsed) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }

            _isMenuCollapsed.value = isMenuCollapsed = collapsed;
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
        contextualItems: contextualItems.map((e) {
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
