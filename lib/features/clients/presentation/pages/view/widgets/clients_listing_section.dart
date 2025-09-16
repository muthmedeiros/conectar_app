import 'package:flutter/material.dart';

import '../../../../../../core/theme/tokens/tokens.dart';
import 'clients_listing_header.dart';
import 'clients_listing_table.dart';
import 'clients_pagination_filter_section.dart';

class ClientsListingSection extends StatelessWidget {
  const ClientsListingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(TSpacing.md),
      color: TColors.neutral3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(TRadius.md),
      ),
      child: const Padding(
        padding: EdgeInsets.all(TSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClientsListingHeader(),
            SizedBox(height: TSpacing.sm),
            Expanded(child: ClientsListingTable()),
            SizedBox(height: TSpacing.sm),
            ClientsPaginationFilterSection(),
          ],
        ),
      ),
    );
  }
}
