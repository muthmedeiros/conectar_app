import 'package:equatable/equatable.dart';

import '../../../../core/enums/order_direction.dart';
import '../../../../core/enums/user_role.dart';
import '../enums/user_order_by.dart';

class UserQueryParams extends Equatable {
  const UserQueryParams({
    this.search,
    this.role,
    this.orderBy,
    this.order,
    this.page = 1,
    this.limit = 20,
  });

  final String? search;
  final UserRole? role;
  final UserOrderBy? orderBy;
  final OrderDirection? order;
  final int page;
  final int limit;

  UserQueryParams copyWith({
    String? search,
    UserRole? role,
    UserOrderBy? orderBy,
    OrderDirection? order,
    int? page,
    int? limit,
  }) {
    return UserQueryParams(
      search: search ?? this.search,
      role: role ?? this.role,
      orderBy: orderBy ?? this.orderBy,
      order: order ?? this.order,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }

  Map<String, dynamic> toQueryParameters() {
    return {
      if (search != null) 'search': search,
      if (role != null) 'role': role!.value,
      if (orderBy != null) 'orderBy': orderBy!.value,
      if (order != null) 'order': order!.value,
      'page': page,
      'limit': limit,
    };
  }

  @override
  List<Object?> get props => [search, role, orderBy, order, page, limit];
}
