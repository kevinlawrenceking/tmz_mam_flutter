
class Roles {
final int id;
final String uuid;
final String? name;
final DateTime? created;
final DateTime? lastUpdated;
final bool? viewUncategorizedContent;
final bool? modifyAssetCategories;
final bool? modifyAssetDetails;
final bool? createCollections;
final bool? modifyCollectionContents;
final bool? createCollaborateSharedTask;
final bool? createCollaborateRequestTask;
final bool? deleteAssets;
final bool? batchUpdate;
final bool? exportVideoContent;
final bool? downloadProxies;
final bool? downloadHighResSource;
final bool? modifyClipDetails;
final bool? modifyProjects;
final bool? pauseResumeAbandonVisibleWorkflows;
final bool? createTimelines;
final bool? modifyTimelines;
final bool? scheduleLiveEvents;
final bool? postToLinkedAccounts;
final bool? setVideoThumbnail;
final bool? deleteFlag;


Roles({
required this.id,
required this.uuid,
this.name,
this.created,
this.lastUpdated,
this.viewUncategorizedContent,
this.modifyAssetCategories,
this.modifyAssetDetails,
this.createCollections,
this.modifyCollectionContents,
this.createCollaborateSharedTask,
this.createCollaborateRequestTask,
this.deleteAssets,
this.batchUpdate,
this.exportVideoContent,
this.downloadProxies,
this.downloadHighResSource,
this.modifyClipDetails,
this.modifyProjects,
this.pauseResumeAbandonVisibleWorkflows,
this.createTimelines,
this.modifyTimelines,
this.scheduleLiveEvents,
this.postToLinkedAccounts,
this.setVideoThumbnail,
this.deleteFlag,
});

factory Roles.fromJson(Map<String, dynamic> json) {
    return Roles(
id: json['id'] as int,
uuid: json['uuid'] as String,
name: json['name'] as String,
created: json['created'] != null ? DateTime.parse(json['created']) : null,
lastUpdated: json['lastUpdated'] != null ? DateTime.parse(json['lastUpdated']) : null,
viewUncategorizedContent: json['viewUncategorizedContent'] as bool,
modifyAssetCategories: json['modifyAssetCategories'] as bool,
modifyAssetDetails: json['modifyAssetDetails'] as bool,
createCollections: json['createCollections'] as bool,
modifyCollectionContents: json['modifyCollectionContents'] as bool,
createCollaborateSharedTask: json['createCollaborateSharedTask'] as bool,
createCollaborateRequestTask: json['createCollaborateRequestTask'] as bool,
deleteAssets: json['deleteAssets'] as bool,
batchUpdate: json['batchUpdate'] as bool,
exportVideoContent: json['exportVideoContent'] as bool,
downloadProxies: json['downloadProxies'] as bool,
downloadHighResSource: json['downloadHighResSource'] as bool,
modifyClipDetails: json['modifyClipDetails'] as bool,
modifyProjects: json['modifyProjects'] as bool,
pauseResumeAbandonVisibleWorkflows: json['pauseResumeAbandonVisibleWorkflows'] as bool,
createTimelines: json['createTimelines'] as bool,
modifyTimelines: json['modifyTimelines'] as bool,
scheduleLiveEvents: json['scheduleLiveEvents'] as bool,
postToLinkedAccounts: json['postToLinkedAccounts'] as bool,
setVideoThumbnail: json['setVideoThumbnail'] as bool,
deleteFlag: json['deleteFlag'] as bool,

    );
  }
}

