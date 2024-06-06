import 'package:bot_toast/bot_toast.dart';
import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:tmz_damz/app_router.dart';
import 'package:tmz_damz/shared/widgets/app_scaffold/app_scaffold.dart';
import 'package:tmz_damz/themes/app_theme.dart';
import 'package:tmz_damz/themes/theme_provider.dart';
import 'package:tmz_damz/utils/route_change_notifier.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            final router = GetIt.instance<AppRouter>();

            return ChangeNotifierProvider(
              create: (context) => RouteChangeNotifier(),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppScaffold(
                      router: router,
                    ),
                    Expanded(
                      child: MaterialApp.router(
                        debugShowCheckedModeBanner: false,
                        title: 'TMZ DAMZ',
                        theme: AppTheme.light(context),
                        darkTheme: AppTheme.dark(context),
                        themeMode: ThemeMode.dark, // themeProvider.themeMode
                        builder: (context, child) {
                          return ContextMenuOverlay(
                            cardBuilder: (context, children) {
                              return _buildContextMenuCard(
                                children: children,
                              );
                            },
                            buttonBuilder: (context, config, [style]) {
                              return _ContextMenuButton(
                                config: config,
                                style: style,
                              );
                            },
                            dividerBuilder: (context) {
                              return const Divider(
                                color: Color(
                                  0x20FFFFFF,
                                ),
                                height: 7.0,
                                thickness: 1.0,
                              );
                            },
                            child: BotToastInit()(
                              context,
                              Material(
                                child: child,
                              ),
                            ),
                          );
                        },
                        routerConfig: router.config(
                          navigatorObservers: () => [
                            BotToastNavigatorObserver(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContextMenuCard({
    required List<Widget> children,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 250),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 6.0,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          border: Border.all(),
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: kElevationToShadow[4],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
    );
  }
}

class _ContextMenuButton extends StatefulWidget {
  final ContextMenuButtonConfig config;
  final ContextMenuButtonStyle? style;

  const _ContextMenuButton({
    required this.config,
    required this.style,
  });

  @override
  State<_ContextMenuButton> createState() => _ContextMenuButtonState();
}

class _ContextMenuButtonState extends State<_ContextMenuButton> {
  bool _isMouseOver = false;
  set isMouseOver(bool isMouseOver) => setState(
        () => _isMouseOver = isMouseOver,
      );

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.config.onPressed == null;
    final showMouseOver = _isMouseOver && !isDisabled;

    final theme = Theme.of(context);

    final style = ContextMenuButtonStyle(
      fgColor: widget.style?.fgColor ?? theme.colorScheme.primary,
      bgColor: widget.style?.bgColor ?? Colors.transparent,
      hoverFgColor: widget.style?.hoverFgColor ?? theme.colorScheme.primary,
      hoverBgColor: widget.style?.hoverBgColor ??
          theme.colorScheme.surface.withOpacity(0.2),
      padding: widget.style?.padding ??
          const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 10.0,
          ),
      textStyle: widget.style?.textStyle ??
          theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSecondary,
          ),
      shortcutTextStyle: widget.style?.shortcutTextStyle ??
          theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSecondary,
          ),
      disabledOpacity: widget.style?.disabledOpacity ?? 0.25,
    );

    return GestureDetector(
      onTapDown: (_) => isMouseOver = true,
      onTapUp: (_) {
        isMouseOver = false;
        widget.config.onPressed?.call();
      },
      child: MouseRegion(
        onEnter: (_) => isMouseOver = true,
        onExit: (_) => isMouseOver = false,
        cursor:
            !isDisabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        child: Opacity(
          opacity: isDisabled ? style.disabledOpacity : 1.0,
          child: Container(
            color: showMouseOver ? style.hoverBgColor : style.bgColor,
            padding: style.padding,
            width: double.infinity,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.config.icon != null) ...[
                  showMouseOver
                      ? widget.config.iconHover ?? widget.config.icon!
                      : widget.config.icon!,
                  const SizedBox(width: 12.0),
                ],
                Text(
                  widget.config.label,
                  style: style.textStyle!.copyWith(
                    color: showMouseOver ? style.hoverFgColor : style.fgColor,
                  ),
                ),
                const Spacer(),
                if (widget.config.shortcutLabel != null) ...[
                  const SizedBox(width: 50.0),
                  Opacity(
                    opacity: showMouseOver ? 1.0 : 0.7,
                    child: Text(
                      widget.config.shortcutLabel!,
                      style: (style.shortcutTextStyle ?? style.textStyle!)
                          .copyWith(
                        color:
                            showMouseOver ? style.hoverFgColor : style.fgColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
