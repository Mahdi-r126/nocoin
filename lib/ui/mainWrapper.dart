import 'package:flutter/material.dart';
import 'package:nocoin/ui/ui_helper/BottomNav.dart';
import 'package:nocoin/ui/ui_helper/homePage.dart';
import 'package:nocoin/ui/ui_helper/marketView.dart';
import 'package:nocoin/ui/ui_helper/profilePage.dart';
import 'package:nocoin/ui/ui_helper/watchList.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.compare_arrows_outlined,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNav(controller: controller),
      body: PageView(
        controller: controller,
        children: const [
          HomePage(),
          MarketView(),
          WatchListPage(),
          ProfilePage()
        ],
      ),
    );
  }
}
