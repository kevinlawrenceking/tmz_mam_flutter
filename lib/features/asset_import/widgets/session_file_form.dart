import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmz_damz/data/models/asset_import_session_file.dart';
import 'package:tmz_damz/data/models/asset_metadata.dart';
import 'package:tmz_damz/features/asset_import/widgets/tag_field.dart';
import 'package:tmz_damz/utils/debounce_timer.dart';

class SessionFileForm extends StatefulWidget {
  final SessionFileFormController controller;
  final void Function(AssetImportSessionFileMetaModel meta)? onChange;

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FocusScope(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Headline
          Row(
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
                  controller: widget.controller._headlineController,
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
          ),
          const SizedBox(height: 10.0),
          // Celebrity
          Row(
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
          ),
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
                // Celebrity (In Photo)
                Row(
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
                      child: TagField(
                        hintText: 'Add celebrity...',
                        initialTags: widget.controller.celebrityInPhoto,
                        onChange: (tags) {
                          setState(() {
                            widget.controller.celebrityInPhoto = tags;
                          });

                          _onChangeDebounce.wrap(() {
                            widget.onChange?.call(widget.controller.getModel());
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                // Celebrity (Associated)
                Row(
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
                      child: TagField(
                        hintText: 'Add celebrity...',
                        initialTags: widget.controller.celebrityAssociated,
                        onChange: (tags) {
                          setState(() {
                            widget.controller.celebrityAssociated = tags;
                          });

                          _onChangeDebounce.wrap(() {
                            widget.onChange?.call(widget.controller.getModel());
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
          // Shot Description
          Row(
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
                  controller: widget.controller._shotDescriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(2000),
                  ],
                  minLines: 2,
                  maxLines: 5,
                  onChanged: (value) {
                    _onChangeDebounce.wrap(() {
                      widget.onChange?.call(widget.controller.getModel());
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          // Keywords
          Row(
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
                child: TagField(
                  hintText: 'Add keyword...',
                  initialTags: widget.controller.keywords,
                  onChange: (tags) {
                    setState(() {
                      widget.controller.keywords = tags;
                    });

                    _onChangeDebounce.wrap(() {
                      widget.onChange?.call(widget.controller.getModel());
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          // Agency
          Row(
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
                child: TagField(
                  hintText: 'Add agency...',
                  initialTags: widget.controller.agency,
                  onChange: (tags) {
                    setState(() {
                      widget.controller.agency = tags;
                    });

                    _onChangeDebounce.wrap(() {
                      widget.onChange?.call(widget.controller.getModel());
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          // Emotions
          Row(
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
                      selected:
                          widget.controller.emotion.contains(emotions[index]),
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
          ),
          const SizedBox(height: 20.0),
          // Overlays
          Row(
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
                              AssetMetadataOverlayEnum.blurCensor:
                                  'Blur Censor',
                              AssetMetadataOverlayEnum.watermark: 'Watermark',
                            }[overlays[index]] ??
                            '',
                      ),
                      selected:
                          widget.controller.overlay.contains(overlays[index]),
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
          ),
          const SizedBox(height: 20.0),
          // Rights Summary
          Row(
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
                              AssetMetadataRightsEnum.costNonTMZ:
                                  'Cost (Non-TMZ)',
                              AssetMetadataRightsEnum.freeNonTMZ:
                                  'Free (Non-TMZ)',
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
          ),
          AnimatedCrossFade(
            firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
            secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
            sizeCurve: Curves.fastOutSlowIn,
            crossFadeState:
                widget.controller.rights == AssetMetadataRightsEnum.freeTMZ
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
            duration: kThemeAnimationDuration,
            firstChild: const SizedBox(height: 0.0),
            secondChild: Column(
              children: [
                const SizedBox(height: 20.0),
                // Credit Location
                Row(
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
                                    AssetMetadataCreditLocationEnum.onScreen:
                                        'On-Screen',
                                  }[creditLocation[index]] ??
                                  '',
                            ),
                            selected: widget.controller.creditLocation ==
                                creditLocation[index],
                            selectedColor: const Color(0xFF8E0000),
                            onSelected: (value) {
                              state.replace([creditLocation[index]]);
                            },
                          );
                        },
                        onChanged: (value) {
                          setState(() {
                            widget.controller.creditLocation =
                                value.firstOrNull ??
                                    AssetMetadataCreditLocationEnum.end;
                          });

                          _onChangeDebounce.wrap(() {
                            widget.onChange?.call(widget.controller.getModel());
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                // Credit
                Row(
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
                        controller: widget.controller._creditController,
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
                ),
                const SizedBox(height: 10.0),
                // Rights Instructions
                Row(
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
                        controller:
                            widget.controller._rightsInstructionsController,
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
                ),
                const SizedBox(height: 10.0),
                // Rights Details
                Row(
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
                        controller: widget.controller._rightsDetailsController,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SessionFileFormController extends ChangeNotifier {
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
        keywords: keywords,
        shotDescription: shotDescription,
        location: const AssetMetadataLocationModel(
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
