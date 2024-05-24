import 'package:choice/choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tmz_damz/data/models/asset_metadata.dart';
import 'package:tmz_damz/data/models/asset_metadata_field.dart';
import 'package:tmz_damz/features/bulk_update/bloc/bloc.dart';
import 'package:tmz_damz/features/bulk_update/widgets/metadata_field_input.dart';
import 'package:tmz_damz/features/metadata_picklists/widgets/picklist_agency_tag_field.dart';
import 'package:tmz_damz/features/metadata_picklists/widgets/picklist_celebrity_tag_field.dart';
import 'package:tmz_damz/features/metadata_picklists/widgets/picklist_keyword_tag_field.dart';
import 'package:tmz_damz/shared/widgets/masked_scroll_view.dart';
import 'package:tmz_damz/shared/widgets/toast.dart';

class BulkUpdateModal extends StatefulWidget {
  final ThemeData theme;
  final List<String> assetIDs;
  final VoidCallback onClose;

  const BulkUpdateModal({
    super.key,
    required this.theme,
    required this.assetIDs,
    required this.onClose,
  });

  @override
  State<BulkUpdateModal> createState() => _BulkUpdateModalState();
}

class _BulkUpdateModalState extends State<BulkUpdateModal> {
  final _fields = <AssetMetadataFieldEnum?>[null];
  final _modes = <AssetMetadataFieldEnum?, AssetMetadataFieldModeEnum>{};

