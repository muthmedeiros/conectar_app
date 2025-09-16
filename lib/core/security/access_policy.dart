import '../../features/auth/domain/entities/user.dart';

class AccessPolicy {
  bool canViewAllClients(User? u) => u?.isAdmin == true;
  bool canRegisterClients(User? u) => u?.isAdmin == true;
  bool canDeleteClients(User? u) => u?.isAdmin == true;
  bool canEditClient(User? u, String clientAdminUserId) =>
      u?.isAdmin == true || (u != null && u.id == clientAdminUserId);
  
  bool canViewAllUsers(User? u) => u?.isAdmin == true;
  bool canRegisterUsers(User? u) => u?.isAdmin == true;
  bool canEditUser(User? u, dynamic targetUser) => u?.isAdmin == true;
  bool canDeleteUser(User? u, dynamic targetUser) => u?.isAdmin == true;
}
