import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void showConfirmationPrompt({
  required BuildContext context,
  double width = 500.0,
  required String title,
  required String message,
  required VoidCallback onConfirm,
  VoidCallback? onCancel,
}) {
  BotToast.showAnimationWidget(
    animationDuration: const Duration(milliseconds: 100),
    allowClick: false,
    clickClose: false,
    crossPage: false,
    onlyOne: true,
    wrapToastAnimation: (controller, cancelFunc, child) {
      return Stack(
        children: [
          GestureDetector(
            onTap: () => cancelFunc(),
            child: const DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black26,
              ),
              child: SizedBox.expand(),
            ),
          ),
          child
              .animate(
                controller: controller,
              )
              .move(
                curve: Curves.decelerate,
                begin: const Offset(0, 20),
                end: Offset.zero,
              ),
        ],
      )
          .animate(
            controller: controller,
          )
          .fadeIn(
            curve: Curves.decelerate,
            begin: 0.0,
          );
    },
    toastBuilder: (cancelFunc) {
      final theme = Theme.of(context);

      return Center(
        child: Container(
          width: width,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFF1D1E1F),
            ),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: kElevationToShadow[8],
            color: const Color(0xFF232323),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                color: const Color(0xFF1D1E1F),
                child: Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: Colors.blue,
                    letterSpacing: 1.0,
                  ),
                  softWrap: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  top: 20.0,
                  right: 20.0,
                  bottom: 10.0,
                ),
                child: Row(
                  children: [
                    Icon(
                      MdiIcons.helpCircleOutline,
                      color: Colors.blue,
                      size: 36.0,
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Text(
                        message,
                        style: theme.textTheme.bodySmall,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: 100.0,
                      child: TextButton(
                        onPressed: () {
                          cancelFunc();
                          onConfirm();
                        },
                        style: theme.textButtonTheme.style,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          child: Text(
                            'Confirm',
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    SizedBox(
                      width: 100.0,
                      child: TextButton(
                        onPressed: () {
                          cancelFunc();
                          onCancel?.call();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0x30FFFFFF),
                          ),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 6.0,
                            ),
                          ),
                          shape: MaterialStateProperty.resolveWith(
                            (states) {
                              return RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Color(0x80000000),
                                ),
                                borderRadius: BorderRadius.circular(6.0),
                              );
                            },
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          child: Text(
                            'Cancel',
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
