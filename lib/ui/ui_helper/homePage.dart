import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:nocoin/constants.dart';
import 'package:nocoin/ui/ui_helper/themeSwitcher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
              )
            ],
          ),
        ),
      ),
    );
  }
}
