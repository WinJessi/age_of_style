import 'package:age_of_style/core/usecases/usecases.dart';
import 'package:age_of_style/features/domain/repositories/my_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../core/failure/failure.dart';

class SettingsUsecase extends Usecase<void, NoParams> {
  SettingsUsecase({
    required this.repository,
  });

  final MyRepository repository;

  @override
  Future<Either<Failure, Map<String, DateTime>>> call(NoParams params) async =>
      await repository.settings();
}
