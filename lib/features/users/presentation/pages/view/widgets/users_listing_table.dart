import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/theme/tokens/tokens.dart';
import '../../../../../../core/widgets/responsive_layout.dart';
import '../../../../../../core/widgets/t_async_loader_layout.dart';
import '../../../../../../core/widgets/t_card_list.dart';
import '../../../../../../core/widgets/t_data_table.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../controllers/users_controller.dart';
import 'users_table_actions.dart';

class UsersListingTable extends StatelessWidget {
  const UsersListingTable({super.key});

  String _getStatusText(UserEntity user) {
    if (user.isInactive) {
      return 'Inativo (30+ dias)';
    }
    return user.lastLogin != null ? 'Ativo' : 'Nunca logou';
  }

  Color _getStatusColor(UserEntity user) {
    if (user.isInactive) {
      return TColors.error;
    }
    return user.lastLogin != null ? TColors.primary : TColors.warning;
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UsersController>();

    return TAsyncLoaderLayout(
      isLoading: controller.loading,
      errorMsg: controller.errorMsg,
      refresh: controller.fetch,
      itemsCount: controller.items.length,
      child: ResponsiveLayout(
        mobile: TCardList(
          items: controller.items,
          itemBuilder: (_, user) => Card(
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: TTypography.interBold(
                            fontSize: TFontSizes.md,
                            color: TColors.neutral9,
                          ),
                        ),
                        const SizedBox(height: TSpacing.xs),
                        Text(
                          'Email: ${user.email}',
                          style: TTypography.interRegular(
                            color: TColors.neutral7,
                            fontSize: TFontSizes.sm,
                          ),
                        ),
                        Text(
                          'Perfil: ${user.role.name.toUpperCase()}',
                          style: TTypography.interRegular(
                            color: TColors.neutral7,
                            fontSize: TFontSizes.sm,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Status: ',
                              style: TTypography.interRegular(
                                color: TColors.neutral7,
                                fontSize: TFontSizes.sm,
                              ),
                            ),
                            Text(
                              _getStatusText(user),
                              style: TTypography.interSemiBold(
                                color: _getStatusColor(user),
                                fontSize: TFontSizes.sm,
                              ),
                            ),
                          ],
                        ),
                        if (user.lastLogin != null)
                          Text(
                            'Último login: ${user.lastLoginFormatted!}',
                            style: TTypography.interRegular(
                              color: TColors.neutral7,
                              fontSize: TFontSizes.sm,
                            ),
                          ),
                        Text(
                          'Criado em: ${user.createdAtFormatted}',
                          style: TTypography.interRegular(
                            color: TColors.neutral7,
                            fontSize: TFontSizes.sm,
                          ),
                        ),
                      ],
                    ),
                  ),
                  UsersTableActions(user: user),
                ],
              ),
            ),
          ),
        ),
        desktop: SingleChildScrollView(
          child: TDataTable(
            columns: const [
              DataColumn(label: Text('Nome')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Perfil')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Último Login')),
              DataColumn(label: Text('Criado em')),
              DataColumn(label: Text('Ações')),
            ],
            rows: controller.items.map((user) {
              return DataRow(
                cells: [
                  DataCell(Text(user.name)),
                  DataCell(Text(user.email)),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: TSpacing.sm,
                        vertical: TSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: user.role.isAdmin
                            ? TColors.secondary
                            : TColors.primary,
                        borderRadius: BorderRadius.circular(TRadius.sm),
                      ),
                      child: Text(
                        user.role.name.toUpperCase(),
                        style: TTypography.interSemiBold(
                          color: TColors.neutral0,
                          fontSize: TFontSizes.xs,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: TSpacing.sm,
                        vertical: TSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(user).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(TRadius.sm),
                      ),
                      child: Text(
                        _getStatusText(user),
                        style: TTypography.interSemiBold(
                          color: _getStatusColor(user),
                          fontSize: TFontSizes.xs,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      user.lastLogin != null
                          ? user.lastLoginFormatted!
                          : 'Nunca',
                    ),
                  ),
                  DataCell(Text(user.createdAtFormatted)),
                  DataCell(UsersTableActions(user: user)),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
