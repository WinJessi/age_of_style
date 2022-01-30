import 'package:age_of_style/core/network/network_info.dart';
import 'package:age_of_style/features/data/datasource/remote_datasource.dart';
import 'package:age_of_style/features/data/model/settings.dart';
import 'package:age_of_style/features/data/model/sub_category_model.dart';
import 'package:age_of_style/features/data/model/contestant_model.dart';
import 'package:age_of_style/features/data/model/category_model.dart';
import 'package:age_of_style/core/failure/failure.dart';
import 'package:age_of_style/features/domain/repositories/my_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class MyRepositoryImpl implements MyRepository {
  MyRepositoryImpl({required this.remoteDatasource, required this.networkInfo});

  final RemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      var response = await remoteDatasource.getCategory();

      if (response['status'] == 'success') {
        var _list = <CategoryModel>[];

        for (var element in (response['data'] as List<dynamic>)) {
          _list.add(CategoryModel.fromJson(element));
        }

        return Right(_list);
      } else {
        return Left(SomethingWentWrong());
      }
    } on DioError catch (e) {
      print(e.response!.data);
      if (e.type == DioErrorType.connectTimeout) return Left(TimeOutError());
      if (e.type == DioErrorType.receiveTimeout) return Left(TimeOutError());
      return Left(SomethingWentWrong());
    } catch (e) {
      print(e);
      return Left(UnexpectedError());
    }
  }

  @override
  Future<Either<Failure, List<ContestantModel>>> getContestants() async {
    try {
      var data = await remoteDatasource.contestants();

      if (data['status'] == 'success') {
        var _list = <ContestantModel>[];

        for (var element in (data['data'] as List<dynamic>)) {
          _list.add(ContestantModel.fromJson(element));
        }

        return Right(_list);
      } else {
        return Left(SomethingWentWrong());
      }
    } on DioError catch (e) {
      print(e.response!.data);
      if (e.type == DioErrorType.connectTimeout) return Left(TimeOutError());
      if (e.type == DioErrorType.receiveTimeout) return Left(TimeOutError());
      return Left(SomethingWentWrong());
    } catch (e) {
      print(e);
      return Left(UnexpectedError());
    }
  }

  @override
  Future<Either<Failure, List<SubCategoryModel>>> getSubCategories() async {
    try {
      var data = await remoteDatasource.getSubCategory();

      if (data['status'] == 'success') {
        var _list = <SubCategoryModel>[];

        for (var element in (data['data'] as List<dynamic>)) {
          _list.add(SubCategoryModel.fromJson(element));
        }

        return Right(_list);
      } else {
        return Left(SomethingWentWrong());
      }
    } on DioError catch (e) {
      print(e.response!.data);
      if (e.type == DioErrorType.connectTimeout) return Left(TimeOutError());
      if (e.type == DioErrorType.receiveTimeout) return Left(TimeOutError());
      return Left(SomethingWentWrong());
    } catch (e) {
      print(e);

      return Left(UnexpectedError());
    }
  }

  @override
  Future<Either<Failure, Map<String, DateTime>>> settings() async {
    try {
      var data = await remoteDatasource.settings();
      var model = SettingsModel.fromJson(data['data']);

      return Right({'start': model.starts, 'end': model.ends});
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) return Left(TimeOutError());
      if (e.type == DioErrorType.receiveTimeout) return Left(TimeOutError());
      return Left(SomethingWentWrong());
    } catch (e) {
      return Left(UnexpectedError());
    }
  }

  @override
  Future<Either<Failure, bool>> vote(Map<String, dynamic> map) async {
    try {
      var data = await remoteDatasource.vote(map);

      if (data['status'] == 'success') {
        return const Right(true);
      } else {
        return Left(SomethingWentWrong());
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) return Left(TimeOutError());
      if (e.type == DioErrorType.receiveTimeout) return Left(TimeOutError());
      return Left(SomethingWentWrong());
    } catch (e) {
      return Left(UnexpectedError());
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> initPayment(
    Map<String, dynamic> map,
  ) async {
    try {
      print('here');
      var data = await remoteDatasource.initPayment(map);

      print(data);

      if (data['status'] == true) {
        return Right(data['data']);
      } else {
        return Left(SomethingWentWrong());
      }
    } on DioError catch (e) {
      print(e.response!.data);
      print(e.response!.statusCode);
      if (e.type == DioErrorType.connectTimeout) return Left(TimeOutError());
      if (e.type == DioErrorType.receiveTimeout) return Left(TimeOutError());
      return Left(SomethingWentWrong());
    } catch (e) {
      print(e);
      return Left(UnexpectedError());
    }
  }

  @override
  Future<Either<Failure, bool>> verifyPayment(String ref) async {
    try {
      var data = await remoteDatasource.verifyPayment(ref);

      if (data['data']['status'] == 'success') {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) return Left(TimeOutError());
      if (e.type == DioErrorType.receiveTimeout) return Left(TimeOutError());
      return Left(SomethingWentWrong());
    } catch (e) {
      print(e);
      return Left(UnexpectedError());
    }
  }
}
