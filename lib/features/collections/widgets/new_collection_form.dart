import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:tmz_damz/data/models/access_control_permission_map.dart';
import 'package:tmz_damz/shared/widgets/content_menus/editable_text_context_menu_builder.dart';

class NewCollectionForm extends StatefulWidget {
  final AccessControlPermissionMapModel? permissions;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final ValueNotifier<bool> isPrivateController;
  final ValueNotifier<bool> autoClearController;
  final ValueNotifier<bool> addToFavoritesController;

  const NewCollectionForm({
    super.key,
    required this.permissions,
    required this.nameController,
    required this.descriptionController,
    required this.isPrivateController,
    required this.autoClearController,
    required this.addToFavoritesController,
  });

  @override
  State<NewCollectionForm> createState() => _NewCollectionFormState();
}

class _NewCollectionFormState extends State<NewCollectionForm> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Table(
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FixedColumnWidth(20.0),
        2: FlexColumnWidth(),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Name ',
                    style: TextStyle(
                      color: theme.textTheme.bodySmall?.color,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const TextSpan(
                    text: '*',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox.shrink(),
            TextFormField(
              autofocus: true,
              controller: widget.nameController,
              contextMenuBuilder: (context, editableTextState) =>
                  kEditableTextContextMenuBuilder(
                context,
                editableTextState,
                null,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
              ],
            ),
          ],
        ),
        const TableRow(
          children: [
            SizedBox.shrink(),
            SizedBox(height: 10.0),
            SizedBox.shrink(),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                'Description',
                style: TextStyle(
                  color: theme.textTheme.bodySmall?.color,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox.shrink(),
            TextFormField(
              controller: widget.descriptionController,
              contextMenuBuilder: (context, editableTextState) =>
                  kEditableTextContextMenuBuilder(
                context,
                editableTextState,
                null,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(500),
              ],
              minLines: 3,
              maxLines: 5,
            ),
          ],
        ),
        const TableRow(
          children: [
            SizedBox.shrink(),
            SizedBox(height: 20.0),
            SizedBox.shrink(),
          ],
        ),
        TableRow(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Visibility ',
                    style: TextStyle(
                      color: theme.textTheme.bodySmall?.color,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const TextSpan(
                    text: '*',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox.shrink(),
            Row(
              children: [
                AnimatedToggleSwitch.dual(
                  active: widget.permissions?.collections.canCreate ?? false,
                  current: widget.isPrivateController.value,
                  first: false,
                  second: true,
                  height: 30,
                  spacing: 60,
                  borderWidth: 1,
                  indicatorSize: const Size.fromWidth(28),
                  indicatorTransition:
                      const ForegroundIndicatorTransition.fading(),
                  animationDuration: const Duration(milliseconds: 250),
                  styleBuilder: (value) {
                    if (value) {
                      return ToggleStyle(
                        backgroundColor: const Color(0xFF1D1E1F),
                        borderColor: const Color(0xFF101010),
                        indicatorColor: const Color(0xFFD5D7DD),
                        indicatorBorder: Border.all(
                          color: Colors.black.withAlpha(180),
                        ),
                      );
                    } else {
                      return ToggleStyle(
                        backgroundColor: const Color(0xFF1D1E1F),
                        borderColor: const Color(0xFF101010),
                        indicatorColor: const Color(0xFF40434C),
                        indicatorBorder: Border.all(
                          color: Colors.black.withAlpha(180),
                        ),
                      );
                    }
                  },
                  textBuilder: (value) {
                    if (value) {
                      return Text(
                        'PRIVATE',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    } else {
                      return Text(
                        'PUBLIC',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF505662),
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      widget.isPrivateController.value = value;
                    });
                  },
                ),
                const SizedBox(width: 20.0),
                AnimatedCrossFade(
                  firstChild: Icon(
                    MdiIcons.eyeLock,
                    color: const Color(0xFFFFA600),
                    shadows: kElevationToShadow[1],
                  ),
                  secondChild: Icon(
                    MdiIcons.eyeLock,
                    color: theme.colorScheme.primary.withAlpha(40),
                    shadows: kElevationToShadow[1],
                  ),
                  crossFadeState: widget.isPrivateController.value
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 200),
                ),
              ],
            ),
          ],
        ),
        const TableRow(
          children: [
            SizedBox.shrink(),
            SizedBox(height: 10.0),
            SizedBox.shrink(),
          ],
        ),
        TableRow(
          children: [
            const SizedBox.shrink(),
            const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.only(
                left: 4.0,
              ),
              child: Text(
                // ignore: lines_longer_than_80_chars
                'Private collections are only visible to you and cannot be shared with others at this time.',
                style: TextStyle(
                  color: theme.textTheme.bodySmall?.color,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
        const TableRow(
          children: [
            SizedBox.shrink(),
            SizedBox(height: 20.0),
            SizedBox.shrink(),
          ],
        ),
        TableRow(
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Auto-clear ',
                    style: TextStyle(
                      color: theme.textTheme.bodySmall?.color,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const TextSpan(
                    text: '*',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox.shrink(),
            Row(
              children: [
                AnimatedToggleSwitch.dual(
                  current: widget.autoClearController.value,
                  first: false,
                  second: true,
                  height: 30,
                  spacing: 60,
                  borderWidth: 1,
                  indicatorSize: const Size.fromWidth(28),
                  indicatorTransition:
                      const ForegroundIndicatorTransition.fading(),
                  animationDuration: const Duration(milliseconds: 250),
                  styleBuilder: (value) {
                    if (value) {
                      return ToggleStyle(
                        backgroundColor: const Color(0xFF1D1E1F),
                        borderColor: const Color(0xFF101010),
                        indicatorColor: const Color(0xFFD5D7DD),
                        indicatorBorder: Border.all(
                          color: Colors.black.withAlpha(180),
                        ),
                      );
                    } else {
                      return ToggleStyle(
                        backgroundColor: const Color(0xFF1D1E1F),
                        borderColor: const Color(0xFF101010),
                        indicatorColor: const Color(0xFF40434C),
                        indicatorBorder: Border.all(
                          color: Colors.black.withAlpha(180),
                        ),
                      );
                    }
                  },
                  textBuilder: (value) {
                    if (value) {
                      return Text(
                        'ENABLE',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    } else {
                      return Text(
                        'DISABLE',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF505662),
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      widget.autoClearController.value = value;
                    });
                  },
                ),
                const SizedBox(width: 20.0),
                AnimatedCrossFade(
                  firstChild: Icon(
                    MdiIcons.deleteClockOutline,
                    color: const Color(0xFF0084FF),
                    shadows: kElevationToShadow[1],
                  ),
                  secondChild: Icon(
                    MdiIcons.deleteClockOutline,
                    color: theme.colorScheme.primary.withAlpha(40),
                    shadows: kElevationToShadow[1],
                  ),
                  crossFadeState: widget.autoClearController.value
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 200),
                ),
              ],
            ),
          ],
        ),
        const TableRow(
          children: [
            SizedBox.shrink(),
            SizedBox(height: 10.0),
            SizedBox.shrink(),
          ],
        ),
        TableRow(
          children: [
            const SizedBox.shrink(),
            const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.only(
                left: 4.0,
              ),
              child: Text(
                // ignore: lines_longer_than_80_chars
                'Enabling auto-clear will make DAMZ remove all associated assets from this collection automatically each night at 11PM.',
                style: TextStyle(
                  color: theme.textTheme.bodySmall?.color,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
        const TableRow(
          children: [
            SizedBox.shrink(),
            SizedBox(height: 20.0),
            SizedBox.shrink(),
          ],
        ),
        TableRow(
          children: [
            Text(
              'Add to Favorites',
              style: TextStyle(
                color: theme.textTheme.bodySmall?.color,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox.shrink(),
            Align(
              alignment: Alignment.centerLeft,
              child: Checkbox(
                value: widget.addToFavoritesController.value,
                onChanged: (value) {
                  setState(() {
                    widget.addToFavoritesController.value = value ?? false;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
