import 'package:age_of_style/config/routes/route_config.dart';
import 'package:age_of_style/features/presentation/change-notifier/my_notifier.dart';
import 'package:awesome_card/awesome_card.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:glass/glass.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceVote extends StatefulWidget {
  const PlaceVote({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  State<PlaceVote> createState() => _PlaceVoteState();
}

class _PlaceVoteState extends State<PlaceVote> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(context) {
    return Consumer<MyNotifier>(
      builder: (context, value, child) => Center(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(30),
          padding: const EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30, top: 15),
                  child: Consumer<MyNotifier>(
                    builder: (context, value, child) => CreditCard(
                      cardNumber: value.card['card'],
                      cardExpiry: value.card['exp'],
                      cardHolderName: value.card['cvv'],
                      bankName: "Powered by Paystack",
                      cardType: CardType.masterCard,
                      showBackSide: false,
                      frontBackground: CardBackgrounds.black,
                      backBackground: CardBackgrounds.white,
                      showShadow: true,
                      textExpDate: 'Exp. Date',
                      textName: '',
                      textExpiry: 'MM/YY',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        value.selectedContestant.last.name,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'NGN 20 per Vote',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 30,
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Material(
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () => value.howMany < 1
                                          ? null
                                          : value.response.isNotEmpty
                                              ? null
                                              : value.decrease(),
                                      icon: const Icon(Icons.remove),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    value.howMany.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1!
                                        .copyWith(color: Colors.white),
                                  ),
                                  const SizedBox(width: 15),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: value.response.isNotEmpty
                                          ? null
                                          : () => value.increase(),
                                      icon: const Icon(Icons.add),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 120,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text('NGN ${value.howMany * 20}'),
                            alignment: Alignment.center,
                          )
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: value.howMany < 1
                            ? null
                            : value.response.isEmpty
                                ? () => next(value.howMany)
                                : () => verify(value.howMany),
                        child: Container(
                          width: 150,
                          height: 40,
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 17, 16, 13),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 5,
                                blurRadius: 12,
                              )
                            ],
                          ),
                          alignment: Alignment.center,
                          child: value.isLoading
                              ? const CircularProgressIndicator(strokeWidth: 1)
                              : Text(
                                  value.response.isEmpty ? 'NEXT' : 'CONFIRM',
                                  style: const TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ).asGlass(
            frosted: true,
            tintColor: Colors.white,
            clipBorderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  void next(howMany) async {
    var prov = Provider.of<MyNotifier>(context, listen: false);

    prov.setIsLoading();

    prov.initPayemnt(howMany).then((value) => value.fold(
          (l) => l,
          (r) => launch(r['authorization_url']).then(
            (_) => prov.setIsLoading(),
          ).whenComplete(() => null),
        ));
  }

  void verify(howMany) async {
    var prov = Provider.of<MyNotifier>(context, listen: false);

    prov.setIsLoading();

    prov.verifyPayment().then(
          (value) => value.fold(
            (l) {
              showSimpleNotification(Text(l));
              prov.setIsLoading();
            },
            (r) {
              if (r) {
                prov.vote(howMany).then(
                      (value) => value
                          .fold((l) => showSimpleNotification(Text(l)), (r) {
                        if (r) {
                          Application.router.pop(context);

                          showSimpleNotification(
                            const Text(
                              'Hooray! Voting successful. You can still vote more though',
                            ),
                            duration: const Duration(seconds: 7),
                          );

                          prov.congrats();
                        }
                      }),
                    );
              } else {
                showSimpleNotification(const Text('Payment failed'));
                Application.router.pop(context);
              }

              prov.setIsLoading();
            },
          ),
        );
  }
}

class CardDetails extends StatefulWidget {
  const CardDetails({
    Key? key,
    required this.howMany,
  }) : super(key: key);

  final int howMany;

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  final GlobalKey<FormState> _form = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyNotifier>(
      builder: (context, value, child) => Center(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(30),
          padding: const EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _form,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 5,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Card number',
                          fillColor: Colors.transparent,
                          filled: true,
                          hintStyle: TextStyle(color: Colors.white54),
                        ),
                        keyboardType: TextInputType.number,
                        onSaved: (v) => value.setCard('card', v),
                        validator: (value) {
                          if (value!.isEmpty) return 'Card number is required';
                          if (value.length < 16) {
                            return 'Incomplete card number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 5,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'Exp',
                                fillColor: Colors.transparent,
                                filled: true,
                                hintStyle: TextStyle(color: Colors.white54),
                              ),
                              keyboardType: TextInputType.number,
                              onSaved: (v) => value.setCard('exp', v),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Expiry date is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'CVV',
                                fillColor: Colors.transparent,
                                filled: true,
                                hintStyle: TextStyle(color: Colors.white54),
                              ),
                              keyboardType: TextInputType.number,
                              onSaved: (v) => value.setCard('cvv', v),
                              validator: (value) {
                                if (value!.isEmpty) return 'CVV is required';
                                if (value.length < 3) return 'Incomplete cvv';
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: MaterialButton(
                        color: Colors.black,
                        onPressed: () => process(),
                        child: Text(
                          'CONFIRM',
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).asGlass(
            frosted: true,
            tintColor: Colors.white,
            clipBorderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  void process() async {
    if (!_form.currentState!.validate()) return;
    _form.currentState!.save();

    // Application.router.pop(context);

    var prov = Provider.of<MyNotifier>(context, listen: false);

    prov.initPayemnt(widget.howMany).then((value) => value.fold(
          (l) => l,
          (r) => launch(r['authorization_url']),
        ));

    // prov.vote(widget.howMany).then((value) {
    //   value.fold((l) => l, (r) {
    //     Application.router.pop(context);
    //     prov.congrats();
    //   });
    // });
  }
}
