import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmz_damz/data/models/asset_import_session_file.dart';
import 'package:tmz_damz/data/models/asset_metadata.dart';
import 'package:tmz_damz/features/asset_import/view_models/bulk_meta_view_model.dart';
import 'package:tmz_damz/features/asset_import/widgets/picklist_agency_tag_field.dart';
import 'package:tmz_damz/features/asset_import/widgets/picklist_celebrity_tag_field.dart';
import 'package:tmz_damz/features/asset_import/widgets/picklist_keyword_tag_field.dart';
import 'package:tmz_damz/shared/widgets/content_menus/editable_text_context_menu_builder.dart';

class BulkUpdateForm extends StatefulWidget {
  final BulkUpdateFormController controller;
  final void Function(BulkMetaViewModel meta) onApply;

  const BulkUpdateForm({
    super.key,
    required this.controller,
    required this.onApply,
  });

  @override
  State<BulkUpdateForm> createState() => _BulkUpdateFormState();
}

class _BulkUpdateFormState extends State<BulkUpdateForm> {
  bool _includeAgency = false;
  bool _includeCelebrity = false;
  bool _includeCelebrityAssociated = false;
  bool _includeCelebrityInPhoto = false;
  bool _includeCredit = false;
  bool _includeCreditLocation = false;
  bool _includeEmotions = false;
  bool _includeHeadline = false;
  bool _includeKeywords = false;
  bool _includeOverlays = false;
  bool _includeRightsDetails = false;
  bool _includeRightsInstructions = false;
  bool _includeRightsSummary = false;
  bool _includeShotDescription = false;

  final _picklistAgencyTagFieldFocusNode = FocusNode();
  final _picklistCelebrityAssociatedTagFieldFocusNode = FocusNode();
  final _picklistCelebrityInPhotoTagFieldFocusNode = FocusNode();
  final _picklistKeywordsTagFieldFocusNode = FocusNode();

