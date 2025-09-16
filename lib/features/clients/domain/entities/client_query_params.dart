import 'package:equatable/equatable.dart';

import '../../../../core/enums/order_direction.dart';
import '../enums/client_order_by.dart';
import '../enums/client_status.dart';

class ClientQueryParams extends Equatable {
  const ClientQueryParams({
    this.search,
    this.status,
    this.conectarPlus,
    this.orderBy,
    this.order,
    this.page = 1,
    this.limit = 20,
  });

  final String? search;
  final ClientStatus? status;
  final bool? conectarPlus;
  final ClientOrderBy? orderBy;
  final OrderDirection? order;
  final int page;
  final int limit;

  Map<String, dynamic> toQueryParameters() {
    return {
      if (search != null) 'search': search,
      if (status != null) 'status': status!.value,
      if (conectarPlus != null) 'conectarPlus': conectarPlus,
      if (orderBy != null) 'orderBy': orderBy!.value,
      if (order != null) 'order': order!.value,
      'page': page,
      'limit': limit,
    };
  }

  @override
  List<Object?> get props => [
    search,
    status,
    conectarPlus,
    orderBy,
    order,
    page,
    limit,
  ];
}
