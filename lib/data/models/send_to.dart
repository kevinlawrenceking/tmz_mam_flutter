import 'package:equatable/equatable.dart';

class SendToModel extends Equatable {
  final String id;
  final String label;

  const SendToModel({
    required this.id,
    required this.label,
  });

  static SendToModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return SendToModel(
      id: dto?['id'] ?? '',
      label: dto?['label'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        id,
        label,
      ];
}
