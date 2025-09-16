import '../../domain/entities/client_entity.dart';
import '../../domain/enums/client_status.dart';

class ClientModel {
  static ClientEntity fromMap(Map<String, dynamic> e) {
    return ClientEntity(
      id: e['id'] ?? '',
      corporateReason: e['corporateReason'] ?? '',
      cnpj: e['cnpj'] ?? '',
      name: e['name'] ?? '',
      status: e['status'] == 'active'
          ? ClientStatus.active
          : ClientStatus.inactive,
      conectarPlus: e['conectarPlus'] ?? false,
      adminUserId: e['adminUserId'] ?? '',
      createdAt:
          DateTime.tryParse(e['createdAt']?.toString() ?? '') ?? DateTime(2000),
      updatedAt:
          DateTime.tryParse(e['updatedAt']?.toString() ?? '') ?? DateTime(2000),
      users: (e['users'] as List?)
          ?.map((u) => Map<String, dynamic>.from(u))
          .toList(),
      adminUser: e['adminUser'] != null
          ? Map<String, dynamic>.from(e['adminUser'])
          : null,
    );
  }
}
