import 'package:age_of_style/features/presentation/views/home.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const HomeScreen();
});
