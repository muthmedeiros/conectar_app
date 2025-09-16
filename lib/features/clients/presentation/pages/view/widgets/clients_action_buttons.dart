import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/theme/tokens/colors.dart';
import '../../../../../../core/theme/tokens/font_sizes.dart';
import '../../../../../auth/presentation/controllers/auth_controller.dart';
import '../../../../domain/entities/client_entity.dart';
import 'delete_client_dialog.dart';

typedef DeleteCallback = void Function();

class ClientsActionButtons extends StatelessWidget {
  const ClientsActionButtons({super.key, required this.client});

  final ClientEntity client;

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();

    final canEdit = authController.canRegister || authController.canViewAll;
    final canDelete = authController.canDelete;

    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.edit,
            color: canEdit ? TColors.primary : TColors.neutral5,
            size: TFontSizes.xl,
          ),
          onPressed: canEdit ? () => context.push('/home/clients/${client.id}') : null,
          tooltip: 'Editar',
        ),
        IconButton(
          icon: Icon(
            Icons.delete,
            color: canDelete ? TColors.error : TColors.neutral5,
            size: TFontSizes.xl,
          ),
          onPressed: canDelete
              ? () => showDeleteClientDialog(
                  context: context,
                  clientId: client.id,
                  clientName: client.name,
                )
              : null,
          tooltip: 'Excluir',
        ),
      ],
    );
  }
}
