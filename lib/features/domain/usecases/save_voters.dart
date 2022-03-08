import 'package:age_of_style/core/usecases/usecases.dart';
import 'package:age_of_style/features/domain/repositories/my_repo.dart';

class SaveVotersUsecase extends Usecase<void, Map> {
  SaveVotersUsecase({
    required this.repository,
  });

  final MyRepository repository;

  @override
  Future<void> call(Map params) async => repository.saveVoter(params);
}
