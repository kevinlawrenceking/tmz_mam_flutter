
class Metadata {
final int id;
final String? uuid;
final DateTime? dateCreated;
final DateTime? dateUpdated;
final String? shootLocation;
final String? keywords;
final bool? onScreenCredit;
final String? stateAlt;
final String? associatedCelebrityAlt;
final String? sourceAlt;
final int? daletID;
final DateTime? shootDate;
final String? creditLocation;
final String? qCNotes;
final String? credit;
final String? headline;
final String? nameOfFile;
final String? rightsDetails;
final bool? cityFixed;
final String? countryAlt;
final String? celebrityAlt;
final String? cityAlt;
final String? createdBy;
final String? rightsSummary;
final String? exclusivity;
final String? shotDescription;
final String? shootDateAlt;
final String? watermarkRequired;
final bool? deleteFlag;


Metadata({
required this.id,
this.uuid,
this.dateCreated,
this.dateUpdated,
this.shootLocation,
this.keywords,
this.onScreenCredit,
this.stateAlt,
this.associatedCelebrityAlt,
this.sourceAlt,
this.daletID,
this.shootDate,
this.creditLocation,
this.qCNotes,
this.credit,
this.headline,
this.nameOfFile,
this.rightsDetails,
this.cityFixed,
this.countryAlt,
this.celebrityAlt,
this.cityAlt,
this.createdBy,
this.rightsSummary,
this.exclusivity,
this.shotDescription,
this.shootDateAlt,
this.watermarkRequired,
this.deleteFlag,
});

factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
id: json['id'] as int,
uuid: json['uuid'] as String,
dateCreated: json['dateCreated'] != null ? DateTime.parse(json['dateCreated']) : null,
dateUpdated: json['dateUpdated'] != null ? DateTime.parse(json['dateUpdated']) : null,
shootLocation: json['shootLocation'] as String,
keywords: json['keywords'] as String,
onScreenCredit: json['onScreenCredit'] as bool,
stateAlt: json['stateAlt'] as String,
associatedCelebrityAlt: json['associatedCelebrityAlt'] as String,
sourceAlt: json['sourceAlt'] as String,
daletID: json['daletID'] as int,
shootDate: json['shootDate'] != null ? DateTime.parse(json['shootDate']) : null,
creditLocation: json['creditLocation'] as String,
qCNotes: json['qCNotes'] as String,
credit: json['credit'] as String,
headline: json['headline'] as String,
nameOfFile: json['nameOfFile'] as String,
rightsDetails: json['rightsDetails'] as String,
cityFixed: json['cityFixed'] as bool,
countryAlt: json['countryAlt'] as String,
celebrityAlt: json['celebrityAlt'] as String,
cityAlt: json['cityAlt'] as String,
createdBy: json['createdBy'] as String,
rightsSummary: json['rightsSummary'] as String,
exclusivity: json['exclusivity'] as String,
shotDescription: json['shotDescription'] as String,
shootDateAlt: json['shootDateAlt'] as String,
watermarkRequired: json['watermarkRequired'] as String,
deleteFlag: json['deleteFlag'] as bool,

    );
  }
}

