import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmz_damz/data/models/asset_import_session_file.dart';
import 'package:tmz_damz/data/models/asset_metadata.dart';
import 'package:tmz_damz/features/asset_import/view_models/bulk_meta_view_model.dart';
import 'package:tmz_damz/features/metadata_picklists/widgets/picklist_agency_tag_field.dart';
import 'package:tmz_damz/features/metadata_picklists/widgets/picklist_celebrity_tag_field.dart';
import 'package:tmz_damz/features/metadata_picklists/widgets/picklist_keyword_tag_field.dart';
import 'package:tmz_damz/shared/widgets/content_menus/editable_text_context_menu_builder.dart';
import 'package:tmz_damz/utils/debounce_timer.dart';

class SessionFileForm extends StatefulWidget {
  final SessionFileFormController controller;
  final void Function(AssetImportSessionFileMetaModel model)? onChange;

  const SessionFileForm({
    super.key,
    required this.controller,
    required this.onChange,
  });

  @override
  State<SessionFileForm> createState() => _SessionFileFormState();
}

class _SessionFileFormState extends State<SessionFileForm> {
  final _onChangeDebounce = DebounceTimer(
    delay: const Duration(
      milliseconds: 1000,
    ),
  );

  var _picklistAgencyTagFieldUniqueKey = UniqueKey();
  final _picklistAgencyTagFieldFocusNode = FocusNode();
  var _picklistCelebrityAssociatedTagFieldUniqueKey = UniqueKey();
  final _picklistCelebrityAssociatedTagFieldFocusNode = FocusNode();
  var _picklistCelebrityInPhotoTagFieldUniqueKey = UniqueKey();
  final _picklistCelebrityInPhotoTagFieldFocusNode = FocusNode();
  var _picklistKeywordsTagFieldUniqueKey = UniqueKey();
  final _picklistKeywordsTagFieldFocusNode = FocusNode();

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    if (mounted) {
      setState(() {
        _picklistAgencyTagFieldUniqueKey = UniqueKey();
        _picklistCelebrityAssociatedTagFieldUniqueKey = UniqueKey();
        _picklistCelebrityInPhotoTagFieldUniqueKey = UniqueKey();
        _picklistKeywordsTagFieldUniqueKey = UniqueKey();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FocusScope(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeadline(theme),
          const SizedBox(height: 10.0),
          _buildCelebrity(theme),
          const SizedBox(height: 10.0),
          AnimatedCrossFade(
            firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
            secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
            sizeCurve: Curves.fastOutSlowIn,
            crossFadeState: widget.controller.celebrity
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: kThemeAnimationDuration,
            firstChild: const SizedBox(height: 0.0),
            secondChild: Column(
              children: [
                _buildCelebrityInPhoto(theme),
                const SizedBox(height: 10.0),
                _buildCelebrityAssociated(theme),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
          _buildShotDescription(theme),
          const SizedBox(height: 10.0),
          _buildKeywords(theme),
          const SizedBox(height: 10.0),
          _buildAgency(theme),
          const SizedBox(height: 20.0),
          _buildEmotions(theme),
          const SizedBox(height: 20.0),
          _buildOverlays(theme),
          const SizedBox(height: 20.0),
          _buildRightsSummary(theme),
          AnimatedCrossFade(
            firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
            secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
            sizeCurve: Curves.fastOutSlowIn,
            crossFadeState:
                (widget.controller.rights == AssetMetadataRightsEnum.unknown) ||
                        (widget.controller.rights ==
                            AssetMetadataRightsEnum.freeTMZ)
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
            duration: kThemeAnimationDuration,
            firstChild: const SizedBox(height: 0.0),
            secondChild: Column(
              children: [
                const SizedBox(height: 20.0),
                _buildCreditLocation(theme),
                const SizedBox(height: 20.0),
                _buildCredit(theme),
                const SizedBox(height: 10.0),
                _buildRightsInstructions(theme),
                const SizedBox(height: 10.0),
                _buildRightsDetails(theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgency(ThemeData theme) {
    return Row(
      children: [
        SizedBox(
          width: 150.0,
          child: Text(
            'Agency',
            style: TextStyle(
              color: theme.textTheme.labelMedium?.color,
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Builder(
            builder: (context) {
              return PicklistAgencyTagField(
                key: _picklistAgencyTagFieldUniqueKey,
                focusNode: _picklistAgencyTagFieldFocusNode,
                canAddNewtags: true,
                tags: widget.controller.agency,
                onChange: (tags) {
                  setState(() {
                    widget.controller.agency = tags;
                  });

                  _picklistAgencyTagFieldFocusNode.requestFocus();

                  _onChangeDebounce.wrap(() {
                    widget.onChange?.call(widget.controller.getModel());
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCelebrity(ThemeData theme) {
    return Row(
      children: [
        SizedBox(
          width: 150.0,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Celebrity ',
                  style: TextStyle(
                    color: theme.textTheme.labelMedium?.color,
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
        ),
        const SizedBox(width: 20.0),
        AnimatedToggleSwitch.dual(
          current: widget.controller.celebrity,
          first: false,
          second: true,
          height: 30,
          borderWidth: 1,
          indicatorSize: const Size.fromWidth(28),
          indicatorTransition: const ForegroundIndicatorTransition.fading(),
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
                'YES',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                ),
              );
            } else {
              return Text(
                'NO',
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
              widget.controller.celebrity = value;
            });

            _onChangeDebounce.wrap(() {
              widget.onChange?.call(widget.controller.getModel());
            });
          },
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildCelebrityAssociated(ThemeData theme) {
    return Row(
      children: [
        SizedBox(
          width: 150.0,
          child: Text(
            'Celebrity (Associated)',
            style: TextStyle(
              color: theme.textTheme.labelMedium?.color,
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Builder(
            builder: (context) {
              return PicklistCelebrityTagField(
                key: _picklistCelebrityAssociatedTagFieldUniqueKey,
                focusNode: _picklistCelebrityAssociatedTagFieldFocusNode,
                canAddNewtags: true,
                tags: widget.controller.celebrityAssociated,
                onChange: (tags) {
                  setState(() {
                    widget.controller.celebrityAssociated = tags;
                  });

                  _picklistCelebrityAssociatedTagFieldFocusNode.requestFocus();

                  _onChangeDebounce.wrap(() {
                    widget.onChange?.call(widget.controller.getModel());
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCelebrityInPhoto(ThemeData theme) {
    return Row(
      children: [
        SizedBox(
          width: 150.0,
          child: Text(
            'Celebrity (In Photo)',
            style: TextStyle(
              color: theme.textTheme.labelMedium?.color,
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Builder(
            builder: (context) {
              return PicklistCelebrityTagField(
                key: _picklistCelebrityInPhotoTagFieldUniqueKey,
                focusNode: _picklistCelebrityInPhotoTagFieldFocusNode,
                canAddNewtags: true,
                tags: widget.controller.celebrityInPhoto,
                onChange: (tags) {
                  setState(() {
                    widget.controller.celebrityInPhoto = tags;
                  });

                  _picklistCelebrityInPhotoTagFieldFocusNode.requestFocus();

                  _onChangeDebounce.wrap(() {
                    widget.onChange?.call(widget.controller.getModel());
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCredit(ThemeData theme) {
    final undoController = UndoHistoryController();

    return Row(
      children: [
        SizedBox(
          width: 150.0,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Credit ',
                  style: TextStyle(
                    color: theme.textTheme.labelMedium?.color,
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
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: TextFormField(
            key: UniqueKey(),
            controller: widget.controller._creditController,
            undoController: undoController,
            contextMenuBuilder: (context, editableTextState) =>
                kEditableTextContextMenuBuilder(
              context,
              editableTextState,
              undoController,
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(50),
            ],
            onChanged: (value) {
              _onChangeDebounce.wrap(() {
                widget.onChange?.call(widget.controller.getModel());
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCreditLocation(ThemeData theme) {
    return Row(
      children: [
        SizedBox(
          width: 150.0,
          child: Text(
            'Credit Location',
            style: TextStyle(
              color: theme.textTheme.labelMedium?.color,
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Choice.inline(
            value: [widget.controller.creditLocation],
            itemCount: 2,
            itemBuilder: (state, index) {
              const creditLocation = [
                AssetMetadataCreditLocationEnum.end,
                AssetMetadataCreditLocationEnum.onScreen,
              ];

              return ChoiceChip(
                label: Text(
                  {
                        AssetMetadataCreditLocationEnum.end: 'End',
                        AssetMetadataCreditLocationEnum.onScreen: 'On-Screen',
                      }[creditLocation[index]] ??
                      '',
                ),
                selected:
                    widget.controller.creditLocation == creditLocation[index],
                selectedColor: const Color(0xFF8E0000),
                onSelected: (value) {
                  state.replace([creditLocation[index]]);
                },
              );
            },
            onChanged: (value) {
              setState(() {
                widget.controller.creditLocation =
                    value.firstOrNull ?? AssetMetadataCreditLocationEnum.end;
              });

              _onChangeDebounce.wrap(() {
                widget.onChange?.call(widget.controller.getModel());
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmotions(ThemeData theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 150.0,
          child: Text(
            'Emotions',
            style: TextStyle(
              color: theme.textTheme.labelMedium?.color,
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Choice.inline(
            clearable: true,
            multiple: true,
            value: widget.controller.emotion,
            itemCount: 4,
            itemBuilder: (state, index) {
              const emotions = [
                AssetMetadataEmotionEnum.positive,
                AssetMetadataEmotionEnum.negative,
                AssetMetadataEmotionEnum.surprised,
                AssetMetadataEmotionEnum.neutral,
              ];

              return ChoiceChip(
                label: Text(
                  {
                        AssetMetadataEmotionEnum.positive: 'Positive',
                        AssetMetadataEmotionEnum.negative: 'Negative',
                        AssetMetadataEmotionEnum.surprised: 'Surprised',
                        AssetMetadataEmotionEnum.neutral: 'Neutral',
                      }[emotions[index]] ??
                      '',
                ),
                selected: widget.controller.emotion.contains(emotions[index]),
                selectedColor: const Color(0xFF8E0000),
                onSelected: (value) {
                  if (value) {
                    state.add(emotions[index]);
                  } else {
                    state.remove(emotions[index]);
                  }
                },
              );
            },
            onChanged: (value) {
              setState(() {
                widget.controller.emotion = value;
              });

              _onChangeDebounce.wrap(() {
                widget.onChange?.call(widget.controller.getModel());
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeadline(ThemeData theme) {
    final undoController = UndoHistoryController();

    return Row(
      children: [
        SizedBox(
          width: 150.0,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Headline ',
                  style: TextStyle(
                    color: theme.textTheme.labelMedium?.color,
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
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: TextFormField(
            key: UniqueKey(),
            controller: widget.controller._headlineController,
            undoController: undoController,
            contextMenuBuilder: (context, editableTextState) =>
                kEditableTextContextMenuBuilder(
              context,
              editableTextState,
              undoController,
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(250),
            ],
            onChanged: (value) {
              _onChangeDebounce.wrap(() {
                widget.onChange?.call(widget.controller.getModel());
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildKeywords(ThemeData theme) {
    return Row(
      children: [
        SizedBox(
          width: 150.0,
          child: Text(
            'Keywords',
            style: TextStyle(
              color: theme.textTheme.labelMedium?.color,
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Builder(
            builder: (context) {
              return PicklistKeywordTagField(
                key: _picklistKeywordsTagFieldUniqueKey,
                focusNode: _picklistKeywordsTagFieldFocusNode,
                canAddNewtags: true,
                tags: widget.controller.keywords,
                onChange: (tags) {
                  setState(() {
                    widget.controller.keywords = tags;
                  });

                  _picklistKeywordsTagFieldFocusNode.requestFocus();

                  _onChangeDebounce.wrap(() {
                    widget.onChange?.call(widget.controller.getModel());
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOverlays(ThemeData theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 150.0,
          child: Text(
            'Overlays',
            style: TextStyle(
              color: theme.textTheme.labelMedium?.color,
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Choice.inline(
            clearable: true,
            multiple: true,
            value: widget.controller.overlay,
            itemCount: 3,
            itemBuilder: (state, index) {
              const overlays = [
                AssetMetadataOverlayEnum.blackBarCensor,
                AssetMetadataOverlayEnum.blurCensor,
                AssetMetadataOverlayEnum.watermark,
              ];

              return ChoiceChip(
                label: Text(
                  {
                        AssetMetadataOverlayEnum.blackBarCensor:
                            'Black Bar Censor',
                        AssetMetadataOverlayEnum.blurCensor: 'Blur Censor',
                        AssetMetadataOverlayEnum.watermark: 'Watermark',
                      }[overlays[index]] ??
                      '',
                ),
                selected: widget.controller.overlay.contains(overlays[index]),
                selectedColor: const Color(0xFF8E0000),
                onSelected: (value) {
                  if (value) {
                    state.add(overlays[index]);
                  } else {
                    state.remove(overlays[index]);
                  }
                },
              );
            },
            onChanged: (value) {
              setState(() {
                widget.controller.overlay = value;
              });

              _onChangeDebounce.wrap(() {
                widget.onChange?.call(widget.controller.getModel());
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRightsDetails(ThemeData theme) {
    final undoController = UndoHistoryController();

    return Row(
      children: [
        SizedBox(
          width: 150.0,
          child: Text(
            'Rights Details',
            style: TextStyle(
              color: theme.textTheme.labelMedium?.color,
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: TextFormField(
            key: UniqueKey(),
            controller: widget.controller._rightsDetailsController,
            undoController: undoController,
            contextMenuBuilder: (context, editableTextState) =>
                kEditableTextContextMenuBuilder(
              context,
              editableTextState,
              undoController,
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(250),
            ],
            onChanged: (value) {
              _onChangeDebounce.wrap(() {
                widget.onChange?.call(widget.controller.getModel());
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRightsInstructions(ThemeData theme) {
    final undoController = UndoHistoryController();

    return Row(
      children: [
        SizedBox(
          width: 150.0,
          child: Text(
            'Rights Instructions',
            style: TextStyle(
              color: theme.textTheme.labelMedium?.color,
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: TextFormField(
            key: UniqueKey(),
            controller: widget.controller._rightsInstructionsController,
            undoController: undoController,
            contextMenuBuilder: (context, editableTextState) =>
                kEditableTextContextMenuBuilder(
              context,
              editableTextState,
              undoController,
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(250),
            ],
            onChanged: (value) {
              _onChangeDebounce.wrap(() {
                widget.onChange?.call(widget.controller.getModel());
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRightsSummary(ThemeData theme) {
    return Row(
      children: [
        SizedBox(
          width: 150.0,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Rights Summary ',
                  style: TextStyle(
                    color: theme.textTheme.labelMedium?.color,
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
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Choice.inline(
            value: [widget.controller.rights],
            itemCount: 3,
            itemBuilder: (state, index) {
              const rights = [
                AssetMetadataRightsEnum.freeTMZ,
                AssetMetadataRightsEnum.freeNonTMZ,
                AssetMetadataRightsEnum.costNonTMZ,
              ];

              return ChoiceChip(
                label: Text(
                  {
                        AssetMetadataRightsEnum.costNonTMZ: 'Cost (Non-TMZ)',
                        AssetMetadataRightsEnum.freeNonTMZ: 'Free (Non-TMZ)',
                        AssetMetadataRightsEnum.freeTMZ: 'Free (TMZ)',
                      }[rights[index]] ??
                      '',
                ),
                selected: widget.controller.rights == rights[index],
                selectedColor: const Color(0xFF8E0000),
                onSelected: (value) {
                  state.replace([rights[index]]);
                },
              );
            },
            onChanged: (value) {
              setState(() {
                widget.controller.rights =
                    value.firstOrNull ?? AssetMetadataRightsEnum.unknown;
              });

              _onChangeDebounce.wrap(() {
                widget.onChange?.call(widget.controller.getModel());
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildShotDescription(ThemeData theme) {
    final undoController = UndoHistoryController();

    return Row(
      children: [
        SizedBox(
          width: 150.0,
          child: Text(
            'Shot Description',
            style: TextStyle(
              color: theme.textTheme.labelMedium?.color,
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: TextFormField(
            key: UniqueKey(),
            controller: widget.controller._shotDescriptionController,
            undoController: undoController,
            contextMenuBuilder: (context, editableTextState) =>
                kEditableTextContextMenuBuilder(
              context,
              editableTextState,
              undoController,
            ),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(2000),
            ],
            minLines: 3,
            maxLines: 5,
            onChanged: (value) {
              _onChangeDebounce.wrap(() {
                widget.onChange?.call(widget.controller.getModel());
              });
            },
          ),
        ),
      ],
    );
  }
}

class SessionFileFormController extends ChangeNotifier {
  String? _sessionID;
  String? get sessionID => _sessionID;

  String? _fileID;
  String? get fileID => _fileID;

  AssetImportSessionFileMetaModel? _meta;
  AssetImportSessionFileMetaModel? get meta => _meta;

  final _agencyController = ValueNotifier<List<String>>([]);
  List<String> get agency => _agencyController.value;
  set agency(List<String> value) => _agencyController.value = value;

  final _celebrityController = ValueNotifier<bool>(false);
  bool get celebrity => _celebrityController.value;
  set celebrity(bool value) => _celebrityController.value = value;

  final _celebrityAssociatedController = ValueNotifier<List<String>>([]);
  List<String> get celebrityAssociated => _celebrityAssociatedController.value;
  set celebrityAssociated(List<String> value) =>
      _celebrityAssociatedController.value = value;

  final _celebrityInPhotoController = ValueNotifier<List<String>>([]);
  List<String> get celebrityInPhoto => _celebrityInPhotoController.value;
  set celebrityInPhoto(List<String> value) =>
      _celebrityInPhotoController.value = value;

  final _creditController = TextEditingController();
  String get credit => _creditController.text.trim();
  set credit(String value) => _creditController.text = value;

  final _creditLocationController =
      ValueNotifier<AssetMetadataCreditLocationEnum>(
    AssetMetadataCreditLocationEnum.unknown,
  );
  AssetMetadataCreditLocationEnum get creditLocation =>
      _creditLocationController.value;
  set creditLocation(AssetMetadataCreditLocationEnum value) =>
      _creditLocationController.value = value;

  final _emotionController = ValueNotifier<List<AssetMetadataEmotionEnum>>([]);
  List<AssetMetadataEmotionEnum> get emotion => _emotionController.value;
  set emotion(List<AssetMetadataEmotionEnum> value) =>
      _emotionController.value = value;

  final _headlineController = TextEditingController();
  String get headline => _headlineController.text.trim();
  set headline(String value) => _headlineController.text = value;

  final _keywordsController = ValueNotifier<List<String>>([]);
  List<String> get keywords => _keywordsController.value;
  set keywords(List<String> value) => _keywordsController.value = value;

  final _overlayController = ValueNotifier<List<AssetMetadataOverlayEnum>>([]);
  List<AssetMetadataOverlayEnum> get overlay => _overlayController.value;
  set overlay(List<AssetMetadataOverlayEnum> value) =>
      _overlayController.value = value;

  final _rightsController = ValueNotifier<AssetMetadataRightsEnum>(
    AssetMetadataRightsEnum.unknown,
  );
  AssetMetadataRightsEnum get rights => _rightsController.value;
  set rights(AssetMetadataRightsEnum value) => _rightsController.value = value;

  final _rightsDetailsController = TextEditingController();
  String get rightsDetails => _rightsDetailsController.text.trim();
  set rightsDetails(String value) => _rightsDetailsController.text = value;

  final _rightsInstructionsController = TextEditingController();
  String get rightsInstructions => _rightsInstructionsController.text.trim();
  set rightsInstructions(String value) =>
      _rightsInstructionsController.text = value;

  final _shotDescriptionController = TextEditingController();
  String get shotDescription => _shotDescriptionController.text.trim();
  set shotDescription(String value) => _shotDescriptionController.text = value;

  @override
  void dispose() {
    _agencyController.dispose();
    _celebrityController.dispose();
    _celebrityAssociatedController.dispose();
    _celebrityInPhotoController.dispose();
    _creditLocationController.dispose();
    _emotionController.dispose();
    _headlineController.dispose();
    _keywordsController.dispose();
    _overlayController.dispose();
    _rightsController.dispose();
    _rightsDetailsController.dispose();
    _rightsInstructionsController.dispose();
    _shotDescriptionController.dispose();

    super.dispose();
  }

  AssetImportSessionFileMetaModel getModel() {
    return AssetImportSessionFileMetaModel(
      headline: headline,
      metadata: AssetMetadataModel(
        daletID: null,
        keywords: keywords,
        shotDescription: shotDescription,
        location: _meta?.metadata.location ??
            const AssetMetadataLocationModel(
              description: null,
              country: null,
              state: null,
              city: null,
            ),
        agency: agency,
        emotion: emotion,
        overlay: overlay,
        celebrity: celebrity,
        celebrityInPhoto: celebrity ? celebrityInPhoto : [],
        celebrityAssociated: celebrity ? celebrityAssociated : [],
        rights: rights,
        credit: rights != AssetMetadataRightsEnum.freeTMZ ? credit : null,
        creditLocation:
            rights != AssetMetadataRightsEnum.freeTMZ ? creditLocation : null,
        exclusivity: null,
        rightsInstructions: rights != AssetMetadataRightsEnum.freeTMZ
            ? rightsInstructions
            : null,
        rightsDetails:
            rights != AssetMetadataRightsEnum.freeTMZ ? rightsDetails : null,
        qcNotes: null,
      ),
    );
  }

  void reset() {
    _agencyController.value = _meta?.metadata.agency ?? [];

    _celebrityController.value = _meta?.metadata.celebrity ?? true;

    _celebrityAssociatedController.value =
        _meta?.metadata.celebrityAssociated ?? [];

    _celebrityInPhotoController.value = _meta?.metadata.celebrityInPhoto ?? [];

    _creditController.text = _meta?.metadata.credit ?? '';

    if ((_meta?.metadata.creditLocation != null) &&
        (_meta?.metadata.creditLocation !=
            AssetMetadataCreditLocationEnum.unknown)) {
      _creditLocationController.value = _meta!.metadata.creditLocation!;
    } else {
      _creditLocationController.value = AssetMetadataCreditLocationEnum.end;
    }

    _emotionController.value = _meta?.metadata.emotion ?? [];

    _headlineController.text = _meta?.headline ?? '';

    _keywordsController.value = _meta?.metadata.keywords ?? [];

    _overlayController.value = _meta?.metadata.overlay ?? [];

    _rightsController.value =
        _meta?.metadata.rights ?? AssetMetadataRightsEnum.unknown;

    _rightsDetailsController.text = _meta?.metadata.rightsDetails ?? '';

    _rightsInstructionsController.text =
        _meta?.metadata.rightsInstructions ?? '';

    _shotDescriptionController.text = _meta?.metadata.shotDescription ?? '';
  }

  void setFrom({
    required String sessionID,
    required String fileID,
    required AssetImportSessionFileMetaModel meta,
  }) {
    _sessionID = sessionID;
    _fileID = fileID;
    _meta = meta;

    reset();
  }

  void setFromBulk(BulkMetaViewModel model) {
    if (model.agency != null) {
      agency = model.agency!;
    }

    if (model.celebrity != null) {
      celebrity = model.celebrity!;
    }

    if (model.celebrityAssociated != null) {
      celebrityAssociated = model.celebrityAssociated!;
    }

    if (model.celebrityInPhoto != null) {
      celebrityInPhoto = model.celebrityInPhoto!;
    }

    if (model.credit != null) {
      credit = model.credit!;
    }

    if (model.creditLocation != null) {
      creditLocation = model.creditLocation!;
    }

    if (model.emotion != null) {
      emotion = model.emotion!;
    }

    if (model.headline != null) {
      headline = model.headline!;
    }

    if (model.keywords != null) {
      keywords = model.keywords!;
    }

    if (model.overlay != null) {
      overlay = model.overlay!;
    }

    if (model.rights != null) {
      rights = model.rights!;
    }

    if (model.rightsDetails != null) {
      rightsDetails = model.rightsDetails!;
    }

    if (model.rightsInstructions != null) {
      rightsInstructions = model.rightsInstructions!;
    }

    if (model.shotDescription != null) {
      shotDescription = model.shotDescription!;
    }

    notifyListeners();
  }
}
