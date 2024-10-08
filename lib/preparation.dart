import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreparationList extends StatefulWidget {
  const PreparationList({super.key});

  @override
  State<PreparationList> createState() => _PreparationListState();
}

class _PreparationListState extends State<PreparationList> {
  Map<String, bool> values = {};

  Future<void> _loadCheckBoxValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (String key in values.keys) {
      bool? value = prefs.getBool(key);
      if (value != null) {
        values[key] = value;
      }
    }
    setState(() {});
  }

  Future<void> _saveCheckBoxValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (String key in values.keys) {
      await prefs.setBool(key, values[key] ?? false);
    }
  }

  void _resetboxes() {
    setState(() {
      values.updateAll((key, value) => false);
    });
    _saveCheckBoxValues();
  }

  @override
  void initState() {
    super.initState();
    // Delayed initialization to access the context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        values = {
          AppLocalizations.of(context)!.prep_ques_one: false,
          AppLocalizations.of(context)!.prep_ques_two: false,
          AppLocalizations.of(context)!.prep_ques_three: false,
          AppLocalizations.of(context)!.prep_ques_four: false,
          AppLocalizations.of(context)!.prep_ques_five: false,
        };
      });
      _loadCheckBoxValues();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(AppLocalizations.of(context)!.app_title),
        ),
        backgroundColor: const Color.fromRGBO(255, 140, 0, 1.0),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: values.length,
              itemBuilder: (context, index) {
                String question = values.keys.elementAt(index);
                bool isChecked = values[question] ?? false;
                return CheckboxListTile(
                  title: Text(question),
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      values[question] = value ?? false;
                    });
                    _saveCheckBoxValues();
                  },
                );
              },
            ),
          ),
          ElevatedButton(onPressed: _resetboxes, child: const Text('Clear all checkboxes')),
        ],
      ),
    );
  }
}
