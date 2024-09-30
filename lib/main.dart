import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:login/controller/language_change_controller.dart';
import 'package:login/home_screen.dart';
import 'package:login/lang_change.dart';
import 'package:login/login.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:login/checklists.dart';
import 'package:login/dashboard.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LanguageChangeController languageController = LanguageChangeController();
  await languageController.loadLanguage(); // Load the saved language

  runApp(
    ChangeNotifierProvider(
      create: (_) => languageController,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageChangeController>(
      builder: (context, languageController, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: languageController.appLocale,
          supportedLocales: [
            Locale('en', ''),
            Locale('hi', ''),
            Locale('ka', ''),
          ],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalizations.delegate, // Your localization delegate
          ],
          home:  HomeScreen(),
        );
      },
    );
  }
}