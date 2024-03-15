enum AssetMetadataCreditLocationEnum {
  unknown,
  end,
  onScreen;

  factory AssetMetadataCreditLocationEnum.fromJsonDtoValue(
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
}

enum AssetMetadataEmotionEnum {
  unknown,
  negative,
  neutral,
  positive,
  surprised,
}

enum AssetMetadataExclusivityEnum {
  unknown,
  exclusive,
  premiumExclusive;

  factory AssetMetadataExclusivityEnum.fromJsonDtoValue(
    String? value,
  ) {
    switch (value?.toUpperCase()) {
      case 'EXCLUSIVE':
        return exclusive;
      case 'PREMIUM_EXCLUSIVE':
        return premiumExclusive;
      default:
        return unknown;
    }
  }
}

enum AssetMetadataOverlayEnum {
  unknown,
  blackBarCensor,
  blurCensor,
  watermark,
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
}

class AssetMetadataModel {
  final List<String> keywords;
  final String shotDescription;
  final AssetMetadataLocationModel location;
  final List<String> agency;
  final List<String> emotion;
  final List<String> overlay;
  final bool celebrity;
  final List<String> celebrityInPhoto;
  final List<String> celebrityAssociated;
  final AssetMetadataRightsEnum rights;
  final String? credit;
  final AssetMetadataCreditLocationEnum creditLocation;
  final AssetMetadataExclusivityEnum exclusivity;

  AssetMetadataModel({
    required this.keywords,
    required this.shotDescription,
    required this.location,
    required this.agency,
    required this.emotion,
    required this.overlay,
    required this.celebrity,
    required this.celebrityInPhoto,
    required this.celebrityAssociated,
    required this.rights,
    required this.credit,
    required this.creditLocation,
    required this.exclusivity,
  });

  static AssetMetadataModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return AssetMetadataModel(
      keywords: (dto?['keywords'] as List<dynamic>?)
              ?.map((_) => _ as String)
              .toList() ??
          [],
      shotDescription: dto?['shot_description'] ?? '',
      location: AssetMetadataLocationModel.fromJsonDto(
        dto?['status'],
      ),
      agency: (dto?['agency'] as List<dynamic>?)
              ?.map((_) => _ as String)
              .toList() ??
          [],
      emotion: (dto?['emotion'] as List<dynamic>?)
              ?.map((_) => _ as String)
              .toList() ??
          [],
      overlay: (dto?['overlay'] as List<dynamic>?)
              ?.map((_) => _ as String)
              .toList() ??
          [],
      celebrity: dto?['celebrity'] ?? false,
      celebrityInPhoto: (dto?['celebrity_in_photo'] as List<dynamic>?)
              ?.map((_) => _ as String)
              .toList() ??
          [],
      celebrityAssociated: (dto?['celebrity_associated'] as List<dynamic>?)
              ?.map((_) => _ as String)
              .toList() ??
          [],
      rights: AssetMetadataRightsEnum.fromJsonDtoValue(
        dto?['rights'],
      ),
      credit: dto?['credit'] ?? '',
      creditLocation: AssetMetadataCreditLocationEnum.fromJsonDtoValue(
        dto?['credit_location'],
      ),
      exclusivity: AssetMetadataExclusivityEnum.fromJsonDtoValue(
        dto?['exclusivity'],
      ),
    );
  }
}

class AssetMetadataLocationModel {
  final String? description;
  final String? country;
  final String? state;
  final String? city;

  AssetMetadataLocationModel({
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
}
