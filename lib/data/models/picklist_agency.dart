import 'package:equatable/equatable.dart';
import 'package:tmz_damz/data/models/user.dart';

enum PicklistAgencyStatusEnum {
  unknown,
  available;

  factory PicklistAgencyStatusEnum.fromJsonDtoValue(
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

class PicklistAgencyModel extends Equatable {
  final String id;
  final PicklistAgencyStatusEnum status;
  final UserMetaModel createdBy;
  final DateTime createdAt;
  final String name;

  const PicklistAgencyModel({
    required this.id,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.name,
  });

  static PicklistAgencyModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return PicklistAgencyModel(
      id: dto?['id'] ?? '',
      status: PicklistAgencyStatusEnum.fromJsonDtoValue(dto?['status']),
      createdBy: UserMetaModel.fromJsonDto(dto?['created_by']),
      createdAt: DateTime.parse(
        dto?['created_at'] ?? DateTime.fromMillisecondsSinceEpoch(0),
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
