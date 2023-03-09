import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:nocoin/constants.dart';
import 'package:nocoin/helpers/numbersHelper.dart';
import 'package:nocoin/models/CryptoModel/CryptoData.dart';
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
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    final cryptoProvider = Provider.of<CryptoDataProvider>(context);
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
                              switch (index) {
                                case 0:
                                  cryptoProvider.getTopMarketCapData();
                                  break;
                                case 1:
                                  cryptoProvider.getTopGainersData();
                                  break;
                                case 2:
                                  cryptoProvider.getTopLosersData();
                                  break;
                              }
                            });
                          }),
                        );
                      }))
                ],
              ),
              Consumer<CryptoDataProvider>(
                builder: (context, value, child) {
                  switch (value.state.status) {
                    case Status.LOADING:
                      return SizedBox(
                        height: 50,
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
                    case Status.COMPLETED:
                      List<CryptoData>? cryptoList =
                          value.dataFuture.data?.cryptoCurrencyList;
                      return ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var tokenId = cryptoList[index].id;
                            MaterialColor filterColor =
                                NumberHelper.setColorFilter(cryptoList[index]
                                    .quotes![0]
                                    .percentChange24h);
                            final price = NumberHelper.removePriceDecimals(
                                cryptoList[index].quotes![0].price);
                            var percentChange =
                                NumberHelper.removePercentDecimals(
                                    cryptoList[index]
                                        .quotes![0]
                                        .percentChange24h);

                            Color percentColor =
                                NumberHelper.setPercentChangesColor(
                                    cryptoList[index]
                                        .quotes![0]
                                        .percentChange24h);
                            Icon percentIcon =
                                NumberHelper.setPercentChangesIcon(
                                    cryptoList[index]
                                        .quotes![0]
                                        .percentChange24h);

                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Text((index + 1).toString(),
                                        style: textTheme.bodySmall),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "https://s2.coinmarketcap.com/static/img/coins/32x32/$tokenId.png",
                                        fadeInDuration:
                                            const Duration(milliseconds: 500),
                                        height: 32,
                                        width: 32,
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(
                                                Icons.error_outline_outlined,
                                                color: Colors.red),
                                      ),
                                    ),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cryptoList[index].name!,
                                            style: textTheme.bodySmall,
                                          ),
                                          Text(
                                            cryptoList[index].symbol!,
                                            style: textTheme.labelSmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                              filterColor, BlendMode.srcATop),
                                          child: SvgPicture.network(
                                              "https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$tokenId.svg")),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "\$$price",
                                              style: textTheme.bodySmall,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                percentIcon,
                                                Text(
                                                  "$percentChange%",
                                                  style: GoogleFonts.ubuntu(
                                                      color: percentColor,
                                                      fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: cryptoList!.length);
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
