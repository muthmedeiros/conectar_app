import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../controllers/clients_controller.dart';

Future<bool> showDeleteClientDialog({
  required BuildContext context,
  required String clientId,
  required String clientName,
}) async {
  final controller = context.read<ClientsController>();

  final confirm = await showDialog<bool>(
    context: context,
    builder: (context) => _DeleteClientDialog(clientId: clientId, clientName: clientName),
  ).then((value) => value ?? false);

  if (confirm == true) {
    await controller.deleteClient(clientId);
  }

  return confirm;
}

class _DeleteClientDialog extends StatelessWidget {
  const _DeleteClientDialog({required this.clientId, required this.clientName});

  final String clientId;
  final String clientName;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmar exclusão'),
      content: Text('Tem certeza de que deseja excluir o cliente "$clientName"?'),
      actions: [
        TextButton(onPressed: () => context.pop(false), child: const Text('Cancelar')),
        ElevatedButton(onPressed: () => context.pop(true), child: const Text('Deletar')),
      ],
    );
  }
}
