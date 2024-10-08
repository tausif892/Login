import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:login/controller/language_change_controller.dart';
import 'package:login/lang_change.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:login/painscale.dart' ;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LanguageChangeController languageController = LanguageChangeController();
  await languageController.loadLanguage(); // Load the saved language

  runApp(
    ChangeNotifierProvider(
      create: (_) => languageController,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageChangeController>(
      builder: (context, languageController, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: languageController.appLocale,
          supportedLocales: const [
            Locale('en', ''),
            Locale('hi', ''),
            Locale('ka', ''),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalizations.delegate, // Your localization delegate
          ],
          home: LangChange(),
        );
      },
    );
  }
}