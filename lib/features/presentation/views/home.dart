import 'dart:math';

import 'package:age_of_style/core/assets/assets.dart';
import 'package:age_of_style/features/presentation/change-notifier/my_notifier.dart';
import 'package:age_of_style/features/presentation/widgets/footer.dart';
import 'package:age_of_style/features/presentation/widgets/header.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([
          Provider.of<MyNotifier>(context, listen: false).getCategories(),
          Provider.of<MyNotifier>(context, listen: false).getSubCategories(),
          Provider.of<MyNotifier>(context, listen: false).getContestants(),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Image.asset(
              kLogo,
              width: double.infinity,
              height: double.maxFinite,
              fit: BoxFit.cover,
            );
          } else {
            return Stack(
              children: [
                Consumer<MyNotifier>(
                  builder: (context, value, child) => SizedBox(
                    child: FadeInImage(
                      placeholder: const AssetImage(kPlaceHolder),
                      fadeInCurve: Curves.easeIn,
                      fadeInDuration: const Duration(milliseconds: 500),
                      fadeOutCurve: Curves.easeOut,
                      image: NetworkImage(
                        value.selectedContestant.isEmpty
                            ? value.cat[value.current].photo
                            : value.selectedContestant.last.photo,
                      ),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.maxFinite,
                    ),
                  ),
                ),
                Container(
                  color: Colors.black54,
                  width: double.infinity,
                  height: double.maxFinite,
                ),
                Consumer<MyNotifier>(
                  builder: (context, value, child) {
                    var start = value.cat[value.current].starts;
                    var end = value.cat[value.current].ends;

                    if (DateTime.now().isBefore(start)) {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: MediaQuery.of(context).size.height * .35,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: const Text(
                            'Voting has not started',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    } else if (DateTime.now().isAtSameMomentAs(start) ||
                        DateTime.now().isAtSameMomentAs(end)) {
                      return const MyFooter();
                    } else if (DateTime.now().isAfter(start) &&
                        DateTime.now().isBefore(end)) {
                      return const MyFooter();
                    } else {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: MediaQuery.of(context).size.height * .35,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: const Text(
                            'Voting has ended',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
                const MyHeader(),
                Align(
                  child: Consumer<MyNotifier>(
                    builder: (context, value, child) => Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        height: double.maxFinite,
                        child: ConfettiWidget(
                          confettiController: value.controller,
                          blastDirectionality: BlastDirectionality.explosive,
                          maxBlastForce: 200,
                          minBlastForce: 100,
                          colors: const [
                            Colors.green,
                            Colors.blue,
                            Colors.pink,
                            Colors.orange,
                            Colors.red,
                            Colors.green,
                            Colors.yellow,
                            Colors.white,
                            Colors.lime,
                          ], // define a custom shape/path.
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
