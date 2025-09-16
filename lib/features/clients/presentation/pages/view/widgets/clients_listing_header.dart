import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/theme/tokens/tokens.dart';
import '../../../controllers/clients_controller.dart';

class ClientsListingHeader extends StatelessWidget {
  const ClientsListingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ClientsController>();

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Clientes (${controller.totalItems})',
                style: TTypography.interSemiBold(
                  color: TColors.neutral100,
                  fontSize: TFontSizes.md,
                ),
              ),
              Text(
                'Selecione um usuário para ver os detalhes',
                style: TTypography.interRegular(
                  color: TColors.neutral6,
                  fontSize: TFontSizes.sm,
                ),
              ),
            ],
          ),
        ),
        OutlinedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(TRadius.xs),
            ),
            side: const BorderSide(),
            backgroundColor: TColors.neutral3,
            padding: const EdgeInsets.symmetric(
              horizontal: TSpacing.xxl,
              vertical: TSpacing.md,
            ),
          ),
          onPressed: () => context.push('/home/clients/new').then((didCreate) {
            if (didCreate == true && context.mounted) {
              controller.fetch();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cliente criado com sucesso!')),
              );
            }
          }),
          child: Text(
            'Novo',
            style: TTypography.interMedium(
              color: TColors.neutral100,
              fontSize: TFontSizes.sm,
            ),
          ),
        ),
      ],
    );
  }
}
