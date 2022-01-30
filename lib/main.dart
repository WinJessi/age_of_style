import 'package:age_of_style/config/theme/theme.dart';
import 'package:age_of_style/injector.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'config/routes/route.dart';
import 'config/routes/route_config.dart';
import 'features/presentation/change-notifier/my_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init().then((value) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: getIt<MyNotifier>()),
      ],
      child: OverlaySupport.global(
        child: MaterialApp(
          title: 'Age of Style',
          theme: theme(context),
          builder: (context, widget) => ResponsiveWrapper.builder(
            widget,
            maxWidth: 1200,
            minWidth: 480,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(480, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
            ],
            background: Container(color: Colors.black),
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Application.router.generator,
        ),
      ),
    );
  }
}
