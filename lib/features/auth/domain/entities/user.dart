import 'package:equatable/equatable.dart';

import '../../../../core/enums/user_role.dart';

class User extends Equatable {
  const User({required this.id, required this.name, required this.email, required this.role});

  final String id;
  final String name;
  final String email;
  final UserRole role;

  bool get isAdmin => role.isAdmin;

  @override
  List<Object?> get props => [id, name, email, role];
}
