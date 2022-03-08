import 'dart:math';

import 'package:age_of_style/core/failure/failure.dart';
import 'package:age_of_style/core/usecases/usecases.dart';
import 'package:age_of_style/features/data/model/category_model.dart';
import 'package:age_of_style/features/data/model/contestant_model.dart';
import 'package:age_of_style/features/data/model/sub_category_model.dart';
import 'package:age_of_style/features/domain/usecases/get_category.dart';
import 'package:age_of_style/features/domain/usecases/get_contestants.dart';
import 'package:age_of_style/features/domain/usecases/get_sub.dart';
import 'package:age_of_style/features/domain/usecases/init_payment.dart';
import 'package:age_of_style/features/domain/usecases/save_voters.dart';
import 'package:age_of_style/features/domain/usecases/settings.dart';
import 'package:age_of_style/features/domain/usecases/verify_payment.dart';
import 'package:age_of_style/features/domain/usecases/vote.dart';
import 'package:confetti/confetti.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

class MyNotifier with ChangeNotifier {
  MyNotifier({
    required this.categoryUsecase,
    required this.subCategoryUsecase,
    required this.contestantsUsecase,
    required this.settingsUsecase,
    required this.voteUsecase,
    required this.initPaymentUsecase,
    required this.verifyPaymentUsecase,
    required this.saveVotersUsecase,
  });

  final GetCategoryUsecase categoryUsecase;
  final GetSubCategoryUsecase subCategoryUsecase;
  final GetContestantsUsecase contestantsUsecase;
  final VoteUsecase voteUsecase;
  final SettingsUsecase settingsUsecase;
  final InitPaymentUsecase initPaymentUsecase;
  final VerifyPaymentUsecase verifyPaymentUsecase;
  final SaveVotersUsecase saveVotersUsecase;

  var _current = 0;

  int get current => _current;

  set current(int i) {
    _current = i;

    _selectedSubCategory.clear();

    _subCategory = [..._allSubCategory]
        .where((element) => element.categoryID == _categories[i].id)
        .toList();

    _contestants = [..._allContestants]
        .where((e) => e.categoryID == _categories[i].id)
        .toList();

    _selectedContestant.clear();

    notifyListeners();
  }

  Future<void> defaultFiltering() async {
    _subCategory = [..._allSubCategory]
        .where((element) => element.categoryID == _categories[_current].id)
        .toList();

    _contestants = [..._allContestants]
        .where((e) => e.categoryID == _categories[_current].id)
        .toList();
  }

  //! Categories
  var _categories = <CategoryModel>[];
  final _allCategories = <int, Widget>{};

  Map<int, Widget> get categories => _allCategories;
  List<CategoryModel> get cat => _categories;

  Future<Either<String, bool>> getCategories() async {
    var data = await categoryUsecase.call(const NoParams());

    return data.fold(
      (l) => Left(FailureToString.mapFailureToMessage(l)),
      (r) {
        _categories = r;

        for (var i = 0; i < _categories.length; i++) {
          _allCategories.putIfAbsent(i, () => Text(_categories[i].category));
        }

        notifyListeners();
        return const Right(true);
      },
    );
  }

  Map<String, DateTime> _date = {};

  Map<String, DateTime> get date => _date;

  Future<Either<String, Map<String, DateTime>>> getSettings() async {
    var data = await settingsUsecase.call(const NoParams());

    return data.fold(
      (l) => Left(FailureToString.mapFailureToMessage(l)),
      (r) {
        _date = r;

        notifyListeners();
        return Right(r);
      },
    );
  }

  //? Search
  var _onSearch = false;

  bool get onSearch => _onSearch;

  void onToggleSearch() {
    _onSearch = !_onSearch;

    notifyListeners();
  }

  //! Sub categories
  List<SubCategoryModel> _allSubCategory = [];
  List<SubCategoryModel> _subCategory = [];
  final List<SubCategoryModel> _selectedSubCategory = [];

  List<SubCategoryModel> get selectedSubCategory => _selectedSubCategory;
  List<SubCategoryModel> get subCategory => _subCategory;

