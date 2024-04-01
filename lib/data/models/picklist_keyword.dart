import 'package:equatable/equatable.dart';
import 'package:tmz_damz/data/models/user.dart';

enum PicklistKeywordStatusEnum {
  unknown,
  available;

  factory PicklistKeywordStatusEnum.fromJsonDtoValue(
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

class PicklistKeywordModel extends Equatable {
  final String id;
  final PicklistKeywordStatusEnum status;
  final UserMetaModel createdBy;
  final DateTime createdAt;
  final String value;

  const PicklistKeywordModel({
    required this.id,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.value,
  });

  static PicklistKeywordModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return PicklistKeywordModel(
      id: dto?['id'] ?? '',
      status: PicklistKeywordStatusEnum.fromJsonDtoValue(dto?['status']),
      createdBy: UserMetaModel.fromJsonDto(dto?['created_by']),
      createdAt: DateTime.parse(
        dto?['created_at'] ?? DateTime.fromMillisecondsSinceEpoch(0),
      ),
      value: dto?['value'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        status,
        createdBy,
        createdAt,
        value,
      ];
}
