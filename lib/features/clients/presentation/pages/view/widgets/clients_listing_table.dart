import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/theme/tokens/tokens.dart';
import '../../../../../../core/widgets/responsive_layout.dart';
import '../../../../../../core/widgets/t_async_loader_layout.dart';
import '../../../../../../core/widgets/t_card_list.dart';
import '../../../../../../core/widgets/t_data_table.dart';
import '../../../controllers/clients_controller.dart';
import 'clients_action_buttons.dart';

class ClientsListingTable extends StatelessWidget {
  const ClientsListingTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ClientsController>();

    return TAsyncLoaderLayout(
      isLoading: controller.loading,
      errorMsg: controller.errorMsg,
      refresh: controller.fetch,
      itemsCount: controller.items.length,
      child: ResponsiveLayout(
        mobile: TCardList(
          items: controller.items,
          itemBuilder: (_, c) => Card(
            color: TColors.background,
            margin: const EdgeInsets.symmetric(
              horizontal: TSpacing.sm,
              vertical: TSpacing.xs,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(TRadius.md),
            ),
            child: Padding(
              padding: const EdgeInsets.all(TSpacing.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.corporateReason,
                        style: TTypography.interBold(
                          fontSize: TFontSizes.md,
                          color: TColors.neutral9,
                        ),
                      ),
                      const SizedBox(height: TSpacing.xs),
                      Text(
                        'CNPJ: ${c.cnpj}',
                        style: TTypography.interRegular(
                          color: TColors.neutral7,
                          fontSize: TFontSizes.sm,
                        ),
                      ),
                      Text(
                        'Nome na fachada: ${c.name}',
                        style: TTypography.interRegular(
                          color: TColors.neutral7,
                          fontSize: TFontSizes.sm,
                        ),
                      ),
                      Text(
                        'Status: ${c.status.value}',
                        style: TTypography.interRegular(
                          color: TColors.neutral7,
                          fontSize: TFontSizes.sm,
                        ),
                      ),
                      Text(
                        'Conecta Plus: ${c.conectarPlus ? 'Sim' : 'Não'}',
                        style: TTypography.interRegular(
                          color: TColors.neutral7,
                          fontSize: TFontSizes.sm,
                        ),
                      ),
                      Text(
                        'Criado em: ${c.createdAtFormatted}',
                        style: TTypography.interRegular(
                          color: TColors.neutral7,
                          fontSize: TFontSizes.sm,
                        ),
                      ),
                    ],
                  ),
                  ClientsActionButtons(client: c),
                ],
              ),
            ),
          ),
        ),
        desktop: SingleChildScrollView(
          child: TDataTable(
            columns: const [
              DataColumn(label: Text('Razão social')),
              DataColumn(label: Text('CNPJ')),
              DataColumn(label: Text('Nome na fachada')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Conecta Plus')),
              DataColumn(label: Text('Criado em')),
              DataColumn(label: Text('Ações')),
            ],
            rows: controller.items.map((c) {
              return DataRow(
                cells: [
                  DataCell(Text(c.corporateReason)),
                  DataCell(Text(c.cnpj)),
                  DataCell(Text(c.name)),
                  DataCell(Text(c.status.value)),
                  DataCell(Text(c.conectarPlus ? 'Sim' : 'Não')),
                  DataCell(Text(c.createdAtFormatted)),
                  DataCell(ClientsActionButtons(client: c)),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
