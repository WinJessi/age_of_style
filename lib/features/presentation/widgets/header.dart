import 'package:age_of_style/features/presentation/change-notifier/my_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHeader extends StatelessWidget {
  const MyHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyNotifier>(
      builder: (context, value, child) => Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          child: Container(
            margin: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: .5,
                  blurRadius: 15,
                ),
              ],
            ),
            child: CupertinoSlidingSegmentedControl<int>(
              onValueChanged: (i) => value.current = i!,
              backgroundColor: Colors.grey,
              groupValue: value.current,
              children: value.categories,
            ),
          ),
        ),
      ),
    );
  }
}
