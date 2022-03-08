import 'package:age_of_style/core/network/network_info.dart';
import 'package:age_of_style/features/data/datasource/remote_datasource.dart';
import 'package:age_of_style/features/data/repositories/repo_impl.dart';
import 'package:age_of_style/features/domain/repositories/my_repo.dart';
import 'package:age_of_style/features/domain/usecases/get_category.dart';
import 'package:age_of_style/features/domain/usecases/get_contestants.dart';
import 'package:age_of_style/features/domain/usecases/get_sub.dart';
import 'package:age_of_style/features/domain/usecases/init_payment.dart';
import 'package:age_of_style/features/domain/usecases/save_voters.dart';
import 'package:age_of_style/features/domain/usecases/settings.dart';
import 'package:age_of_style/features/domain/usecases/verify_payment.dart';
import 'package:age_of_style/features/domain/usecases/vote.dart';
import 'package:age_of_style/features/presentation/change-notifier/my_notifier.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

var getIt = GetIt.instance;

Future<void> init() async {
  //? Dio
  var options = BaseOptions(
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  Dio dio = Dio(options);
  getIt.registerLazySingleton<Dio>(() => dio);

  getIt.registerLazySingleton<http.Client>(() => http.Client());

  //? Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  //? Change Notifier
  getIt.registerFactory<MyNotifier>(
    () => MyNotifier(
      categoryUsecase: getIt(),
      contestantsUsecase: getIt(),
      settingsUsecase: getIt(),
      subCategoryUsecase: getIt(),
      voteUsecase: getIt(),
      initPaymentUsecase: getIt(),
      verifyPaymentUsecase: getIt(),
      saveVotersUsecase: getIt(),
    ),
  );

  //? Usecase
  getIt.registerLazySingleton(() => GetCategoryUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => GetSubCategoryUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => GetContestantsUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => SettingsUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => VoteUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => InitPaymentUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => VerifyPaymentUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => SaveVotersUsecase(repository: getIt()));

  //? Repository
  getIt.registerLazySingleton<MyRepository>(
      () => MyRepositoryImpl(remoteDatasource: getIt(), networkInfo: getIt()));

  //? Datasource
  getIt.registerLazySingleton<RemoteDatasource>(
      () => RemoteDatasourceImpl(dio: getIt(), client: getIt()));
}
