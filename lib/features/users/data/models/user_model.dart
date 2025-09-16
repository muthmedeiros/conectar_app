import '../../domain/entities/user_entity.dart';
import '../../../../core/enums/user_role.dart';

class UserModel {
  static UserEntity fromMap(Map<String, dynamic> e) {
    return UserEntity(
      id: e['id'] ?? '',
      name: e['name'] ?? '',
      email: e['email'] ?? '',
      role: UserRole.fromString(e['role']?.toString() ?? 'user'),
      lastLogin: e['lastLogin'] != null
          ? DateTime.tryParse(e['lastLogin'].toString())
          : null,
      createdAt:
          DateTime.tryParse(e['createdAt']?.toString() ?? '') ?? DateTime(2000),
      updatedAt:
          DateTime.tryParse(e['updatedAt']?.toString() ?? '') ?? DateTime(2000),
    );
  }
}