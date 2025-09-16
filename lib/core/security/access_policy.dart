import '../../features/auth/domain/entities/user.dart';

class AccessPolicy {
  bool canViewAllClients(User? u) => u?.isAdmin == true;
  bool canRegisterClients(User? u) => u?.isAdmin == true;
  bool canDeleteClients(User? u) => u?.isAdmin == true;
  bool canEditClient(User? u, String targetUserId) =>
      u?.isAdmin == true || (u != null && u.id == targetUserId);

  bool canViewAllUsers(User? u) => u?.isAdmin == true;
  bool canRegisterUsers(User? u) => u?.isAdmin == true;
  bool canEditUser(User? u, String targetUserId) => u?.isAdmin == true || u?.id == targetUserId;
  bool canDeleteUser(User? u, String targetUserId) => u?.isAdmin == true && u?.id != targetUserId;
}
