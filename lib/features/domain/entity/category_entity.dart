class CategoryEntity {
  final int id;
  final String category;
  final String photo;
  final DateTime starts;
  final DateTime ends;

  CategoryEntity({
    required this.id,
    required this.category,
    required this.photo,
    required this.starts,
    required this.ends,
  });
}
