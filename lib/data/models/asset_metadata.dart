import 'package:equatable/equatable.dart';
import 'package:fixnum/fixnum.dart';

enum AssetMetadataCreditLocationEnum {
  unknown,
  end,
  onScreen;

  static AssetMetadataCreditLocationEnum? fromJsonDtoValue(
    String? value,
  ) {
    switch (value?.toUpperCase()) {
      case 'END':
        return end;
      case 'ON_SCREEN':
        return onScreen;
      default:
        return unknown;
    }
  }

  String? toJsonDtoValue() {
    switch (this) {
      case end:
        return 'END';
      case onScreen:
        return 'ON_SCREEN';
      default:
        return null;
    }
  }
}

enum AssetMetadataEmotionEnum {
  unknown,
  negative,
  neutral,
  positive,
  surprised;

  factory AssetMetadataEmotionEnum.fromJsonDtoValue(
    String? value,
  ) {
    switch (value?.toUpperCase()) {
      case 'NEGATIVE':
        return negative;
      case 'NEUTRAL':
        return neutral;
      case 'POSITIVE':
        return positive;
      case 'SURPRISED':
        return surprised;
      default:
        return unknown;
    }
  }

  String? toJsonDtoValue() {
    switch (this) {
      case negative:
        return 'NEGATIVE';
      case neutral:
        return 'NEUTRAL';
      case positive:
        return 'POSITIVE';
      case surprised:
        return 'SURPRISED';
      default:
        return null;
    }
  }
}

enum AssetMetadataExclusivityEnum {
  exclusive,
  premiumExclusive;

  static AssetMetadataExclusivityEnum? fromJsonDtoValue(
    String? value,
  ) {
    switch (value?.toUpperCase()) {
      case 'EXCLUSIVE':
        return exclusive;
      case 'PREMIUM_EXCLUSIVE':
        return premiumExclusive;
      default:
        return null;
    }
  }

  String? toJsonDtoValue() {
    switch (this) {
      case exclusive:
        return 'EXCLUSIVE';
      case premiumExclusive:
        return 'PREMIUM_EXCLUSIVE';
      default:
        return null;
    }
  }
}

enum AssetMetadataOverlayEnum {
  unknown,
  blackBarCensor,
  blurCensor,
  watermark;

  factory AssetMetadataOverlayEnum.fromJsonDtoValue(
    String? value,
  ) {
    switch (value?.toUpperCase()) {
      case 'BLACK_BAR_CENSOR':
        return blackBarCensor;
      case 'BLUR_CENSOR':
        return blurCensor;
      case 'WATERMARK':
        return watermark;
      default:
        return unknown;
    }
  }

  String? toJsonDtoValue() {
    switch (this) {
      case blackBarCensor:
        return 'BLACK_BAR_CENSOR';
      case blurCensor:
        return 'BLUR_CENSOR';
      case watermark:
        return 'WATERMARK';
      default:
        return null;
    }
  }
}

enum AssetMetadataRightsEnum {
  unknown,
  costNonTMZ,
  freeNonTMZ,
  freeTMZ;

  factory AssetMetadataRightsEnum.fromJsonDtoValue(
    String? value,
  ) {
    switch (value?.toUpperCase()) {
      case 'COST_NON_TMZ':
        return costNonTMZ;
      case 'FREE_NON_TMZ':
        return freeNonTMZ;
      case 'FREE_TMZ':
        return freeTMZ;
      default:
        return unknown;
    }
  }

  String? toJsonDtoValue() {
    switch (this) {
      case costNonTMZ:
        return 'COST_NON_TMZ';
      case freeNonTMZ:
        return 'FREE_NON_TMZ';
      case freeTMZ:
        return 'FREE_TMZ';
      default:
        return null;
    }
  }
}

class AssetMetadataModel extends Equatable {
  final Int32? daletID;
  final List<String>? keywords;
  final String? shotDescription;
  final AssetMetadataLocationModel? location;
  final List<String>? agency;
  final List<AssetMetadataEmotionEnum>? emotion;
  final List<AssetMetadataOverlayEnum>? overlay;
  final bool? celebrity;
  final List<String>? celebrityInPhoto;
  final List<String>? celebrityAssociated;
  final AssetMetadataRightsEnum? rights;
  final String? credit;
  final AssetMetadataCreditLocationEnum? creditLocation;
  final AssetMetadataExclusivityEnum? exclusivity;
  final String? rightsInstructions;
  final String? rightsDetails;
  final String? qcNotes;

