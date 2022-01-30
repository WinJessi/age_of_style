import 'package:age_of_style/features/domain/entity/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel(
      {required int id,
      required String category,
      required String photo,
      required DateTime starts,
      required DateTime ends})
      : super(
          id: id,
          category: category,
          photo: photo,
          starts: starts,
          ends: ends,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> map) {
    return CategoryModel(
      id: map[CategoryMap.id],
      category: map[CategoryMap.category],
      photo: map[CategoryMap.photo],
      starts: DateTime.parse(map[CategoryMap.starts]),
      ends: DateTime.parse(map[CategoryMap.ends]),
    );
  }
}

class CategoryMap {
  static const id = 'id';
  static const category = 'category';
  static const photo = 'photo';
  static const starts = 'created_at';
  static const ends = 'updated_at';
}
