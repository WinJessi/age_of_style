import 'package:age_of_style/features/data/model/category_model.dart';
import 'package:age_of_style/features/data/model/contestant_model.dart';
import 'package:age_of_style/features/data/model/sub_category_model.dart';
import 'package:dartz/dartz.dart';

import '../../../core/failure/failure.dart';

abstract class MyRepository {
  Future<Either<Failure, List<CategoryModel>>> getCategories();
  Future<Either<Failure, List<SubCategoryModel>>> getSubCategories();
  Future<Either<Failure, List<ContestantModel>>> getContestants();
  Future<Either<Failure, Map<String, DateTime>>> settings();
  Future<Either<Failure, bool>> vote(Map<String, dynamic> map);

  Future<Either<Failure, Map<String, dynamic>>> initPayment(
    Map<String, dynamic> map,
  );
  Future<Either<Failure, bool>> verifyPayment(String ref);
}
