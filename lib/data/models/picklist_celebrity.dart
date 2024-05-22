import 'package:equatable/equatable.dart';
import 'package:tmz_damz/data/models/user.dart';

enum PicklistCelebrityStatusEnum {
  unknown,
  available;

  factory PicklistCelebrityStatusEnum.fromJsonDtoValue(
    String? value,
  ) {
    switch (value?.toUpperCase()) {
      case 'AVAILABLE':
        return available;
      default:
        return unknown;
    }
  }
}

class PicklistCelebrityModel extends Equatable {
  final String id;
  final PicklistCelebrityStatusEnum status;
  final UserMetaModel createdBy;
  final DateTime createdAt;
  final String name;

  const PicklistCelebrityModel({
    required this.id,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.name,
  });

  static PicklistCelebrityModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return PicklistCelebrityModel(
      id: dto?['id'] ?? '',
      status: PicklistCelebrityStatusEnum.fromJsonDtoValue(dto?['status']),
      createdBy: UserMetaModel.fromJsonDto(dto?['created_by']),
      createdAt: DateTime.parse(
        dto?['created_at'] ??
            DateTime.fromMillisecondsSinceEpoch(0).toIso8601String(),
      ),
      name: dto?['name'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        status,
        createdBy,
        createdAt,
        name,
      ];
}
