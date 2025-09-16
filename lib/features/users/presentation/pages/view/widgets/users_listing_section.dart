import 'package:flutter/material.dart';

import '../../../../../../core/theme/tokens/tokens.dart';
import 'users_listing_header.dart';
import 'users_listing_table.dart';
import 'users_pagination_filter_section.dart';

class UsersListingSection extends StatelessWidget {
  const UsersListingSection({super.key});

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
            UsersListingHeader(),
            SizedBox(height: TSpacing.sm),
            Expanded(child: UsersListingTable()),
            SizedBox(height: TSpacing.sm),
            UsersPaginationFilterSection(),
          ],
        ),
      ),
    );
  }
}
