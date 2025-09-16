import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/theme/tokens/spacing.dart';
import '../../../controllers/clients_controller.dart';

class ClientsPaginationFilterSection extends StatelessWidget {
  const ClientsPaginationFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ClientsController>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text('Itens por página:'),
        const SizedBox(width: TSpacing.sm),
        DropdownButton<int>(
          value: controller.limit,
          items: const [
            10,
            20,
            50,
            100,
          ].map((v) => DropdownMenuItem(value: v, child: Text('$v'))).toList(),
          onChanged: (v) {
            if (v != null) {
              controller.setLimit(v);
              controller.fetch();
            }
          },
        ),
        const SizedBox(width: TSpacing.lg),
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: controller.page > 1
              ? () {
                  controller.setPage(controller.page - 1);
                  controller.fetch();
                }
              : null,
        ),
        Text('Página ${controller.page}'),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: controller.totalPages > controller.page
              ? () {
                  controller.setPage(controller.page + 1);
                  controller.fetch();
                }
              : null,
        ),
      ],
    );
  }
}