  final _controller = BulkUpdateModalController();

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
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller.addListener(_onControllerChanged);
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
    return Container(
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
          _buildTitle('Bulk update...'),
          _buildBloc(),
        ],
      ),
    );
  }

  Widget _buildBloc() {
    return BlocProvider<BulkUpdateBloc>(
      create: (_) => GetIt.instance<BulkUpdateBloc>(),
      child: BlocListener<BulkUpdateBloc, BlocState>(
        listenWhen: (_, state) =>
            state is UpdateMetadataCompleteState ||
            state is UpdateMetadataFailureState,
        listener: (context, state) {
          if (state is UpdateMetadataCompleteState) {
            Toast.showNotification(
              showDuration: const Duration(seconds: 3),
              type: ToastTypeEnum.success,
              message: 'Metadata updated!',
            );

            widget.onClose();
          } else if (state is UpdateMetadataFailureState) {
            Toast.showNotification(
              showDuration: const Duration(seconds: 6),
              type: ToastTypeEnum.error,
              title: 'Failed to Update Metadata',
              message: state.failure.message,
            );
          }
        },
        child: BlocBuilder<BulkUpdateBloc, BlocState>(
          buildWhen: (_, state) =>
              state is UpdateMetadataFailureState ||
              state is UpdateMetadataProgressState ||
              state is UpdatingMetadataState,
          builder: (context, state) {
            if (state is UpdateMetadataProgressState) {
              return Padding(
                padding: const EdgeInsets.all(40.0),
                child: Center(
                  child: CircularProgressIndicator(
                    value: state.progress,
                  ),
                ),
              );
            } else if (state is UpdatingMetadataState) {
              return const Padding(
                padding: EdgeInsets.all(40.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MaskedScrollView(
                    padding: const EdgeInsets.only(
                      left: 40.0,
                      top: 30.0,
                      right: 40.0,
                      bottom: 10.0,
                    ),
                    child: FocusScope(
                      child: _buildContent(
                        context: context,
                      ),
                    ),
                  ),
                  _buildDialogButtons(
                    context: context,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildContent({
    required BuildContext context,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        _fields.length,
        (index) {
          final field = _fields[index];

          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 4.0,
            ),
            child: MetadataFieldInput(
              canAdd: index == (_fields.length - 1),
              showModeSelection: ![
                AssetMetadataFieldEnum.creditLocation,
                AssetMetadataFieldEnum.emotion,
                AssetMetadataFieldEnum.overlay,
                AssetMetadataFieldEnum.rights,
              ].contains(field),
              fields: [
                AssetMetadataFieldEnum.agency,
                AssetMetadataFieldEnum.celebrityAssociated,
                AssetMetadataFieldEnum.celebrityInPhoto,
                AssetMetadataFieldEnum.locationCity,
                AssetMetadataFieldEnum.locationCountry,
                AssetMetadataFieldEnum.credit,
                AssetMetadataFieldEnum.creditLocation,
                AssetMetadataFieldEnum.emotion,
                AssetMetadataFieldEnum.headline,
                AssetMetadataFieldEnum.keywords,
                AssetMetadataFieldEnum.overlay,
                AssetMetadataFieldEnum.qcNotes,
                AssetMetadataFieldEnum.rightsDetails,
                AssetMetadataFieldEnum.rightsInstructions,
                AssetMetadataFieldEnum.rights, // Rights Summary
                AssetMetadataFieldEnum.locationDescription, // Shoot Location
                AssetMetadataFieldEnum.shotDescription,
                AssetMetadataFieldEnum.locationState,
              ].where((_) => (_ == field) || !_fields.contains(_)).toList(),
              modes: (() {
                if ([
                  AssetMetadataFieldEnum.agency,
                  AssetMetadataFieldEnum.celebrityAssociated,
                  AssetMetadataFieldEnum.celebrityInPhoto,
                  AssetMetadataFieldEnum.keywords,
                ].contains(field)) {
                  return [
                    AssetMetadataFieldModeEnum.replace,
                    AssetMetadataFieldModeEnum.add,
                    AssetMetadataFieldModeEnum.remove,
                  ];
                } else {
                  return [
                    AssetMetadataFieldModeEnum.replace,
                    AssetMetadataFieldModeEnum.append,
                    AssetMetadataFieldModeEnum.prepend,
                  ];
                }
              })(),
              initialField: field,
              initialMode: _modes[field],
              inputWidget: (() {
                switch (field) {
                  case AssetMetadataFieldEnum.agency:
                    return _buildAgency(theme);
                  case AssetMetadataFieldEnum.celebrityAssociated:
                    return _buildCelebrityAssociated(theme);
                  case AssetMetadataFieldEnum.celebrityInPhoto:
                    return _buildCelebrityInPhoto(theme);
                  case AssetMetadataFieldEnum.credit:
                    return _buildCredit(theme);
                  case AssetMetadataFieldEnum.creditLocation:
                    return _buildCreditLocation(theme);
                  case AssetMetadataFieldEnum.emotion:
                    return _buildEmotions(theme);
                  case AssetMetadataFieldEnum.headline:
                    return _buildHeadline(theme);
                  case AssetMetadataFieldEnum.locationCity:
                    return _buildLocationCity(theme);
                  case AssetMetadataFieldEnum.locationCountry:
                    return _buildLocationCountry(theme);
                  case AssetMetadataFieldEnum.locationDescription:
                    return _buildLocationDescription(theme);
                  case AssetMetadataFieldEnum.locationState:
                    return _buildLocationState(theme);
                  case AssetMetadataFieldEnum.keywords:
                    return _buildKeywords(theme);
                  case AssetMetadataFieldEnum.overlay:
                    return _buildOverlays(theme);
                  case AssetMetadataFieldEnum.qcNotes:
                    return _buildQCNotes(theme);
                  case AssetMetadataFieldEnum.rights:
                    return _buildRightsSummary(theme);
                  case AssetMetadataFieldEnum.rightsDetails:
                    return _buildRightsDetails(theme);
                  case AssetMetadataFieldEnum.rightsInstructions:
                    return _buildRightsInstructions(theme);
                  case AssetMetadataFieldEnum.shotDescription:
                    return _buildShotDescription(theme);
                  default:
                    return null;
                }
              })(),
              onFieldSelected: (field, mode) {
                setState(() {
                  _fields.replaceRange(index, index + 1, [field]);
                  _modes[field] = mode;
                });
              },
              onModeSelected: (mode) {
                setState(() {
                  _modes[field] = mode;
                });
              },
              onAddField: () {
                setState(() {
                  _fields.add(null);
                });
              },
              onRemoveField: () {
                setState(() {
                  _fields.removeAt(index);
                  _modes.remove(field);
                });

                if (field == AssetMetadataFieldEnum.agency) {
                  _controller.agency.clear();
                } else if (field ==
                    AssetMetadataFieldEnum.celebrityAssociated) {
                  _controller.celebrityAssociated.clear();
                } else if (field == AssetMetadataFieldEnum.celebrityInPhoto) {
                  _controller.celebrityInPhoto.clear();
                } else if (field == AssetMetadataFieldEnum.credit) {
                  _controller.credit = '';
                } else if (field == AssetMetadataFieldEnum.creditLocation) {
                  _controller.creditLocation =
                      AssetMetadataCreditLocationEnum.unknown;
                } else if (field == AssetMetadataFieldEnum.emotion) {
                  _controller.emotion.clear();
                } else if (field == AssetMetadataFieldEnum.headline) {
                  _controller.headline = '';
                } else if (field == AssetMetadataFieldEnum.locationCity) {
                  _controller.locationCity = '';
                } else if (field == AssetMetadataFieldEnum.locationCountry) {
                  _controller.locationCountry = '';
                } else if (field ==
                    AssetMetadataFieldEnum.locationDescription) {
                  _controller.locationDescription = '';
                } else if (field == AssetMetadataFieldEnum.locationState) {
                  _controller.locationState = '';
                } else if (field == AssetMetadataFieldEnum.keywords) {
                  _controller.keywords.clear();
                } else if (field == AssetMetadataFieldEnum.overlay) {
                  _controller.overlay.clear();
                } else if (field == AssetMetadataFieldEnum.qcNotes) {
                  _controller.qcNotes = '';
                } else if (field == AssetMetadataFieldEnum.rights) {
                  _controller.rights = AssetMetadataRightsEnum.unknown;
                } else if (field == AssetMetadataFieldEnum.rightsDetails) {
                  _controller.rightsDetails = '';
                } else if (field == AssetMetadataFieldEnum.rightsInstructions) {
                  _controller.rightsInstructions = '';
                } else if (field == AssetMetadataFieldEnum.shotDescription) {
                  _controller.shotDescription = '';
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildDialogButtons({
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          const Spacer(),
          SizedBox(
            width: 100.0,
            child: TextButton(
              onPressed: () {
                final values = <IAssetMetadataFieldValue>[];

                for (var i = 0; i < _fields.length; i++) {
                  final field = _fields[i];

                  if (field == null) {
                    continue;
                  }

                  values.add(
                    AssetMetadataFieldValue(
                      field: field,
                      mode: _modes[field] ?? AssetMetadataFieldModeEnum.replace,
                      value: (() {
                        if (field == AssetMetadataFieldEnum.agency) {
                          return _controller.agency;
                        } else if (field ==
                            AssetMetadataFieldEnum.celebrityAssociated) {
                          return _controller.celebrityAssociated;
                        } else if (field ==
                            AssetMetadataFieldEnum.celebrityInPhoto) {
                          return _controller.celebrityInPhoto;
                        } else if (field == AssetMetadataFieldEnum.credit) {
                          return _controller.credit;
                        } else if (field ==
                            AssetMetadataFieldEnum.creditLocation) {
                          return _controller.creditLocation.toJsonDtoValue();
                        } else if (field == AssetMetadataFieldEnum.emotion) {
                          return _controller.emotion
                              .map((_) => _.toJsonDtoValue())
                              .toList();
                        } else if (field == AssetMetadataFieldEnum.headline) {
                          return _controller.headline;
                        } else if (field ==
                            AssetMetadataFieldEnum.locationCity) {
                          return _controller.locationCity;
                        } else if (field ==
                            AssetMetadataFieldEnum.locationCountry) {
                          return _controller.locationCountry;
                        } else if (field ==
                            AssetMetadataFieldEnum.locationDescription) {
                          return _controller.locationDescription;
                        } else if (field ==
                            AssetMetadataFieldEnum.locationState) {
                          return _controller.locationState;
                        } else if (field == AssetMetadataFieldEnum.keywords) {
                          return _controller.keywords;
                        } else if (field == AssetMetadataFieldEnum.overlay) {
                          return _controller.overlay
                              .map((_) => _.toJsonDtoValue())
                              .toList();
                        } else if (field == AssetMetadataFieldEnum.qcNotes) {
                          return _controller.qcNotes;
                        } else if (field == AssetMetadataFieldEnum.rights) {
                          return _controller.rights.toJsonDtoValue();
                        } else if (field ==
                            AssetMetadataFieldEnum.rightsDetails) {
                          return _controller.rightsDetails;
                        } else if (field ==
                            AssetMetadataFieldEnum.rightsInstructions) {
                          return _controller.rightsInstructions;
                        } else if (field ==
                            AssetMetadataFieldEnum.shotDescription) {
                          return _controller.shotDescription;
                        }
                      })(),
                    ),
                  );
                }

                if (values.isEmpty) {
                  return;
                }

                BlocProvider.of<BulkUpdateBloc>(context).add(
                  SaveMetadataEvent(
                    assetIDs: widget.assetIDs,
                    values: values,
                  ),
                );
              },
              style: widget.theme.textButtonTheme.style,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: Text(
                  'Update',
                  style: widget.theme.textTheme.bodySmall,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          SizedBox(
            width: 100.0,
            child: TextButton(
              onPressed: widget.onClose,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  const Color(0x30FFFFFF),
                ),
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 6.0,
                  ),
                ),
                shape: WidgetStateProperty.resolveWith(
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
                  style: widget.theme.textTheme.bodySmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      color: const Color(0xFF1D1E1F),
      child: Text(
        title,
        style: widget.theme.textTheme.titleSmall?.copyWith(
          color: Colors.blue,
          letterSpacing: 1.0,
        ),
        softWrap: true,
      ),
    );
  }

  Widget _buildAgency(ThemeData theme) {
    return Builder(
      builder: (context) {
        return PicklistAgencyTagField(
          key: _picklistAgencyTagFieldUniqueKey,
          focusNode: _picklistAgencyTagFieldFocusNode,
          canAddNewtags: true,
          tags: _controller.agency,
          onChange: (tags) {
            setState(() {
              _controller.agency = tags;
            });

            _picklistAgencyTagFieldFocusNode.requestFocus();
          },
        );
      },
    );
  }

  Widget _buildCelebrityAssociated(ThemeData theme) {
    return Builder(
      builder: (context) {
        return PicklistCelebrityTagField(
          key: _picklistCelebrityAssociatedTagFieldUniqueKey,
          focusNode: _picklistCelebrityAssociatedTagFieldFocusNode,
          canAddNewtags: true,
          tags: _controller.celebrityAssociated,
          onChange: (tags) {
            setState(() {
              _controller.celebrityAssociated = tags;
            });

            _picklistCelebrityAssociatedTagFieldFocusNode.requestFocus();
          },
        );
      },
    );
  }

  Widget _buildCelebrityInPhoto(ThemeData theme) {
    return Builder(
      builder: (context) {
        return PicklistCelebrityTagField(
          key: _picklistCelebrityInPhotoTagFieldUniqueKey,
          focusNode: _picklistCelebrityInPhotoTagFieldFocusNode,
          canAddNewtags: true,
          tags: _controller.celebrityInPhoto,
          onChange: (tags) {
            setState(() {
              _controller.celebrityInPhoto = tags;
            });

            _picklistCelebrityInPhotoTagFieldFocusNode.requestFocus();
          },
        );
      },
    );
  }

  Widget _buildCredit(ThemeData theme) {
    return TextFormField(
      key: UniqueKey(),
      controller: _controller._creditController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
      ],
    );
  }

  Widget _buildCreditLocation(ThemeData theme) {
    return Choice.inline(
      value: [_controller.creditLocation],
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
          selected: _controller.creditLocation == creditLocation[index],
          selectedColor: const Color(0xFF8E0000),
          onSelected: (value) {
            state.replace([creditLocation[index]]);
          },
        );
      },
      onChanged: (value) {
        setState(() {
          _controller.creditLocation =
              value.firstOrNull ?? AssetMetadataCreditLocationEnum.end;
        });
      },
    );
  }

  Widget _buildEmotions(ThemeData theme) {
    return Choice.inline(
      clearable: true,
      multiple: true,
      value: _controller.emotion,
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
          selected: _controller.emotion.contains(emotions[index]),
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
          _controller.emotion = value;
        });
      },
    );
  }

  Widget _buildHeadline(ThemeData theme) {
    return TextFormField(
      key: UniqueKey(),
      controller: _controller._headlineController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(250),
      ],
    );
  }

  Widget _buildKeywords(ThemeData theme) {
    return Builder(
      builder: (context) {
        return PicklistKeywordTagField(
          key: _picklistKeywordsTagFieldUniqueKey,
          focusNode: _picklistKeywordsTagFieldFocusNode,
          canAddNewtags: true,
          tags: _controller.keywords,
          onChange: (tags) {
            setState(() {
              _controller.keywords = tags;
            });

            _picklistKeywordsTagFieldFocusNode.requestFocus();
          },
        );
      },
    );
  }

  Widget _buildLocationCity(ThemeData theme) {
    return TextFormField(
      key: UniqueKey(),
      controller: _controller._locationCityController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(100),
      ],
    );
  }

  Widget _buildLocationCountry(ThemeData theme) {
    return TextFormField(
      key: UniqueKey(),
      controller: _controller._locationCountryController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(100),
      ],
    );
  }

  Widget _buildLocationDescription(ThemeData theme) {
    return TextFormField(
      key: UniqueKey(),
      controller: _controller._locationDescriptionController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(100),
      ],
    );
  }

  Widget _buildLocationState(ThemeData theme) {
    return TextFormField(
      key: UniqueKey(),
      controller: _controller._locationStateController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(100),
      ],
    );
  }

  Widget _buildOverlays(ThemeData theme) {
    return Choice.inline(
      clearable: true,
      multiple: true,
      value: _controller.overlay,
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
                  AssetMetadataOverlayEnum.blackBarCensor: 'Black Bar Censor',
                  AssetMetadataOverlayEnum.blurCensor: 'Blur Censor',
                  AssetMetadataOverlayEnum.watermark: 'Watermark',
                }[overlays[index]] ??
                '',
          ),
          selected: _controller.overlay.contains(overlays[index]),
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
          _controller.overlay = value;
        });
      },
    );
  }

  Widget _buildQCNotes(ThemeData theme) {
    return TextFormField(
      key: UniqueKey(),
      controller: _controller._qcNotesController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(500),
      ],
      maxLines: null,
    );
  }

  Widget _buildRightsDetails(ThemeData theme) {
    return TextFormField(
      key: UniqueKey(),
      controller: _controller._rightsDetailsController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(250),
      ],
    );
  }

  Widget _buildRightsInstructions(ThemeData theme) {
    return TextFormField(
      key: UniqueKey(),
      controller: _controller._rightsInstructionsController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(250),
      ],
    );
  }

  Widget _buildRightsSummary(ThemeData theme) {
    return Choice.inline(
      value: [_controller.rights],
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
          selected: _controller.rights == rights[index],
          selectedColor: const Color(0xFF8E0000),
          onSelected: (value) {
            state.replace([rights[index]]);
          },
        );
      },
      onChanged: (value) {
        setState(() {
          _controller.rights =
              value.firstOrNull ?? AssetMetadataRightsEnum.unknown;
        });
      },
    );
  }

  Widget _buildShotDescription(ThemeData theme) {
    return TextFormField(
      key: UniqueKey(),
      controller: _controller._shotDescriptionController,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(2000),
      ],
      minLines: 3,
      maxLines: null,
    );
  }
}

