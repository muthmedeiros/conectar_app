import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/enums/order_direction.dart';
import '../../../../../../core/enums/user_role.dart';
import '../../../../../../core/theme/tokens/colors.dart';
import '../../../../../../core/theme/tokens/font_sizes.dart';
import '../../../../../../core/theme/tokens/radius.dart';
import '../../../../../../core/theme/tokens/spacing.dart';
import '../../../../../../core/theme/tokens/typography.dart';
import '../../../../domain/enums/user_order_by.dart';
import '../../../controllers/users_controller.dart';

class UsersFilterSection extends StatefulWidget {
  const UsersFilterSection({super.key});

  @override
  State<UsersFilterSection> createState() => _UsersFilterSectionState();
}

class _UsersFilterSectionState extends State<UsersFilterSection> {
  final _textSearchController = TextEditingController();

  bool _hasFilters(UsersController controller) {
    return (controller.search?.isNotEmpty ?? false) ||
        controller.role != null ||
        controller.orderBy != UserOrderBy.createdAt ||
        controller.order != OrderDirection.desc;
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UsersController>();
    final hasFilters = _hasFilters(controller);

    return Card(
      margin: const EdgeInsets.all(TSpacing.md),
      color: TColors.neutral3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TRadius.md),
      ),
      child: Padding(
        padding: const EdgeInsets.all(TSpacing.lg),
        child: ExpansionTile(
          initiallyExpanded: true,
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          backgroundColor: TColors.neutral3,
          collapsedBackgroundColor: TColors.neutral3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TRadius.md),
          ),
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
                'Filtre e busque os usuários',
                style: TTypography.interRegular(
                  color: TColors.neutral6,
                  fontSize: TFontSizes.sm,
                ),
              ),
              const Spacer(),
              Visibility(
                visible: hasFilters,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: TColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(TRadius.sm),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.filter_alt,
                        color: TColors.primary,
                        size: 16,
                      ),
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
                  width: 280,
                  child: TextFormField(
                    controller: _textSearchController,
                    onChanged: (value) {
                      controller.setSearch(
                        value.trim().isEmpty ? null : value.trim(),
                      );
                    },
                    decoration: const InputDecoration(
                      labelText: 'Buscar por nome ou email',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                // Role Filter
                SizedBox(
                  width: 200,
                  child: DropdownButtonFormField<UserRole>(
                    value: controller.role,
                    onChanged: controller.setRole,
                    decoration: const InputDecoration(
                      labelText: 'Perfil',
                      prefixIcon: Icon(Icons.person),
                    ),
                    items: UserRole.values.map((role) {
                      return DropdownMenuItem<UserRole>(
                        value: role,
                        child: Text(role.name.toUpperCase()),
                      );
                    }).toList(),
                  ),
                ),
                // Order By
                SizedBox(
                  width: 240,
                  child: DropdownButtonFormField<UserOrderBy>(
                    value: controller.orderBy,
                    onChanged: controller.setOrderBy,
                    decoration: const InputDecoration(
                      labelText: 'Ordernar por',
                      prefixIcon: Icon(Icons.sort),
                    ),
                    items: UserOrderBy.values.map((orderBy) {
                      return DropdownMenuItem<UserOrderBy>(
                        value: orderBy,
                        child: Text(orderBy.label),
                      );
                    }).toList(),
                  ),
                ),
                // Order Direction
                SizedBox(
                  width: 180,
                  child: DropdownButtonFormField<OrderDirection>(
                    value: controller.order,
                    onChanged: controller.setOrder,
                    decoration: const InputDecoration(
                      labelText: 'Direção',
                      prefixIcon: Icon(Icons.swap_vert),
                    ),
                    items: OrderDirection.values.map((order) {
                      return DropdownMenuItem<OrderDirection>(
                        value: order,
                        child: Text(order.label),
                      );
                    }).toList(),
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
                    controller.resetFilters();
                  },
                  child: const Text('Limpar campos'),
                ),
                const SizedBox(width: TSpacing.sm),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primary,
                    foregroundColor: TColors.neutral0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(TRadius.sm),
                    ),
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
