enum UserRole {
  admin('admin'),
  user('user');

  const UserRole(this.value);
  final String value;

  bool get isAdmin => this == UserRole.admin;
  bool get isUser => this == UserRole.user;

  static UserRole fromString(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return UserRole.admin;
      case 'user':
        return UserRole.user;
      default:
        throw ArgumentError('Unknown role: $role');
    }
  }
}
