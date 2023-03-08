import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:nocoin/constants.dart';
import 'package:nocoin/providers/cryptoDataProvider.dart';
import 'package:nocoin/ui/ui_helper/themeSwitcher.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../network/responseModel.dart';
import 'HomePageView.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageViewController = PageController(
    initialPage: 0,
  );

  var defaultChoiceIndex = 0;
  List<String> chicesList = ["Top MarketCaps", 'Top Gainers', 'Top Losers'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final cryptoProvider =
        Provider.of<CryptoDataProvider>(context, listen: false)
            .getTopMarketCapData();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        actions: const [ThemeSwitcher()],
        title: const Text("Nocoin"),
        titleTextStyle: textTheme.titleLarge,
        centerTitle: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 5, right: 5),
                child: SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      HomePageView(controller: _pageViewController),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: SmoothPageIndicator(
                            controller: _pageViewController,
                            count: 4,
                            effect: const ExpandingDotsEffect(
                                dotWidth: 10, dotHeight: 10),
                            onDotClicked: (index) =>
                                _pageViewController.animateToPage(index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                width: double.infinity,
                child: Marquee(
                  text: Constant.news,
                  style: textTheme.bodySmall,
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  blankSpace: 10.0,
                  velocity: 100.0,
                  accelerationDuration: const Duration(seconds: 0),
                  accelerationCurve: Curves.linear,
                  decelerationDuration: const Duration(milliseconds: 500),
                  decelerationCurve: Curves.easeOut,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                        child: MaterialButton(
                      onPressed: () {},
                      color: Colors.green.shade600,
                      height: 50,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: const Text("Buy"),
                    )),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: MaterialButton(
                      onPressed: () {},
                      color: Colors.red.shade600,
                      height: 50,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: const Text("Sell"),
                    ))
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Wrap(
                      spacing: 4,
                      children: List.generate(chicesList.length, (index) {
                        return ChoiceChip(
                          label: Text(
                            chicesList[index],
                            style: textTheme.titleSmall,
                          ),
                          selected: defaultChoiceIndex == index,
                          selectedColor: Colors.blue,
                          onSelected: ((value) {
                            setState(() {
                              defaultChoiceIndex =
                                  value ? index : defaultChoiceIndex;
                            });
                          }),
                        );
                      }))
                ],
              ),
              Consumer<CryptoDataProvider>(
                builder: (context, value, child) {
                  switch (value.state.status) {
                    case Status.COMPLETED:
                      return SizedBox(
                        height: 500,
                        child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade400,
                            highlightColor: Colors.white,
                            child: ListView.builder(
                                itemCount: 10,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 8.0, bottom: 8, left: 8),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 20,
                                          child: Icon(Icons.add),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8.0, left: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 30,
                                                height: 15,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: SizedBox(
                                                  width: 25,
                                                  height: 15,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: SizedBox(
                                          width: 70,
                                          height: 20,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                width: 50,
                                                height: 15,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: SizedBox(
                                                  width: 25,
                                                  height: 15,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                })),
                      );
                    case Status.LOADING:
                      return Text("done");
                    case Status.ERROR:
                      return Text(value.state.message);
                    default:
                      return Container();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
