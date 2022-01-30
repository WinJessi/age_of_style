import 'package:age_of_style/core/usecases/usecases.dart';
import 'package:age_of_style/features/domain/repositories/my_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../core/failure/failure.dart';

class VerifyPaymentUsecase extends Usecase<void, String> {
  VerifyPaymentUsecase({
    required this.repository,
  });

  final MyRepository repository;

  @override
  Future<Either<Failure, bool>> call(String params) async =>
      await repository.verifyPayment(params);
}
