import 'package:age_of_style/features/domain/entity/sub_category_entity.dart';

class SubCategoryModel extends SubCategoryEntity {
  SubCategoryModel({
    required int id,
    required categoryID,
    required String subCategory,
  }) : super(id: id, categoryID: categoryID, subCategory: subCategory);

  factory SubCategoryModel.fromJson(Map<String, dynamic> element) {
    return SubCategoryModel(
      id: element[SubCategoryMap.id],
      categoryID: element[SubCategoryMap.category],
      subCategory: element[SubCategoryMap.subCategory],
    );
  }
}

class SubCategoryMap {
  static const id = 'id';
  static const category = 'category_id';
  static const subCategory = 'sub_category';
}
