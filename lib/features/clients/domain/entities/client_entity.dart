import 'package:equatable/equatable.dart';

import '../enums/client_status.dart';

class ClientEntity extends Equatable {
  const ClientEntity({
    required this.id,
    required this.corporateReason,
    required this.cnpj,
    required this.name,
    required this.status,
    required this.conectarPlus,
    required this.adminUserId,
    required this.createdAt,
    required this.updatedAt,
    this.users,
    this.adminUser,
  });

  final String id;
  final String corporateReason;
  final String cnpj;
  final String name;
  final ClientStatus status;
  final bool conectarPlus;
  final String adminUserId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Map<String, dynamic>>? users;
  final Map<String, dynamic>? adminUser;

  String get createdAtFormatted {
    return '${createdAt.day.toString().padLeft(2, '0')}/${createdAt.month.toString().padLeft(2, '0')}/${createdAt.year}';
  }

  @override
  List<Object?> get props {
    return [
      id,
      corporateReason,
      cnpj,
      name,
      status,
      conectarPlus,
      adminUserId,
      createdAt,
      updatedAt,
      users,
      adminUser,
    ];
  }
}
