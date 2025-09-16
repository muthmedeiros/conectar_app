class UpdateUserDto {
  const UpdateUserDto({
    this.name,
    this.email,
    this.role,
  });

  final String? name;
  final String? email;
  final String? role;

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    if (name != null) map['name'] = name;
    if (email != null) map['email'] = email;
    if (role != null) map['role'] = role;
    return map;
  }
}