class PaginationParams {
  const PaginationParams({
    this.page = 1,
    this.limit = 20,
    this.orderBy,
    this.order,
  });

  final int page;
  final int limit;
  final String? orderBy;
  final String? order;
}
