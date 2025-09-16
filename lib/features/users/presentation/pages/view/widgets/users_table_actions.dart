import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/theme/tokens/colors.dart';
import '../../../../../../core/theme/tokens/font_sizes.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../controllers/users_controller.dart';
import 'delete_user_dialog.dart';

class UsersTableActions extends StatelessWidget {
  const UsersTableActions({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UsersController>();

    final canEdit = controller.canEditUser(user);
    final canDelete = controller.canDeleteUser(user);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            Icons.edit,
            color: canEdit ? TColors.primary : TColors.neutral5,
            size: TFontSizes.xl,
          ),
          onPressed: canEdit
              ? () => context.push('/home/users/${user.id}')
              : null,
          tooltip: 'Editar',
        ),
        IconButton(
          icon: Icon(
            Icons.delete,
            color: canDelete ? TColors.error : TColors.neutral5,
            size: TFontSizes.xl,
          ),
          onPressed: canDelete
              ? () => showDeleteUserDialog(
                  context: context,
                  userId: user.id,
                  userName: user.name,
                )
              : null,
          tooltip: 'Excluir',
        ),
      ],
    );
  }
}
