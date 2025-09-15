import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.isAdmin,
  });

  final String id;
  final String name;
  final String email;
  final bool isAdmin;

  @override
  List<Object?> get props => [id, email, isAdmin];
}