  const AssetMetadataModel({
    this.daletID,
    this.keywords,
    this.shotDescription,
    this.location,
    this.agency,
    this.emotion,
    this.overlay,
    this.celebrity,
    this.celebrityInPhoto,
    this.celebrityAssociated,
    this.rights,
    this.credit,
    this.creditLocation,
    this.exclusivity,
    this.rightsInstructions,
    this.rightsDetails,
    this.qcNotes,
  });

  static AssetMetadataModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return AssetMetadataModel(
      daletID: dto?['dalet_id'] != null ? Int32(dto!['dalet_id']) : null,
      keywords: (dto?['keywords'] as List<dynamic>?)
              ?.map((_) => _.toString())
              .toList() ??
          [],
      shotDescription: dto?['shot_description'] ?? '',
      location: AssetMetadataLocationModel.fromJsonDto(
        dto?['location'],
      ),
      agency: (dto?['agency'] as List<dynamic>?)
          ?.map(
            (_) => _.toString(),
          )
          .toList(),
      emotion: (dto?['emotion'] as List<dynamic>?)
          ?.map(
            (_) => AssetMetadataEmotionEnum.fromJsonDtoValue(_.toString()),
          )
          .toList(),
      overlay: (dto?['overlay'] as List<dynamic>?)
          ?.map(
            (_) => AssetMetadataOverlayEnum.fromJsonDtoValue(_.toString()),
          )
          .toList(),
      celebrity: dto?['celebrity'] ?? false,
      celebrityInPhoto: (dto?['celebrity_in_photo'] as List<dynamic>?)
          ?.map((_) => _.toString())
          .toList(),
      celebrityAssociated: (dto?['celebrity_associated'] as List<dynamic>?)
          ?.map((_) => _.toString())
          .toList(),
      rights: AssetMetadataRightsEnum.fromJsonDtoValue(
        dto?['rights'],
      ),
      credit: dto?['credit'],
      creditLocation: AssetMetadataCreditLocationEnum.fromJsonDtoValue(
        dto?['credit_location'],
      ),
      exclusivity: AssetMetadataExclusivityEnum.fromJsonDtoValue(
        dto?['exclusivity'],
      ),
      rightsInstructions: dto?['rights_instructions'],
      rightsDetails: dto?['rights_details'],
      qcNotes: dto?['qc_notes'],
    );
  }

  @override
  List<Object?> get props => [
        daletID,
        keywords,
        shotDescription,
        location,
        agency,
        emotion,
        overlay,
        celebrity,
        celebrityInPhoto,
        celebrityAssociated,
        rights,
        credit,
        creditLocation,
        exclusivity,
        rightsInstructions,
        rightsDetails,
        qcNotes,
      ];

  Map<String, dynamic> toJsonDto() {
    return {
      'dalet_id': daletID?.toInt(),
      'keywords': keywords,
      'shot_description': shotDescription,
      'location': location?.toJsonDto(),
      'agency': agency,
      'emotion': emotion
          ?.map((_) => _.toJsonDtoValue())
          .where((_) => _ != null)
          .toList(),
      'overlay': overlay
          ?.map((_) => _.toJsonDtoValue())
          .where((_) => _ != null)
          .toList(),
      'celebrity': celebrity,
      'celebrity_in_photo': celebrityInPhoto,
      'celebrity_associated': celebrityAssociated,
      'rights': rights?.toJsonDtoValue(),
      'credit': credit,
      'credit_location': creditLocation?.toJsonDtoValue(),
      'exclusivity': exclusivity?.toJsonDtoValue(),
      'rights_instructions': rightsInstructions,
      'rights_details': rightsDetails,
      'qc_notes': qcNotes,
    };
  }
}

class AssetMetadataLocationModel extends Equatable {
  final String? description;
  final String? country;
  final String? state;
  final String? city;

  const AssetMetadataLocationModel({
    required this.description,
    required this.country,
    required this.state,
    required this.city,
  });

  static AssetMetadataLocationModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return AssetMetadataLocationModel(
      description: dto?['description'],
      country: dto?['country'],
      state: dto?['state'],
      city: dto?['city'],
    );
  }

  @override
  List<Object?> get props => [
        description,
        country,
        state,
        city,
      ];

  Map<String, dynamic> toJsonDto() {
    return {
      'description': description,
      'country': country,
      'state': state,
      'city': city,
    };
  }
}
