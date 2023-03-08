import 'package:flutter/material.dart';
import 'package:nocoin/providers/themeProvider.dart';
import 'package:provider/provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    var switchIcon =
        Icon(themeProvider.isDarkMode ? Icons.sunny : Icons.dark_mode);

    return IconButton(
      icon: switchIcon,
      onPressed: () {
        themeProvider.toggleTheme();
      },
    );
  }
}
