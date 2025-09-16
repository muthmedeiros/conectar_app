import 'package:flutter/material.dart';

import '../theme/tokens/tokens.dart';

class TPaginationFooter extends StatelessWidget {
  const TPaginationFooter({
    super.key,
    required this.limit,
    required this.setLimit,
    required this.page,
    required this.setPage,
    required this.totalPages,
    required this.fetch,
  });

  final int limit;
  final Function(int) setLimit;
  final int page;
  final Function(int) setPage;
  final int totalPages;
  final Function fetch;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text('Itens por página:'),
        const SizedBox(width: TSpacing.sm),
        DropdownButton<int>(
          value: limit,
          items: const [
            10,
            20,
            50,
            100,
          ].map((v) => DropdownMenuItem(value: v, child: Text('$v'))).toList(),
          onChanged: (v) {
            if (v != null) {
              setLimit(v);
              fetch();
            }
          },
        ),
        const SizedBox(width: TSpacing.lg),
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: page > 1
              ? () {
                  setPage(page - 1);
                  fetch();
                }
              : null,
        ),
        Text('Página $page'),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: totalPages > page
              ? () {
                  setPage(page + 1);
                  fetch();
                }
              : null,
        ),
      ],
    );
  }
}
