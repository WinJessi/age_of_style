import 'package:age_of_style/core/usecases/usecases.dart';
import 'package:age_of_style/features/domain/repositories/my_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../core/failure/failure.dart';

class VoteUsecase extends Usecase<void, Map<String, dynamic>> {
  VoteUsecase({
    required this.repository,
  });

  final MyRepository repository;

  @override
  Future<Either<Failure, bool>> call(Map<String, dynamic> params) async =>
      await repository.vote(params);
}
