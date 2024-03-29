import 'package:tmz_damz/data/models/asset_metadata.dart';

class BulkMetaViewModel {
  final List<String>? agency;
  final bool? celebrity;
  final List<String>? celebrityAssociated;
  final List<String>? celebrityInPhoto;
  final String? credit;
  final AssetMetadataCreditLocationEnum? creditLocation;
  final List<AssetMetadataEmotionEnum>? emotion;
  final String? headline;
  final List<String>? keywords;
  final List<AssetMetadataOverlayEnum>? overlay;
  final AssetMetadataRightsEnum? rights;
  final String? rightsDetails;
  final String? rightsInstructions;
  final String? shotDescription;

  const BulkMetaViewModel({
    required this.agency,
    required this.celebrity,
    required this.celebrityAssociated,
    required this.celebrityInPhoto,
    required this.credit,
    required this.creditLocation,
    required this.emotion,
    required this.headline,
    required this.keywords,
    required this.overlay,
    required this.rights,
    required this.rightsDetails,
    required this.rightsInstructions,
    required this.shotDescription,
  });
}