  void selectSubCategory(SubCategoryModel category) {
    _selectedSubCategory.add(category);

    _contestants = [..._allContestants]
        .where((element) =>
            element.categoryID == category.categoryID &&
            element.subCategoryID == category.id)
        .toList();

    notifyListeners();
  }

  Future<Either<String, bool>> getSubCategories() async {
    var data = await subCategoryUsecase.call(const NoParams());

    return data.fold(
      (l) => Left(FailureToString.mapFailureToMessage(l)),
      (r) {
        _allSubCategory = _subCategory = r;

        notifyListeners();
        return const Right(true);
      },
    );
  }

  var _contestants = <ContestantModel>[];
  var _allContestants = <ContestantModel>[];

  List<ContestantModel> get contestants => _contestants;

  //! Contestants
  Future<Either<String, bool>> getContestants() async {
    var data = await contestantsUsecase.call(const NoParams());

    return data.fold(
      (l) => Left(FailureToString.mapFailureToMessage(l)),
      (r) {
        _allContestants = _contestants = r;

        notifyListeners();
        return const Right(true);
      },
    );
  }

  void filterBySubCategory(SubCategoryModel model) {
    _selectedSubCategory.add(model);

    _contestants = [..._allContestants]
        .where((element) =>
            element.categoryID == model.categoryID &&
            element.subCategoryID == model.id)
        .toList();

    notifyListeners();
  }

  filterProductByTyping(String v) {
    _contestants = [..._allContestants]
        .where((element) =>
            element.categoryID == _categories[_current].id &&
            element.name.toLowerCase().contains(v.toLowerCase()))
        .toList();

    notifyListeners();
  }

  //! Voting
  var _howMany = 0;

  int get howMany => _howMany;

  void resetCount() => _howMany = 0;

  void increase() {
    _howMany += 1;

    notifyListeners();
  }

  void decrease() {
    _howMany -= 1;

    notifyListeners();
  }

  final _selectedContestant = <ContestantModel>[];

  List<ContestantModel> get selectedContestant => _selectedContestant;

  void setSelectedContestant(ContestantModel data) {
    _selectedContestant.clear();
    _selectedContestant.add(data);

    notifyListeners();
  }

  final ConfettiController _controller = ConfettiController(
    duration: const Duration(seconds: 10),
  );

  ConfettiController get controller => _controller;

  void congrats() {
    _controller.play();

    notifyListeners();
  }

  Future<Either<String, bool>> vote(int count) async {
    var data = {ContestantMap.id: _selectedContestant.last.id, 'count': count};

    var response = await voteUsecase.call(data);
    return response.fold(
      (l) => Left(FailureToString.mapFailureToMessage(l)),
      (r) => Right(r),
    );
  }

  //? Crdeit card
  final _card = {
    'card': '',
    'cvv': '',
    'exp': '',
    'name': '',
  };

  Map<String, String> get card => _card;

  void setCard(var key, var value) {
    _card.update(key, (_) => value);

    notifyListeners();
  }

  Map<String, dynamic> _response = {};

  Map<String, dynamic> get response => _response;

  Future<Either<String, Map<String, dynamic>>> initPayemnt(int amount) async {
    var _data = {
      'amount': '${(20 * amount * 100)}',
      'email': '${getRandomString(12)}@gmail.com',
    };

    var res = await initPaymentUsecase.call(_data);

    return res.fold(
      (l) => Left(FailureToString.mapFailureToMessage(l)),
      (r) async {
        print(r);

        await saveVotersUsecase.call({
          'reference': r['reference'],
          'voted': _selectedContestant.last.id,
          'how_many': '$amount',
        });

        _response = r;

        notifyListeners();

        return Right(r);
      },
    );
  }

  Future<Either<String, bool>> verifyPayment() async {
    var data = await verifyPaymentUsecase.call(_response['reference']);

    return data.fold(
      (l) {
        _response.clear();

        return Left(FailureToString.mapFailureToMessage(l));
      },
      (r) {
        _response.clear();

        print('verified placing $howMany votes');

        return Right(r);
      },
    );
  }

  var _isLoading = false;

  bool get isLoading => _isLoading;

  void setIsLoading() {
    _isLoading = !_isLoading;

    notifyListeners();
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
final Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
