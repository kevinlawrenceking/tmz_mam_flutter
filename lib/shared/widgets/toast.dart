import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

enum ToastTypeEnum {
  success,
  information,
  warning,
  error,
}

class Toast {
  static void showNotification({
    required ToastTypeEnum type,
    Duration showDuration = const Duration(milliseconds: 2500),
    String? title,
    String? message,
  }) {
    const fontSize = 16.0;

    Color backgroundColor;
    Color borderColor;
    Color titleColor;
    Color messageColor;

    IconData icon;
    Color iconColor;
    const iconSize = 36.0;

    switch (type) {
      case ToastTypeEnum.success:
        backgroundColor = const Color(0xC7043823);
        borderColor = const Color(0xFF10B981);
        titleColor = const Color(0xFFFFFFFF);
        messageColor = const Color(0xFFFFFFFF);

        icon = MdiIcons.checkCircleOutline;
        iconColor = const Color(0xFF10B981);

        break;
      case ToastTypeEnum.information:
        backgroundColor = const Color(0xC717325D);
        borderColor = const Color(0xFF3B82F6);
        titleColor = const Color(0xFFFFFFFF);
        messageColor = const Color(0xFFFFFFFF);

        icon = MdiIcons.informationOutline;
        iconColor = const Color(0xFF3B82F6);

        break;
      case ToastTypeEnum.warning:
        backgroundColor = const Color(0xC7634C07);
        borderColor = const Color(0xFFEAB308);
        titleColor = const Color(0xFFFFFFFF);
        messageColor = const Color(0xFFFFFFFF);

        icon = MdiIcons.alertRhombusOutline;
        iconColor = const Color(0xFFEAB308);

        break;
      case ToastTypeEnum.error:
        backgroundColor = const Color(0xC7270303);
        borderColor = const Color(0xFFEF4444);
        titleColor = const Color(0xFFFFFFFF);
        messageColor = const Color(0xFFFFFFFF);

        icon = MdiIcons.closeCircleOutline;
        iconColor = const Color(0xFFEF4444);

        break;
    }

    BotToast.showAnimationWidget(
      onlyOne: true,
      duration: showDuration,
      animationDuration: const Duration(milliseconds: 200),
      wrapToastAnimation: (controller, cancelFunc, child) {
        return child
            .animate(
              controller: controller,
            )
            .move(
              curve: Curves.decelerate,
              begin: const Offset(0, 40),
              end: Offset.zero,
            )
            .fadeIn(
              curve: Curves.decelerate,
              begin: 0.0,
            );
      },
      toastBuilder: (cancelFunc) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: cancelFunc,
            child: Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 40),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: kElevationToShadow[3],
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 22.0, 16.0),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: borderColor,
                      width: 6.0,
                    ),
                  ),
                  color: backgroundColor,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      color: iconColor,
                      size: iconSize,
                    ),
                    const SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        () {
                          if (title != null) {
                            return Text(
                              title,
                              style: TextStyle(
                                color: titleColor,
                                fontSize: fontSize,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                              ),
                            );
                          } else {
                            return Text(
                              message ?? '',
                              style: TextStyle(
                                color: messageColor,
                                fontSize: fontSize,
                                letterSpacing: 0,
                              ),
                            );
                          }
                        }(),
                        if ((title != null) && (message != null))
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              message,
                              style: TextStyle(
                                color: messageColor,
                                fontSize: fontSize,
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
