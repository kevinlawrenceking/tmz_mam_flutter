import 'package:equatable/equatable.dart';
import 'package:tmz_damz/data/models/shared.dart';

enum AssetSearchMetadataFieldEnum {
  unknown,
  agency,
  celebrityAssociated,
  celebrityInPhoto,
  createdBy,
  credit,
  creditLocation,
  daletID,
  emotions,
  exclusivity,
  headline,
  keywords,
  originalFileName,
  overlays,
  qcNotes,
  rights,
  rightsDetails,
  rightsInstructions,
  shotDescription;

  static AssetSearchMetadataFieldEnum? fromJsonDtoValue(
    String? value,
  ) {
    return {
      'AGENCY': AssetSearchMetadataFieldEnum.agency,
      'CELEBRITY_ASSOCIATED': AssetSearchMetadataFieldEnum.celebrityAssociated,
      'CELEBRITY_IN_PHOTO': AssetSearchMetadataFieldEnum.celebrityInPhoto,
      'CREATED_BY': AssetSearchMetadataFieldEnum.createdBy,
      'CREDIT': AssetSearchMetadataFieldEnum.credit,
      'CREDIT_LOCATION': AssetSearchMetadataFieldEnum.creditLocation,
      'DALET_ID': AssetSearchMetadataFieldEnum.daletID,
      'EMOTIONS': AssetSearchMetadataFieldEnum.emotions,
      'EXCLUSIVITY': AssetSearchMetadataFieldEnum.exclusivity,
      'HEADLINE': AssetSearchMetadataFieldEnum.headline,
      'KEYWORDS': AssetSearchMetadataFieldEnum.keywords,
      'ORIGINAL_FILE_NAME': AssetSearchMetadataFieldEnum.originalFileName,
      'OVERLAYS': AssetSearchMetadataFieldEnum.overlays,
      'QC_NOTES': AssetSearchMetadataFieldEnum.qcNotes,
      'RIGHTS': AssetSearchMetadataFieldEnum.rights,
      'RIGHTS_DETAILS': AssetSearchMetadataFieldEnum.rightsDetails,
      'RIGHTS_INSTRUCTIONS': AssetSearchMetadataFieldEnum.rightsInstructions,
      'SHOT_DESCRIPTION': AssetSearchMetadataFieldEnum.shotDescription,
    }[value?.toUpperCase()];
  }

  String? toJsonDtoValue() {
    return {
      AssetSearchMetadataFieldEnum.agency: 'AGENCY',
      AssetSearchMetadataFieldEnum.celebrityAssociated: 'CELEBRITY_ASSOCIATED',
      AssetSearchMetadataFieldEnum.celebrityInPhoto: 'CELEBRITY_IN_PHOTO',
      AssetSearchMetadataFieldEnum.createdBy: 'CREATED_BY',
      AssetSearchMetadataFieldEnum.credit: 'CREDIT',
      AssetSearchMetadataFieldEnum.creditLocation: 'CREDIT_LOCATION',
      AssetSearchMetadataFieldEnum.daletID: 'DALET_ID',
      AssetSearchMetadataFieldEnum.emotions: 'EMOTIONS',
      AssetSearchMetadataFieldEnum.exclusivity: 'EXCLUSIVITY',
      AssetSearchMetadataFieldEnum.headline: 'HEADLINE',
      AssetSearchMetadataFieldEnum.keywords: 'KEYWORDS',
      AssetSearchMetadataFieldEnum.originalFileName: 'ORIGINAL_FILE_NAME',
      AssetSearchMetadataFieldEnum.overlays: 'OVERLAYS',
      AssetSearchMetadataFieldEnum.qcNotes: 'QC_NOTES',
      AssetSearchMetadataFieldEnum.rights: 'RIGHTS',
      AssetSearchMetadataFieldEnum.rightsDetails: 'RIGHTS_DETAILS',
      AssetSearchMetadataFieldEnum.rightsInstructions: 'RIGHTS_INSTRUCTIONS',
      AssetSearchMetadataFieldEnum.shotDescription: 'SHOT_DESCRIPTION',
    }[this];
  }
}

