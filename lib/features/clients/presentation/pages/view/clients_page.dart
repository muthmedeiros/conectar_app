import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/di/service_locator.dart';
import '../../../../../core/theme/tokens/spacing.dart';
import '../../../../auth/presentation/controllers/auth_controller.dart';
import '../../../domain/repositories/client_repository.dart';
import '../../controllers/clients_controller.dart';
import 'widgets/clients_filter_section.dart';
import 'widgets/clients_listing_section.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ClientsController>(
      create: (ctx) => ClientsController(
        repo: sl<ClientRepository>(),
        auth: ctx.read<AuthController>(),
      )..fetch(),
      child: const _ClientsPageContent(),
    );
  }
}

class _ClientsPageContent extends StatelessWidget {
  const _ClientsPageContent();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ClientsFilterSection(),
        SizedBox(height: TSpacing.md),
        Expanded(child: ClientsListingSection()),
      ],
    );
  }
}
