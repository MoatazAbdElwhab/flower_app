class Metadata {
  final int? currentPage;
  final int? totalPages;
  final int? limit;
  final int? totalItems;

  const Metadata({
    this.currentPage,
    this.totalPages,
    this.limit,
    this.totalItems,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        currentPage: json['currentPage'] as int?,
        totalPages: json['totalPages'] as int?,
        limit: json['limit'] as int?,
        totalItems: json['totalItems'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'currentPage': currentPage,
        'totalPages': totalPages,
        'limit': limit,
        'totalItems': totalItems,
      };
}
