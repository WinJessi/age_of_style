import 'package:age_of_style/features/data/model/contestant_model.dart';
import 'package:age_of_style/features/presentation/change-notifier/my_notifier.dart';
import 'package:age_of_style/features/presentation/widgets/vote_pop.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyFooter extends StatelessWidget {
  const MyFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<MyNotifier>(context, listen: false).defaultFiltering(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 1),
          );
        } else {
          return Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .35,
              child: Column(
                children: [
                  Consumer<MyNotifier>(
                    builder: (context, value, child) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) =>
                                ScaleTransition(scale: animation, child: child),
                        child: value.onSearch
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    prefixIcon: IconButton(
                                      onPressed: () => value.onToggleSearch(),
                                      icon: const Icon(Icons.close),
                                    ),
                                    hintText: 'My handsom...',
                                  ),
                                  onChanged: (v) =>
                                      value.filterProductByTyping(v),
                                ),
                              )
                            : myPopUpMenuButton(value),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Consumer<MyNotifier>(
                      builder: (context, value, child) => ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (var i = 0; i < value.contestants.length; i++)
                            ContestantTile(contestant: value.contestants[i]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Row myPopUpMenuButton(MyNotifier value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            if (value.categories.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: PopupMenuButton(
                  itemBuilder: (context) => value.subCategory
                      .map((e) => PopupMenuItem(
                            child: Text(e.subCategory),
                            onTap: () => value.filterBySubCategory(e),
                          ))
                      .toList(),
                  child: Row(
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 800),
                        switchInCurve: Curves.easeInExpo,
                        child: Text(
                          value.selectedSubCategory.isEmpty
                              ? 'All'
                              : value.selectedSubCategory.last.subCategory,
                          key: ValueKey(value.selectedSubCategory.isEmpty
                              ? 'All'
                              : value.selectedSubCategory.last.subCategory),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 15),
          ],
        ),
        const Spacer(),
        // IconButton(
        //   padding: EdgeInsets.zero,
        //   onPressed: () => value.onToggleSearch(),
        //   icon: const Icon(
        //     Icons.search,
        //     color: Colors.white,
        //   ),
        // ),
      ],
    );
  }
}

class ContestantTile extends StatelessWidget {
  const ContestantTile({
    Key? key,
    required this.contestant,
  }) : super(key: key);

  final ContestantModel contestant;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var prov = Provider.of<MyNotifier>(context, listen: false);

        prov.setSelectedContestant(contestant);

        Future.delayed(const Duration(seconds: 1)).then(
          (value) => showDialog(
            context: context,
            builder: (context) => PlaceVote(context: context),
          ),
        );
      },
      child: SizedBox(
        width: 170,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          color: Colors.grey,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Column(
              children: [
                Expanded(
                  child: FancyShimmerImage(
                    imageUrl: contestant.photo,
                    boxFit: BoxFit.cover,
                    width: double.infinity,
                    height: double.maxFinite,
                    shimmerHighlightColor: Colors.black54,
                    shimmerBackColor: Colors.grey.shade800,
                    shimmerBaseColor: Colors.grey.shade50,
                    errorWidget: Image.network(
                      'https://aeroclub-issoire.fr/wp-content/uploads/2020/05/image-not-found-300x225.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 30,
                  padding: const EdgeInsets.all(5),
                  color: Colors.white,
                  child: Text(
                    contestant.name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
