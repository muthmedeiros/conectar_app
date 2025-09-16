import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/enums/order_direction.dart';
import '../../../../../../core/theme/tokens/colors.dart';
import '../../../../../../core/theme/tokens/font_sizes.dart';
import '../../../../../../core/theme/tokens/radius.dart';
import '../../../../../../core/theme/tokens/spacing.dart';
import '../../../../../../core/theme/tokens/typography.dart';
import '../../../../domain/enums/client_order_by.dart';
import '../../../../domain/enums/client_status.dart';
import '../../../controllers/clients_controller.dart';

class ClientsFilterSection extends StatefulWidget {
  const ClientsFilterSection({super.key});

  @override
  State<ClientsFilterSection> createState() => _ClientsFilterSectionState();
}

class _ClientsFilterSectionState extends State<ClientsFilterSection> {
  final _textSearchController = TextEditingController();

  bool _hasFilters(ClientsController controller) {
    return (controller.search?.isNotEmpty ?? false) ||
        controller.status != null ||
        controller.conectarPlus != null ||
        controller.orderBy != ClientOrderBy.createdAt ||
        controller.order != OrderDirection.desc;
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ClientsController>();
    final hasFilters = _hasFilters(controller);

    return Card(
      margin: const EdgeInsets.all(TSpacing.md),
      color: TColors.neutral3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TRadius.md)),
      child: Padding(
        padding: const EdgeInsets.all(TSpacing.lg),
        child: ExpansionTile(
          initiallyExpanded: true,
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          backgroundColor: TColors.neutral3,
          collapsedBackgroundColor: TColors.neutral3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TRadius.md)),
          title: Row(
            children: [
              const Icon(Icons.search, color: TColors.primary),
              const SizedBox(width: TSpacing.sm),
              Text(
                'Filtros',
                style: TTypography.interSemiBold(
                  color: TColors.neutral100,
                  fontSize: TFontSizes.md,
                ),
              ),
              const SizedBox(width: TSpacing.sm),
              Text(
                'Filtre e busque os clientes',
                style: TTypography.interRegular(color: TColors.neutral6, fontSize: TFontSizes.sm),
              ),
              const Spacer(),
              Visibility(
                visible: hasFilters,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: TColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(TRadius.sm),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.filter_alt, color: TColors.primary, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        'Filtros ativos',
                        style: TTypography.interSemiBold(
                          color: TColors.primary,
                          fontSize: TFontSizes.sm,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          children: [
            const SizedBox(height: TSpacing.lg),
            Wrap(
              spacing: TSpacing.lg,
              runSpacing: TSpacing.md,
              alignment: WrapAlignment.center,
              children: [
                SizedBox(
                  width: 240,
                  child: TextField(
                    controller: _textSearchController,
                    decoration: const InputDecoration(labelText: 'Buscar por nome ou CNPJ'),
                    onChanged: controller.setSearch,
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: DropdownButtonFormField<ClientStatus?>(
                    decoration: const InputDecoration(labelText: 'Buscar por status'),
                    value: controller.status,
                    items: ClientStatus.values
                        .map((s) => DropdownMenuItem(value: s, child: Text(s.label)))
                        .toList(),
                    onChanged: controller.setStatus,
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: DropdownButtonFormField<bool?>(
                    decoration: const InputDecoration(labelText: 'Buscar por conectar+'),
                    value: controller.conectarPlus,
                    items: const [
                      DropdownMenuItem(child: Text('Selecione')),
                      DropdownMenuItem(value: true, child: Text('Sim')),
                      DropdownMenuItem(value: false, child: Text('Não')),
                    ],
                    onChanged: controller.setConectarPlus,
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: DropdownButtonFormField<ClientOrderBy?>(
                    decoration: const InputDecoration(labelText: 'Ordenar por'),
                    value: controller.orderBy,
                    items: ClientOrderBy.values
                        .map((o) => DropdownMenuItem(value: o, child: Text(o.label)))
                        .toList(),
                    onChanged: controller.setOrderBy,
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: DropdownButtonFormField<OrderDirection?>(
                    decoration: const InputDecoration(labelText: 'Direção'),
                    value: controller.order,
                    items: OrderDirection.values
                        .map((d) => DropdownMenuItem(value: d, child: Text(d.value)))
                        .toList(),
                    onChanged: controller.setOrder,
                  ),
                ),
              ],
            ),
            const SizedBox(height: TSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: TColors.neutral0,
                    backgroundColor: TColors.primary,
                  ),
                  onPressed: () {
                    _textSearchController.clear();
                    controller.clearFilters();
                  },
                  child: const Text('Limpar campos'),
                ),
                const SizedBox(width: TSpacing.sm),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
                    foregroundColor: TColors.neutral0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(TRadius.sm)),
                  ),
                  onPressed: controller.fetch,
                  child: const Text('Filtrar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
