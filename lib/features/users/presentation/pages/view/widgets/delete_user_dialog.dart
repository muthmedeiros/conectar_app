import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/users_controller.dart';

Future<bool> showDeleteUserDialog({
  required BuildContext context,
  required String userId,
  required String userName,
}) async {
  final controller = context.read<UsersController>();

  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) => _DeleteUserDialog(userId: userId, userName: userName),
  ).then((value) => value ?? false);

  if (confirm == true) {
    await controller.deleteUser(userId);
  }

  return confirm;
}

class _DeleteUserDialog extends StatelessWidget {
  const _DeleteUserDialog({required this.userId, required this.userName});

  final String userId;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmar exclusão'),
      content: Text('Tem certeza de que deseja excluir o usuário "$userName"?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Deletar'),
        ),
      ],
    );
  }
}
