import '../../features/auth/domain/entities/user.dart';

class AccessPolicy {
  bool canViewAllClients(User? u) => u?.isAdmin == true;
  bool canRegisterClients(User? u) => u?.isAdmin == true;
  bool canDeleteClients(User? u) => u?.isAdmin == true;
  bool canEditClient(User? u, String clientAdminUserId) =>
      u?.isAdmin == true || (u != null && u.id == clientAdminUserId);
}
