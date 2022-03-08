import 'package:age_of_style/features/domain/entity/contestant_entity.dart';

class ContestantModel extends ContestantEntity {
  ContestantModel({
    required int id,
    required int categoryID,
    required int subCategoryID,
    required String photo,
    required String name,
    required String description,
    required String category,
    required String subcategory,
  }) : super(
          id: id,
          categoryID: categoryID,
          subCategoryID: subCategoryID,
          photo: photo,
          name: name,
          description: description,
          category: category,
          subcategory: subcategory,
        );

  factory ContestantModel.fromJson(Map<String, dynamic> map) {
    return ContestantModel(
        id: map[ContestantMap.id],
        categoryID: map[ContestantMap.category],
        subCategoryID: map[ContestantMap.subCategory],
        photo: map[ContestantMap.photo],
        name: map[ContestantMap.name],
        description: map[ContestantMap.description],
        category: map['category'],
        subcategory: map['sub_category']);
  }
}

class ContestantMap {
  static String id = 'id';
  static String category = 'category_id';
  static String subCategory = 'sub_category_id';
  static String photo = 'photo';
  static String name = 'name';
  static String description = 'description';
}
