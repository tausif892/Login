import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:login/checklists.dart';
import 'package:login/controller/language_change_controller.dart';
import 'package:login/nutrition_page.dart';
import 'package:provider/provider.dart';
import 'package:login/login.dart';
import 'package:login/checklists.dart';

class NutritionPage extends StatefulWidget {
  @override
  _NutritionPageState createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  List<double> weights = [0, 0, 0, 0, 0];
  double bmi = 0.0;
  double albuminLevels = 0.0;
  DateTime? lastSmokingDate;
  DateTime? lastAlcoholDate;

  TextEditingController bmiController = TextEditingController();
  TextEditingController albuminController = TextEditingController();

  Future<void> _selectDate(BuildContext context, bool isSmoking) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isSmoking) {
          lastSmokingDate = picked;
        } else {
          lastAlcoholDate = picked;
        }
      });
    }
  }

  Widget _buildWeightRow(int week) {
    return Row(
      children: [
        Text('${AppLocalizations.of(context)!.week}  $week ${AppLocalizations.of(context)!.weight}'),
        SizedBox(width: 20),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                weights[week] = double.tryParse(value) ?? 0.0;
              });
            },
            decoration: InputDecoration(hintText: AppLocalizations.of(context)!.weight_hint),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.nutri_head),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.diet_chart),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Action to link to diet chart
                    },
                    child: Text(AppLocalizations.of(context)!.diet_but),
                  ),
                  SizedBox(height: 20),
                  Text(AppLocalizations.of(context)!.protein),
                  SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(hintText: AppLocalizations.of(context)!.prot_hint),
                  ),
                  SizedBox(height: 20),
                  Text(AppLocalizations.of(context)!.w_chart),
                  for (int i = 0; i < 5; i++) _buildWeightRow(i),
                  SizedBox(height: 20),
                  Text(AppLocalizations.of(context)!.bmi),
                  TextField(
                    controller: bmiController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: AppLocalizations.of(context)!.bmi_hint),
                    onChanged: (value) {
                      setState(() {
                        bmi = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Text(AppLocalizations.of(context)!.alb),
                  TextField(
                    controller: albuminController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: AppLocalizations.of(context)!.alb_hint),
                    onChanged: (value) {
                      setState(() {
                        albuminLevels = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  Text(AppLocalizations.of(context)!.hab),
                  SizedBox(height: 10),
                  Text(AppLocalizations.of(context)!.date),
                  Row(
                    children: [
                      Text(lastSmokingDate == null
                          ? AppLocalizations.of(context)!.date_but
                          : '${lastSmokingDate?.toLocal()}'.split(' ')[0]),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => _selectDate(context, true),
                        child: Text(AppLocalizations.of(context)!.date_but),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(AppLocalizations.of(context)!.alcohol),
                  Row(
                    children: [
                      Text(lastAlcoholDate == null
                          ? AppLocalizations.of(context)!.date
                          : '${lastAlcoholDate?.toLocal()}'.split(' ')[0]),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => _selectDate(context, false),
                        child: Text(AppLocalizations.of(context)!.date_but),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ),
    );
    }
}