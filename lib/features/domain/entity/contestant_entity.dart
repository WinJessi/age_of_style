class ContestantEntity {
  final int id;
  final int categoryID;
  final int subCategoryID;
  final String photo;
  final String name;
  final String description;

  ContestantEntity({
    required this.id,
    required this.categoryID,
    required this.subCategoryID,
    required this.photo,
    required this.name,
    required this.description,
  });
}