  @override
  void dispose() {
    _picklistAgencyTagFieldFocusNode.dispose();
    _picklistCelebrityAssociatedTagFieldFocusNode.dispose();
    _picklistCelebrityInPhotoTagFieldFocusNode.dispose();
    _picklistKeywordsTagFieldFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FocusScope(
      child: ExpansionTile(
        backgroundColor: const Color(0x10FFFFFF),
        collapsedBackgroundColor: const Color(0x10FFFFFF),
        clipBehavior: Clip.antiAlias,
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        tilePadding: const EdgeInsets.only(
          left: 20.0,
          top: 10.0,
          right: 20.0,
          bottom: 10.0,
        ),
        title: Text(
          'Bulk Update',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 40.0,
              top: 20.0,
              right: 40.0,
              bottom: 40.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeadline(theme),
                const SizedBox(height: 10.0),
                _buildCelebrity(theme),
                const SizedBox(height: 10.0),
                AnimatedCrossFade(
                  firstCurve:
                      const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
                  secondCurve:
                      const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
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
                  firstCurve:
                      const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
                  secondCurve:
                      const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
                  sizeCurve: Curves.fastOutSlowIn,
                  crossFadeState: (widget.controller.rights ==
                              AssetMetadataRightsEnum.unknown) ||
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
                const SizedBox(height: 40.0),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0x30FFFFFF)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Color(0x80000000),
                        ),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14.0,
                      vertical: 10.0,
                    ),
                    child: Text(
                      'APPLY TO ALL',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  onPressed: () {
                    widget.onApply(
                      BulkMetaViewModel(
                        agency:
                            _includeAgency ? widget.controller.agency : null,
                        celebrity: _includeCelebrity
                            ? widget.controller.celebrity
                            : null,
                        celebrityAssociated: _includeCelebrityAssociated
                            ? widget.controller.celebrityAssociated
                            : null,
                        celebrityInPhoto: _includeCelebrityInPhoto
                            ? widget.controller.celebrityInPhoto
                            : null,
                        credit:
                            _includeCredit ? widget.controller.credit : null,
                        creditLocation: _includeCreditLocation
                            ? widget.controller.creditLocation
                            : null,
                        emotion:
                            _includeEmotions ? widget.controller.emotion : null,
                        headline: _includeHeadline
                            ? widget.controller.headline
                            : null,
                        keywords: _includeKeywords
                            ? widget.controller.keywords
                            : null,
                        overlay:
                            _includeOverlays ? widget.controller.overlay : null,
                        rights: _includeRightsSummary
                            ? widget.controller.rights
                            : null,
                        rightsDetails: _includeRightsDetails
                            ? widget.controller.rightsDetails
                            : null,
                        rightsInstructions: _includeRightsInstructions
                            ? widget.controller.rightsInstructions
                            : null,
                        shotDescription: _includeShotDescription
                            ? widget.controller.shotDescription
                            : null,
                      ),
                    );
                  },
                ),
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
        AnimatedToggleSwitch.dual(
          current: _includeAgency,
          first: false,
          second: true,
          height: 30,
          borderWidth: 1,
          spacing: 0.0,
          indicatorSize: const Size.fromWidth(28),
          indicatorTransition: const ForegroundIndicatorTransition.fading(),
          animationDuration: const Duration(milliseconds: 250),
          styleBuilder: _toggleSwitchStyleBuilder,
          onChanged: (value) {
            setState(() {
              _includeAgency = value;
            });
          },
        ),
        const SizedBox(width: 20.0),
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
          child: PicklistAgencyTagField(
            focusNode: _picklistAgencyTagFieldFocusNode,
            enabled: _includeAgency,
            tags: widget.controller.agency,
            onChange: (tags) {
              setState(() {
                widget.controller.agency = tags;
              });

              _picklistAgencyTagFieldFocusNode.requestFocus();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCelebrity(ThemeData theme) {
    return Row(
      children: [
        AnimatedToggleSwitch.dual(
          current: _includeCelebrity,
          first: false,
          second: true,
          height: 30,
          borderWidth: 1,
          spacing: 0.0,
          indicatorSize: const Size.fromWidth(28),
          indicatorTransition: const ForegroundIndicatorTransition.fading(),
          animationDuration: const Duration(milliseconds: 250),
          styleBuilder: _toggleSwitchStyleBuilder,
          onChanged: (value) {
            setState(() {
              _includeCelebrity = value;

              if (!value) {
                _includeCelebrityAssociated = false;
                _includeCelebrityInPhoto = false;
              }
            });
          },
        ),
        const SizedBox(width: 20.0),
        SizedBox(
          width: 150.0,
          child: Text(
            'Celebrity',
            style: TextStyle(
              color: theme.textTheme.labelMedium?.color,
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        AnimatedToggleSwitch.dual(
          active: _includeCelebrity,
          current: widget.controller.celebrity,
          first: false,
          second: true,
          height: 30,
          borderWidth: 1,
          indicatorSize: const Size.fromWidth(28),
          indicatorTransition: const ForegroundIndicatorTransition.fading(),
          animationDuration: const Duration(milliseconds: 250),
          styleBuilder: _toggleSwitchStyleBuilder,
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
          },
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildCelebrityAssociated(ThemeData theme) {
    return Row(
      children: [
        AnimatedToggleSwitch.dual(
          active: _includeCelebrity,
          current: _includeCelebrityAssociated,
          first: false,
          second: true,
          height: 30,
          borderWidth: 1,
          spacing: 0.0,
          indicatorSize: const Size.fromWidth(28),
          indicatorTransition: const ForegroundIndicatorTransition.fading(),
          animationDuration: const Duration(milliseconds: 250),
          styleBuilder: _toggleSwitchStyleBuilder,
          onChanged: (value) {
            setState(() {
              _includeCelebrityAssociated = value;
            });
          },
        ),
        const SizedBox(width: 20.0),
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
          child: PicklistCelebrityTagField(
            focusNode: _picklistCelebrityAssociatedTagFieldFocusNode,
            enabled: _includeCelebrityAssociated,
            tags: widget.controller.celebrityAssociated,
            onChange: (tags) {
              setState(() {
                widget.controller.celebrityAssociated = tags;
              });

              _picklistCelebrityAssociatedTagFieldFocusNode.requestFocus();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCelebrityInPhoto(ThemeData theme) {
    return Row(
      children: [
        AnimatedToggleSwitch.dual(
          active: _includeCelebrity,
          current: _includeCelebrityInPhoto,
          first: false,
          second: true,
          height: 30,
          borderWidth: 1,
          spacing: 0.0,
          indicatorSize: const Size.fromWidth(28),
          indicatorTransition: const ForegroundIndicatorTransition.fading(),
          animationDuration: const Duration(milliseconds: 250),
          styleBuilder: _toggleSwitchStyleBuilder,
          onChanged: (value) {
            setState(() {
              _includeCelebrityInPhoto = value;
            });
          },
        ),
        const SizedBox(width: 20.0),
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
          child: PicklistCelebrityTagField(
            focusNode: _picklistCelebrityInPhotoTagFieldFocusNode,
            enabled: _includeCelebrityInPhoto,
            tags: widget.controller.celebrityInPhoto,
            onChange: (tags) {
              setState(() {
                widget.controller.celebrityInPhoto = tags;
              });

              _picklistCelebrityInPhotoTagFieldFocusNode.requestFocus();
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
        AnimatedToggleSwitch.dual(
          active: _includeRightsSummary,
          current: _includeCredit,
          first: false,
          second: true,
          height: 30,
          borderWidth: 1,
          spacing: 0.0,
          indicatorSize: const Size.fromWidth(28),
          indicatorTransition: const ForegroundIndicatorTransition.fading(),
          animationDuration: const Duration(milliseconds: 250),
          styleBuilder: _toggleSwitchStyleBuilder,
          onChanged: (value) {
            setState(() {
              _includeCredit = value;
            });
          },
        ),
        const SizedBox(width: 20.0),
        SizedBox(
          width: 150.0,
          child: Text(
            'Credit',
            style: TextStyle(
              color: theme.textTheme.labelMedium?.color,
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Opacity(
            opacity: _includeCredit ? 1.0 : 0.5,
            child: TextFormField(
              controller: widget.controller._creditController,
              undoController: undoController,
              contextMenuBuilder: (context, editableTextState) =>
                  kEditableTextContextMenuBuilder(
                context,
                editableTextState,
                undoController,
              ),
              enabled: _includeCredit,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreditLocation(ThemeData theme) {
    return Row(
      children: [
        AnimatedToggleSwitch.dual(
          active: _includeRightsSummary,
          current: _includeCreditLocation,
          first: false,
          second: true,
          height: 30,
          borderWidth: 1,
          spacing: 0.0,
          indicatorSize: const Size.fromWidth(28),
          indicatorTransition: const ForegroundIndicatorTransition.fading(),
          animationDuration: const Duration(milliseconds: 250),
          styleBuilder: _toggleSwitchStyleBuilder,
          onChanged: (value) {
            setState(() {
              _includeCreditLocation = value;
            });
          },
        ),
        const SizedBox(width: 20.0),
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
                onSelected: _includeCreditLocation
                    ? (value) {
                        state.replace([creditLocation[index]]);
                      }
                    : null,
              );
            },
            onChanged: (value) {
              setState(() {
                widget.controller.creditLocation =
                    value.firstOrNull ?? AssetMetadataCreditLocationEnum.end;
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
        AnimatedToggleSwitch.dual(
          current: _includeEmotions,
          first: false,
          second: true,
          height: 30,
          borderWidth: 1,
          spacing: 0.0,
          indicatorSize: const Size.fromWidth(28),
          indicatorTransition: const ForegroundIndicatorTransition.fading(),
          animationDuration: const Duration(milliseconds: 250),
          styleBuilder: _toggleSwitchStyleBuilder,
          onChanged: (value) {
            setState(() {
              _includeEmotions = value;
            });
          },
        ),
        const SizedBox(width: 20.0),
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
                onSelected: _includeEmotions
                    ? (value) {
                        if (value) {
                          state.add(emotions[index]);
                        } else {
                          state.remove(emotions[index]);
                        }
                      }
                    : null,
              );
            },
            onChanged: (value) {
              setState(() {
                widget.controller.emotion = value;
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
        AnimatedToggleSwitch.dual(
          current: _includeHeadline,
          first: false,
          second: true,
          height: 30,
          borderWidth: 1,
          spacing: 0.0,
          indicatorSize: const Size.fromWidth(28),
          indicatorTransition: const ForegroundIndicatorTransition.fading(),
          animationDuration: const Duration(milliseconds: 250),
          styleBuilder: _toggleSwitchStyleBuilder,
          onChanged: (value) {
            setState(() {
              _includeHeadline = value;
            });
          },
        ),
        const SizedBox(width: 20.0),
        SizedBox(
          width: 150.0,
          child: Text(
            'Headline',
            style: TextStyle(
              color: theme.textTheme.labelMedium?.color,
            ),
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Opacity(
            opacity: _includeHeadline ? 1.0 : 0.5,
            child: TextFormField(
              controller: widget.controller._headlineController,
              undoController: undoController,
              contextMenuBuilder: (context, editableTextState) =>
                  kEditableTextContextMenuBuilder(
                context,
                editableTextState,
                undoController,
              ),
              enabled: _includeHeadline,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(250),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKeywords(ThemeData theme) {
    return Row(
      children: [
        AnimatedToggleSwitch.dual(
          current: _includeKeywords,
          first: false,
          second: true,
          height: 30,
          borderWidth: 1,
          spacing: 0.0,
          indicatorSize: const Size.fromWidth(28),
          indicatorTransition: const ForegroundIndicatorTransition.fading(),
          animationDuration: const Duration(milliseconds: 250),
          styleBuilder: _toggleSwitchStyleBuilder,
          onChanged: (value) {
            setState(() {
              _includeKeywords = value;
            });
          },
        ),
        const SizedBox(width: 20.0),
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
          child: PicklistKeywordTagField(
            focusNode: _picklistKeywordsTagFieldFocusNode,
            enabled: _includeKeywords,
            tags: widget.controller.keywords,
            onChange: (tags) {
              setState(() {
                widget.controller.keywords = tags;
              });

              _picklistKeywordsTagFieldFocusNode.requestFocus();
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
        AnimatedToggleSwitch.dual(
          current: _includeOverlays,
          first: false,
          second: true,
          height: 30,
          borderWidth: 1,
          spacing: 0.0,
          indicatorSize: const Size.fromWidth(28),
          indicatorTransition: const ForegroundIndicatorTransition.fading(),
          animationDuration: const Duration(milliseconds: 250),
          styleBuilder: _toggleSwitchStyleBuilder,
          onChanged: (value) {
            setState(() {
              _includeOverlays = value;
            });
          },
        ),
        const SizedBox(width: 20.0),
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
                onSelected: _includeOverlays
                    ? (value) {
                        if (value) {
                          state.add(overlays[index]);
                        } else {
                          state.remove(overlays[index]);
                        }
                      }
                    : null,
              );
            },
            onChanged: (value) {
              setState(() {
                widget.controller.overlay = value;
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
        AnimatedToggleSwitch.dual(
          active: _includeRightsSummary,
          current: _includeRightsDetails,
          first: false,
          second: true,
          height: 30,
          borderWidth: 1,
          spacing: 0.0,
          indicatorSize: const Size.fromWidth(28),
          indicatorTransition: const ForegroundIndicatorTransition.fading(),
          animationDuration: const Duration(milliseconds: 250),
          styleBuilder: _toggleSwitchStyleBuilder,
          onChanged: (value) {
            setState(() {
              _includeRightsDetails = value;
            });
          },
        ),
        const SizedBox(width: 20.0),
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
          child: Opacity(
            opacity: _includeRightsDetails ? 1.0 : 0.5,
            child: TextFormField(
              controller: widget.controller._rightsDetailsController,
              undoController: undoController,
              contextMenuBuilder: (context, editableTextState) =>
                  kEditableTextContextMenuBuilder(
                context,
                editableTextState,
                undoController,
              ),
              enabled: _includeRightsDetails,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(250),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRightsInstructions(ThemeData theme) {
    final undoController = UndoHistoryController();

    return Row(
      children: [
        AnimatedToggleSwitch.dual(
          active: _includeRightsSummary,
          current: _includeRightsInstructions,
          first: false,
          second: true,
          height: 30,
          borderWidth: 1,
          spacing: 0.0,
          indicatorSize: const Size.fromWidth(28),
          indicatorTransition: const ForegroundIndicatorTransition.fading(),
          animationDuration: const Duration(milliseconds: 250),
          styleBuilder: _toggleSwitchStyleBuilder,
          onChanged: (value) {
            setState(() {
              _includeRightsInstructions = value;
            });
          },
        ),
        const SizedBox(width: 20.0),
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
          child: Opacity(
            opacity: _includeRightsInstructions ? 1.0 : 0.5,
            child: TextFormField(
              controller: widget.controller._rightsInstructionsController,
              undoController: undoController,
              contextMenuBuilder: (context, editableTextState) =>
                  kEditableTextContextMenuBuilder(
                context,
                editableTextState,
                undoController,
              ),
              enabled: _includeRightsInstructions,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(250),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRightsSummary(ThemeData theme) {
    return Row(
      children: [
        AnimatedToggleSwitch.dual(
          current: _includeRightsSummary,
          first: false,
          second: true,
          height: 30,
          borderWidth: 1,
          spacing: 0.0,
          indicatorSize: const Size.fromWidth(28),
          indicatorTransition: const ForegroundIndicatorTransition.fading(),
          animationDuration: const Duration(milliseconds: 250),
          styleBuilder: _toggleSwitchStyleBuilder,
          onChanged: (value) {
            setState(() {
              _includeRightsSummary = value;

              if (!value) {
                _includeCredit = false;
                _includeCreditLocation = false;
                _includeRightsDetails = false;
                _includeRightsInstructions = false;
              }
            });
          },
        ),
        const SizedBox(width: 20.0),
        SizedBox(
          width: 150.0,
          child: Text(
            'Rights Summary',
            style: TextStyle(
              color: theme.textTheme.labelMedium?.color,
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
                onSelected: _includeRightsSummary
                    ? (value) {
                        state.replace([rights[index]]);
                      }
                    : null,
              );
            },
            onChanged: (value) {
              setState(() {
                final rights =
                    value.firstOrNull ?? AssetMetadataRightsEnum.unknown;

                if (rights == AssetMetadataRightsEnum.freeTMZ) {
                  _includeCredit = false;
                  _includeCreditLocation = false;
                  _includeRightsDetails = false;
                  _includeRightsInstructions = false;
                }

                widget.controller.rights = rights;
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
        AnimatedToggleSwitch.dual(
          current: _includeShotDescription,
          first: false,
          second: true,
          height: 30,
          borderWidth: 1,
          spacing: 0.0,
          indicatorSize: const Size.fromWidth(28),
          indicatorTransition: const ForegroundIndicatorTransition.fading(),
          animationDuration: const Duration(milliseconds: 250),
          styleBuilder: _toggleSwitchStyleBuilder,
          onChanged: (value) {
            setState(() {
              _includeShotDescription = value;
            });
          },
        ),
        const SizedBox(width: 20.0),
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
          child: Opacity(
            opacity: _includeShotDescription ? 1.0 : 0.5,
            child: TextFormField(
              controller: widget.controller._shotDescriptionController,
              undoController: undoController,
              contextMenuBuilder: (context, editableTextState) =>
                  kEditableTextContextMenuBuilder(
                context,
                editableTextState,
                undoController,
              ),
              enabled: _includeShotDescription,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(2000),
              ],
              minLines: 3,
              maxLines: 5,
            ),
          ),
        ),
      ],
    );
  }

  ToggleStyle _toggleSwitchStyleBuilder(bool value) {
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
  }
}

class BulkUpdateFormController extends ChangeNotifier {
  AssetImportSessionFileMetaModel? _model;

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

  final _rightsInstructionsController = TextEditingController();
  String get rightsInstructions => _rightsInstructionsController.text.trim();

  final _shotDescriptionController = TextEditingController();
  String get shotDescription => _shotDescriptionController.text.trim();

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
        location: _model?.metadata.location ??
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
    _agencyController.value = _model?.metadata.agency ?? [];

    _celebrityController.value = true;

    _celebrityAssociatedController.value =
        _model?.metadata.celebrityAssociated ?? [];

    _celebrityInPhotoController.value = _model?.metadata.celebrityInPhoto ?? [];

    _creditController.text = _model?.metadata.credit ?? '';

    if ((_model?.metadata.creditLocation != null) &&
        (_model?.metadata.creditLocation !=
            AssetMetadataCreditLocationEnum.unknown)) {
      _creditLocationController.value = _model!.metadata.creditLocation!;
    } else {
      _creditLocationController.value = AssetMetadataCreditLocationEnum.end;
    }

    _emotionController.value = _model?.metadata.emotion ?? [];

    _headlineController.text = _model?.headline ?? '';

    _keywordsController.value = _model?.metadata.keywords ?? [];

    _overlayController.value = _model?.metadata.overlay ?? [];

    _rightsController.value =
        _model?.metadata.rights ?? AssetMetadataRightsEnum.unknown;

    _rightsDetailsController.text = _model?.metadata.rightsDetails ?? '';

    _rightsInstructionsController.text =
        _model?.metadata.rightsInstructions ?? '';

    _shotDescriptionController.text = _model?.metadata.shotDescription ?? '';

    notifyListeners();
  }

  void setFrom(AssetImportSessionFileMetaModel model) {
    _model = model;
    reset();
  }
}
