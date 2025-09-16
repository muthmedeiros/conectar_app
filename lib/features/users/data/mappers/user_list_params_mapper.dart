import '../../../../core/enums/order_direction.dart';
import '../../domain/entities/user_query_params.dart';

class UserListParamsMapper {
  static Map<String, dynamic> toMap(UserQueryParams params) {
    final map = <String, dynamic>{};

    if (params.search != null && params.search!.isNotEmpty) {
      map['search'] = params.search;
    }

    if (params.role != null) {
      map['role'] = params.role!.name;
    }

    if (params.orderBy != null) {
      map['orderBy'] = params.orderBy!.value;
    }

    if (params.order != null) {
      map['order'] = params.order == OrderDirection.asc ? 'ASC' : 'DESC';
    }

    map['page'] = params.page;
    map['limit'] = params.limit;

    return map;
  }
}