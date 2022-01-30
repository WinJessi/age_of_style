import 'package:age_of_style/core/usecases/usecases.dart';
import 'package:age_of_style/features/domain/repositories/my_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../core/failure/failure.dart';
import '../../data/model/sub_category_model.dart';

class GetSubCategoryUsecase extends Usecase<void, NoParams> {
  GetSubCategoryUsecase({
    required this.repository,
  });

  final MyRepository repository;

  @override
  Future<Either<Failure, List<SubCategoryModel>>> call(NoParams params) async =>
      await repository.getSubCategories();
}
