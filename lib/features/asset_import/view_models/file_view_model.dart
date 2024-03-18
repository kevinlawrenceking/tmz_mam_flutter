import 'package:equatable/equatable.dart';
import 'package:fixnum/fixnum.dart';
import 'package:tmz_damz/data/models/asset_import_session_file.dart';

class FileViewModel extends Equatable {
  final String sessionID;
  final String fileID;
  final String fileName;
  final Int64 fileSize;
  final DateTime uploadedAt;
  final AssetImportSessionFileStatusEnum status;
  final AssetImportSessionFileMetaModel? meta;

  const FileViewModel({
    required this.sessionID,
    required this.fileID,
    required this.fileName,
    required this.fileSize,
    required this.uploadedAt,
    this.status = AssetImportSessionFileStatusEnum.unknown,
    this.meta,
  });

  static FileViewModel fromAssetImportSessionFileModel(
    AssetImportSessionFileModel model,
  ) {
    return FileViewModel(
      sessionID: model.sessionID,
      fileID: model.id,
      fileName: model.originalFileName,
      fileSize: model.fileInfo.sizeOnDisk,
      uploadedAt: model.uploadedAt,
      status: model.status,
      meta: model.meta,
    );
  }

  @override
  List<Object?> get props => [
        sessionID,
        fileID,
        fileName,
        fileSize,
        uploadedAt,
        status,
        meta,
      ];
}
