import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/theme/tokens/spacing.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../domain/repositories/client_repository.dart';
import '../../presentation/controllers/clients_controller.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ClientsController>(
      create: (ctx) =>
          ClientsController(repo: sl<ClientRepository>(), auth: ctx.read<AuthController>())
            ..fetch(),
      child: const _ClientsPageContent(),
    );
  }
}

class _ClientsPageContent extends StatefulWidget {
  const _ClientsPageContent();

  @override
  State<_ClientsPageContent> createState() => _ClientsPageContentState();
}

class _ClientsPageContentState extends State<_ClientsPageContent> {
  final _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ClientsController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clients'),
        actions: [
          Visibility(
            visible: context.watch<AuthController>().isAdmin,
            child: IconButton(
              onPressed: () => Navigator.of(context).pushNamed('/home/clients/new'),
              icon: const Icon(Icons.person_add_alt_1),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(TSpacing.sm),
        child: Column(
          children: [
            TextField(
              controller: _search,
              decoration: InputDecoration(
                hintText: 'Search clients...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => controller.setQuery(_search.text),
                ),
              ),
              onSubmitted: (v) => controller.setQuery(v),
            ),
            SizedBox(height: TSpacing.sm),
            Visibility(visible: controller.loading, child: const LinearProgressIndicator()),
            Visibility(
              visible: controller.errorMsg != null,
              child: Text(controller.errorMsg ?? '', style: const TextStyle(color: Colors.red)),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: controller.items.length,
                separatorBuilder: (_, __) => Divider(height: TSpacing.xs),
                itemBuilder: (_, i) {
                  final c = controller.items[i];
                  return ListTile(
                    title: Text(c.name),
                    subtitle: Text(c.document),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => Navigator.of(context).pushNamed('/home/clients/${c.id}'),
                        ),
                        Visibility(
                          visible: controller.canDelete,
                          child: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: const Text('Confirm Deletion'),
                                  content: Text(
                                    'Are you sure you want to delete client "${c.name}"?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(false),
                                      child: const Text('Cancel'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => Navigator.of(context).pop(true),
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                await controller.deleteClient(c.id);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
