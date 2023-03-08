import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  PageController controller;
  BottomNav({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    var iconStyle = Theme.of(context).iconTheme;

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2 - 20,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      controller.animateToPage(0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    icon: const Icon(
                      Icons.home,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      controller.animateToPage(1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    icon: const Icon(
                      Icons.bar_chart,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2 - 20,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      controller.animateToPage(2,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    icon: const Icon(
                      Icons.person,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      controller.animateToPage(3,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                    },
                    icon: const Icon(
                      Icons.bookmark,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
