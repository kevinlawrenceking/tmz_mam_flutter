import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmz_damz/data/models/asset_metadata.dart';
import 'package:tmz_damz/features/metadata_picklists/widgets/picklist_agency_tag_field.dart';
import 'package:tmz_damz/features/metadata_picklists/widgets/picklist_celebrity_tag_field.dart';
import 'package:tmz_damz/features/metadata_picklists/widgets/picklist_keyword_tag_field.dart';

class MetadataForm extends StatefulWidget {
  final MetadataFormController controller;

  const MetadataForm({
    super.key,
    required this.controller,
  });

  @override
  State<MetadataForm> createState() => _MetadataFormState();
}

class _MetadataFormState extends State<MetadataForm> {
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
          const SizedBox(height: 20.0),
          _buildCelebrity(theme),
          const SizedBox(height: 20.0),
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
                const SizedBox(height: 20.0),
                _buildCelebrityAssociated(theme),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
          _buildShotDescription(theme),
          const SizedBox(height: 20.0),
          _buildKeywords(theme),
          const SizedBox(height: 20.0),
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
                const SizedBox(height: 20.0),
                _buildRightsInstructions(theme),
                const SizedBox(height: 20.0),
                _buildRightsDetails(theme),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          _buildQCNotes(theme),
        ],
      ),
    );
  }

  Widget _buildAgency(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
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
        const SizedBox(height: 10.0),
        Builder(
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
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildCelebrity(ThemeData theme) {
    return Row(
      children: [
        RichText(
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
          },
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildCelebrityAssociated(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
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
        const SizedBox(height: 10.0),
        Builder(
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
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildCelebrityInPhoto(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
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
        const SizedBox(height: 10.0),
        Builder(
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
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildCredit(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
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
        const SizedBox(height: 10.0),
        TextFormField(
          key: UniqueKey(),
          controller: widget.controller._creditController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(50),
          ],
        ),
      ],
    );
  }

  Widget _buildCreditLocation(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
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
        const SizedBox(height: 10.0),
        Choice.inline(
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
                style: theme.textTheme.bodyMedium,
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
          },
        ),
      ],
    );
  }

  Widget _buildEmotions(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
        const SizedBox(height: 10.0),
        Choice.inline(
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
                style: theme.textTheme.bodyMedium,
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
          },
        ),
      ],
    );
  }

  Widget _buildHeadline(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
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
        const SizedBox(height: 10.0),
        TextFormField(
          key: UniqueKey(),
          controller: widget.controller._headlineController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(250),
          ],
        ),
      ],
    );
  }

  Widget _buildKeywords(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
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
        const SizedBox(height: 10.0),
        Builder(
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
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildOverlays(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
        const SizedBox(height: 10.0),
        Choice.inline(
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
                style: theme.textTheme.bodyMedium,
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
          },
        ),
      ],
    );
  }

  Widget _buildQCNotes(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 150.0,
          child: Text(
            'QC Notes',
            style: TextStyle(
              color: theme.textTheme.labelMedium?.color,
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        TextFormField(
          key: UniqueKey(),
          controller: widget.controller._qcNotesController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(500),
          ],
          maxLines: null,
        ),
      ],
    );
  }

  Widget _buildRightsDetails(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
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
        const SizedBox(height: 10.0),
        TextFormField(
          key: UniqueKey(),
          controller: widget.controller._rightsDetailsController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(250),
          ],
        ),
      ],
    );
  }

  Widget _buildRightsInstructions(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
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
        const SizedBox(height: 10.0),
        TextFormField(
          key: UniqueKey(),
          controller: widget.controller._rightsInstructionsController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(250),
          ],
        ),
      ],
    );
  }

  Widget _buildRightsSummary(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
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
        const SizedBox(height: 10.0),
        Choice.inline(
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
                style: theme.textTheme.bodyMedium,
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
          },
        ),
      ],
    );
  }

  Widget _buildShotDescription(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
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
        const SizedBox(height: 10.0),
        TextFormField(
          key: UniqueKey(),
          controller: widget.controller._shotDescriptionController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(2000),
          ],
          minLines: 3,
          maxLines: null,
        ),
      ],
    );
  }
}

class MetadataFormController extends ChangeNotifier {
  String _headline = '';

  AssetMetadataModel? _metadata;
  AssetMetadataModel? get metadata => _metadata;

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

  final _qcNotesController = TextEditingController();
  String get qcNotes => _qcNotesController.text.trim();
  set qcNotes(String value) => _qcNotesController.text = value;

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
    _headlineController.dispose();

    _agencyController.dispose();
    _celebrityController.dispose();
    _celebrityAssociatedController.dispose();
    _celebrityInPhotoController.dispose();
    _creditController.dispose();
    _creditLocationController.dispose();
    _emotionController.dispose();
    _keywordsController.dispose();
    _overlayController.dispose();
    _qcNotesController.dispose();
    _rightsController.dispose();
    _rightsDetailsController.dispose();
    _rightsInstructionsController.dispose();
    _shotDescriptionController.dispose();

    super.dispose();
  }

  AssetMetadataModel getMetadata() {
    return AssetMetadataModel(
      keywords: keywords,
      shotDescription: shotDescription,
      location: _metadata?.location ??
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
      rightsInstructions:
          rights != AssetMetadataRightsEnum.freeTMZ ? rightsInstructions : null,
      rightsDetails:
          rights != AssetMetadataRightsEnum.freeTMZ ? rightsDetails : null,
      qcNotes: qcNotes,
    );
  }

  void reset() {
    _headlineController.text = _headline;

    _agencyController.value = _metadata?.agency ?? [];

    _celebrityController.value = _metadata?.celebrity ?? true;

    _celebrityAssociatedController.value = _metadata?.celebrityAssociated ?? [];

    _celebrityInPhotoController.value = _metadata?.celebrityInPhoto ?? [];

    _creditController.text = _metadata?.credit ?? '';

    if ((_metadata?.creditLocation != null) &&
        (_metadata?.creditLocation !=
            AssetMetadataCreditLocationEnum.unknown)) {
      _creditLocationController.value = _metadata!.creditLocation!;
    } else {
      _creditLocationController.value = AssetMetadataCreditLocationEnum.end;
    }

    _emotionController.value = _metadata?.emotion ?? [];

    _keywordsController.value = _metadata?.keywords ?? [];

    _overlayController.value = _metadata?.overlay ?? [];

    _qcNotesController.text = _metadata?.qcNotes ?? '';

    _rightsController.value =
        _metadata?.rights ?? AssetMetadataRightsEnum.unknown;

    _rightsDetailsController.text = _metadata?.rightsDetails ?? '';

    _rightsInstructionsController.text = _metadata?.rightsInstructions ?? '';

    _shotDescriptionController.text = _metadata?.shotDescription ?? '';

    notifyListeners();
  }

  void setFrom({
    required String headline,
    required AssetMetadataModel metadata,
  }) {
    _headline = headline;
    _metadata = metadata;

    reset();
  }
}