class AssetSearchDataModel extends Equatable {
  final DateTime? createdAtStart;
  final DateTime? createdAtEnd;
  final DateTime? updatedAtStart;
  final DateTime? updatedAtEnd;
  final String? searchTerm;
  final List<AssetSearchDataMetadataConditionModel> metadataConditions;

  const AssetSearchDataModel({
    this.createdAtStart,
    this.createdAtEnd,
    this.updatedAtStart,
    this.updatedAtEnd,
    this.searchTerm,
    this.metadataConditions = const [],
  });

  static AssetSearchDataModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return AssetSearchDataModel(
      createdAtStart: _getNullableDateTime(dto?['created_at_start']),
      createdAtEnd: _getNullableDateTime(dto?['created_at_end']),
      updatedAtStart: _getNullableDateTime(dto?['updated_at_start']),
      updatedAtEnd: _getNullableDateTime(dto?['updated_at_end']),
      searchTerm: dto?['search_term'] ?? '',
      metadataConditions: (dto?['metadata_conditions'] as List<dynamic>?)
              ?.map((_) => AssetSearchDataMetadataConditionModel.fromJsonDto(_))
              .toList() ??
          [],
    );
  }

  static DateTime? _getNullableDateTime(dynamic value) {
    return (value != null) ? DateTime.parse(value) : null;
  }

  @override
  List<Object?> get props => [
        createdAtStart,
        createdAtEnd,
        updatedAtStart,
        updatedAtEnd,
        searchTerm,
        metadataConditions,
      ];

  Map<String, dynamic> toJsonDto() {
    return {
      'created_at_start': createdAtStart?.toIso8601String(),
      'created_at_end': createdAtEnd?.toIso8601String(),
      'updated_at_start': updatedAtStart?.toIso8601String(),
      'updated_at_end': updatedAtEnd?.toIso8601String(),
      'search_term': searchTerm,
      'metadata_conditions':
          metadataConditions.map((_) => _.toJsonDto()).toList(),
    };
  }
}

class AssetSearchDataMetadataConditionModel extends Equatable {
  final AssetSearchMetadataFieldEnum field;
  final ComparisonMethodEnum? comparisonMethod;
  final dynamic value;

  const AssetSearchDataMetadataConditionModel({
    required this.field,
    this.comparisonMethod,
    this.value,
  });

  static AssetSearchDataMetadataConditionModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return AssetSearchDataMetadataConditionModel(
      field: AssetSearchMetadataFieldEnum.fromJsonDtoValue(dto?['field']) ??
          AssetSearchMetadataFieldEnum.unknown,
      comparisonMethod: ComparisonMethodEnum.fromJsonDtoValue(dto?['field']),
      value: dto?['created_at'],
    );
  }

  @override
  List<Object?> get props => [
        field,
        comparisonMethod,
        value,
      ];

  AssetSearchDataMetadataConditionModel copyWith({
    required ComparisonMethodEnum? comparisonMethod,
    required dynamic value,
  }) {
    return AssetSearchDataMetadataConditionModel(
      field: field,
      comparisonMethod: comparisonMethod ?? this.comparisonMethod,
      value: value,
    );
  }

  AssetSearchDataMetadataConditionModel copyWithComparisonMethod(
    ComparisonMethodEnum? comparisonMethod,
  ) {
    return AssetSearchDataMetadataConditionModel(
      field: field,
      comparisonMethod: comparisonMethod ?? this.comparisonMethod,
      value: value,
    );
  }

  AssetSearchDataMetadataConditionModel copyWithValue(
    dynamic value,
  ) {
    return AssetSearchDataMetadataConditionModel(
      field: field,
      comparisonMethod: comparisonMethod,
      value: value,
    );
  }

  Map<String, dynamic> toJsonDto() {
    return {
      'field': field.toJsonDtoValue(),
      'comparison_method': comparisonMethod?.toJsonDtoValue(),
      'value': value,
    };
  }
}
