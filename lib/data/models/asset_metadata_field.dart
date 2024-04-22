import 'package:equatable/equatable.dart';

enum AssetMetadataFieldEnum {
  agency,
  celebrityAssociated,
  celebrityInPhoto,
  credit,
  creditLocation,
  emotion,
  headline,
  keywords,
  locationCity,
  locationCountry,
  locationDescription,
  locationState,
  overlay,
  rights,
  rightsDetails,
  rightsInstructions,
  shotDescription;

  String? toJsonDtoValue() {
    return {
      AssetMetadataFieldEnum.agency: 'AGENCY',
      AssetMetadataFieldEnum.celebrityAssociated: 'CELEBRITY_ASSOCIATED',
      AssetMetadataFieldEnum.celebrityInPhoto: 'CELEBRITY_IN_PHOTO',
      AssetMetadataFieldEnum.credit: 'CREDIT',
      AssetMetadataFieldEnum.creditLocation: 'CREDIT_LOCATION',
      AssetMetadataFieldEnum.emotion: 'EMOTION',
      AssetMetadataFieldEnum.headline: 'HEADLINE',
      AssetMetadataFieldEnum.keywords: 'KEYWORDS',
      AssetMetadataFieldEnum.locationCity: 'LOCATION_CITY',
      AssetMetadataFieldEnum.locationCountry: 'LOCATION_COUNTRY',
      AssetMetadataFieldEnum.locationDescription: 'LOCATION_DESCRIPTION',
      AssetMetadataFieldEnum.locationState: 'LOCATION_STATE',
      AssetMetadataFieldEnum.overlay: 'OVERLAY',
      AssetMetadataFieldEnum.rights: 'RIGHTS',
      AssetMetadataFieldEnum.rightsDetails: 'RIGHTS_DETAILS',
      AssetMetadataFieldEnum.rightsInstructions: 'RIGHTS_INSTRUCTIONS',
      AssetMetadataFieldEnum.shotDescription: 'SHOT_DESCRIPTION',
    }[this];
  }
}

enum AssetMetadataFieldModeEnum {
  append,
  prepend,
  replace;

  String? toJsonDtoValue() {
    return {
      AssetMetadataFieldModeEnum.append: 'APPEND',
      AssetMetadataFieldModeEnum.prepend: 'PREPEND',
      AssetMetadataFieldModeEnum.replace: 'REPLACE',
    }[this];
  }
}

abstract class IAssetMetadataFieldValue extends Equatable {
  abstract final AssetMetadataFieldEnum field;
  abstract final AssetMetadataFieldModeEnum mode;
  abstract final dynamic value;

  Map<String, dynamic> toJsonDto();
}

class AssetMetadataFieldValue<T> extends Equatable
    implements IAssetMetadataFieldValue {
  @override
  final AssetMetadataFieldEnum field;

  @override
  final AssetMetadataFieldModeEnum mode;

  @override
  final T value;

  const AssetMetadataFieldValue({
    required this.field,
    required this.mode,
    required this.value,
  });

  @override
  List<Object?> get props => [
        field,
        mode,
        value,
      ];

  @override
  Map<String, dynamic> toJsonDto() {
    return {
      'field': field.toJsonDtoValue(),
      'mode': mode.toJsonDtoValue(),
      'value': value,
    };
  }
}
