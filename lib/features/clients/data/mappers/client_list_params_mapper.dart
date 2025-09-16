import '../../domain/entities/client_query_params.dart';

class ClientListParamsMapper {
  static Map<String, dynamic> toQueryParameters(ClientQueryParams params) {
    return params.toQueryParameters();
  }
}
