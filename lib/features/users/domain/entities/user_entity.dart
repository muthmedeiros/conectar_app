import 'package:equatable/equatable.dart';

import '../../../../core/enums/user_role.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    this.lastLogin,
  });

  final String id;
  final String name;
  final String email;
  final UserRole role;
  final DateTime? lastLogin;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    UserRole? role,
    DateTime? lastLogin,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      lastLogin: lastLogin ?? this.lastLogin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Check if user is inactive (hasn't logged in for more than 30 days)
  bool get isInactive {
    if (lastLogin == null) return true;
    final now = DateTime.now();
    final diffInDays = now.difference(lastLogin!).inDays;
    return diffInDays > 30;
  }

  String get createdAtFormatted {
    return '${createdAt.day.toString().padLeft(2, '0')}/${createdAt.month.toString().padLeft(2, '0')}/${createdAt.year}';
  }

  String? get lastLoginFormatted {
    if (lastLogin == null) return null;
    return '${lastLogin!.day.toString().padLeft(2, '0')}/${lastLogin!.month.toString().padLeft(2, '0')}/${lastLogin!.year} ${lastLogin!.hour.toString().padLeft(2, '0')}:${lastLogin!.minute.toString().padLeft(2, '0')}';
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    role,
    lastLogin,
    createdAt,
    updatedAt,
  ];
}
