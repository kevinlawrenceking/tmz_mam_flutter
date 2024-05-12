import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class FileUploadViewModel extends Equatable {
  final String sessionID;
  final String uploadID;
  final DateTime uploadedAt;
  final String fileName;
  final int fileSize;

  final Uint8List? fileData;
  final String? mimeType;

  const FileUploadViewModel({
    required this.sessionID,
    required this.uploadID,
    required this.uploadedAt,
    required this.fileName,
    required this.fileSize,
    this.fileData,
    this.mimeType,
  });

  @override
  List<Object?> get props => [
        sessionID,
        uploadID,
        uploadedAt,
        fileName,
        fileSize,
        fileData,
        mimeType,
      ];
}
