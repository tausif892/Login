import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:login/controller/language_change_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:login/login.dart'; // Import your Login screen

class LangChange extends StatefulWidget {
  const LangChange({super.key});

  @override
  State<LangChange> createState() => _LangChangeState();
}

class _LangChangeState extends State<LangChange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            AppLocalizations.of(context)!.app_title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(255, 140, 0, 1.0),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Enter the language",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: Provider.of<LanguageChangeController>(context).appLocale?.languageCode ?? 'en',
              onChanged: (String? newValue) {
                if (newValue != null) {
                  Locale newLocale = Locale(newValue);
                  Provider.of<LanguageChangeController>(context, listen: false).changeLanguage(newLocale);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                }
              },
              items: <String>['en', 'hi', 'ka'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.toUpperCase()),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
