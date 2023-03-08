import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nocoin/providers/themeProvider.dart';
import 'package:nocoin/ui/mainWrapper.dart';
import 'package:nocoin/ui/ui_helper/themeSwitcher.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('fa'), // persian
        ],
        locale: const Locale("en", ''),
        themeMode: themeProvider.themeMode,
        darkTheme: MyThemes.darkTheme,
        theme: MyThemes.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const Directionality(
          textDirection: TextDirection.ltr,
          child: Scaffold(
            body: MainWrapper(),
          ),
        ),
      );
    });
  }
}
