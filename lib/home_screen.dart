import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:login/controller/language_change_controller.dart';
import 'package:provider/provider.dart';
import 'package:login/login.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum Language { english, hindi, kannada }

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(AppLocalizations.of(context)!.app_title), // Use the correct localized string key
        ),
        backgroundColor: const Color.fromRGBO(255, 140, 0, 1.0),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: Center(
              child: DropDownButtonExample(),
            ),
          ),
          SizedBox(
            height: 50,
            child: Center(
              child:  ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login())
                  );
                },
                child: Icon(Icons.arrow_circle_right_sharp),
              ),
            ),
          ),
        ],
      ),

    );
  }
}

class DropDownButtonExample extends StatefulWidget {
  const DropDownButtonExample({super.key});

  @override
  State<DropDownButtonExample> createState() => _DropDownButtonExampleState();
}

class _DropDownButtonExampleState extends State<DropDownButtonExample> {
  Language dropDownValue = Language.english;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Language>(
      value: dropDownValue,
      items: Language.values.map((Language language) {
        return DropdownMenuItem<Language>(
          value: language,
          child: Text(language.name.toUpperCase()), // Convert the enum name to uppercase
        );
      }).toList(),
      onChanged: (Language? newValue) {
        if (newValue != null) {
          setState(() {
            dropDownValue = newValue;
          });
          Provider.of<LanguageChangeController>(context, listen: false)
              .changeLanguage(Locale(newValue.name.substring(0, 2))); // Change language based on selected value
        }
      },
    );
  }
}