import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/theme/tokens/colors.dart';
import '../../../../../../core/theme/tokens/font_sizes.dart';
import '../../../../../../core/theme/tokens/radius.dart';
import '../../../../../../core/theme/tokens/spacing.dart';
import '../../../../../../core/theme/tokens/typography.dart';
import '../../../controllers/clients_controller.dart';
import 'clients_listing_table.dart';
import 'clients_pagination_filter_section.dart';

class ClientsListingSection extends StatelessWidget {
  const ClientsListingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(TSpacing.md),
      color: TColors.neutral3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TRadius.md)),
      child: Padding(
        padding: const EdgeInsets.all(TSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Clientes',
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TRadius.xs)),
                    side: const BorderSide(color: TColors.neutral100),
                    backgroundColor: TColors.neutral3,
                    textStyle: TTypography.interMedium(
                      color: TColors.neutral100,
                      fontSize: TFontSizes.sm,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: TSpacing.lg,
                      vertical: TSpacing.sm,
                    ),
                  ),
                  onPressed: () => context.push('/home/clients/new').then((didCreate) {
                    if (didCreate == true && context.mounted) {
                      context.read<ClientsController>().fetch();
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text('Cliente criado com sucesso!')));
                    }
                  }),
                  child: const Text('Novo'),
                ),
              ],
            ),
            const SizedBox(height: TSpacing.sm),
            const Expanded(child: ClientsListingTable()),
            const SizedBox(height: TSpacing.sm),
            const ClientsPaginationFilterSection(),
          ],
        ),
      ),
    );
  }
}
