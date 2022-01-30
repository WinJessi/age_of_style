import 'package:age_of_style/core/usecases/usecases.dart';
import 'package:age_of_style/features/domain/repositories/my_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../core/failure/failure.dart';
import '../../data/model/contestant_model.dart';

class GetContestantsUsecase extends Usecase<void, NoParams> {
  GetContestantsUsecase({
    required this.repository,
  });

  final MyRepository repository;

  @override
  Future<Either<Failure, List<ContestantModel>>> call(NoParams params) async =>
      await repository.getContestants();
}
