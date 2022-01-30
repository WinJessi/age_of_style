import 'package:age_of_style/core/usecases/usecases.dart';
import 'package:age_of_style/features/domain/repositories/my_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../core/failure/failure.dart';
import '../../data/model/category_model.dart';

class GetCategoryUsecase extends Usecase<void, NoParams> {
  GetCategoryUsecase({
    required this.repository,
  });

  final MyRepository repository;

  @override
  Future<Either<Failure, List<CategoryModel>>> call(NoParams params) async =>
      await repository.getCategories();
}
