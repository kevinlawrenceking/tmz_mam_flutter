import 'package:equatable/equatable.dart';

class UserMetaModel extends Equatable {
  final String userID;
  final String firstName;
  final String lastName;

  const UserMetaModel({
    required this.userID,
    required this.firstName,
    required this.lastName,
  });

  static UserMetaModel fromJsonDto(
    Map<String, dynamic>? dto,
  ) {
    return UserMetaModel(
      userID: dto?['user_id'] ?? '',
      firstName: dto?['first_name'] ?? '',
      lastName: dto?['last_name'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        userID,
        firstName,
        lastName,
      ];

  UserMetaModel copy() {
    return UserMetaModel(
      userID: userID,
      firstName: firstName,
      lastName: lastName,
    );
  }
}