class BulkUpdateModalController extends ChangeNotifier {
  List<String> agency = [];
  List<String> celebrityAssociated = [];
  List<String> celebrityInPhoto = [];
  AssetMetadataCreditLocationEnum creditLocation =
      AssetMetadataCreditLocationEnum.unknown;
  List<AssetMetadataEmotionEnum> emotion = [];
  List<String> keywords = [];
  List<AssetMetadataOverlayEnum> overlay = [];
  AssetMetadataRightsEnum rights = AssetMetadataRightsEnum.unknown;

  final _creditController = TextEditingController();
  String get credit => _creditController.text.trim();
  set credit(String value) => _creditController.text = value;

  final _headlineController = TextEditingController();
  String get headline => _headlineController.text.trim();
  set headline(String value) => _headlineController.text = value;

  final _locationCityController = TextEditingController();
  String get locationCity => _locationCityController.text.trim();
  set locationCity(String value) => _locationCityController.text = value;

  final _locationCountryController = TextEditingController();
  String get locationCountry => _locationCountryController.text.trim();
  set locationCountry(String value) => _locationCountryController.text = value;

  final _locationDescriptionController = TextEditingController();
  String get locationDescription => _locationDescriptionController.text.trim();
  set locationDescription(String value) =>
      _locationDescriptionController.text = value;

  final _locationStateController = TextEditingController();
  String get locationState => _locationStateController.text.trim();
  set locationState(String value) => _locationStateController.text = value;

  final _qcNotesController = TextEditingController();
  String get qcNotes => _qcNotesController.text.trim();
  set qcNotes(String value) => _qcNotesController.text = value;

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
    _creditController.dispose();
    _headlineController.dispose();
    _locationCityController.dispose();
    _locationCountryController.dispose();
    _locationDescriptionController.dispose();
    _locationStateController.dispose();
    _qcNotesController.dispose();
    _rightsDetailsController.dispose();
    _rightsInstructionsController.dispose();
    _shotDescriptionController.dispose();

    super.dispose();
  }
}
