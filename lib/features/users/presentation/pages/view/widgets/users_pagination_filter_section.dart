import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/widgets/t_pagination_footer.dart';
import '../../../controllers/users_controller.dart';

class UsersPaginationFilterSection extends StatelessWidget {
  const UsersPaginationFilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UsersController>();

    return TPaginationFooter(
      limit: controller.limit,
      setLimit: controller.setLimit,
      page: controller.page,
      setPage: controller.setPage,
      totalPages: controller.totalPages,
      fetch: controller.fetch,
    );
  }
}
