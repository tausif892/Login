
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key});

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
        const SizedBox(width: 20),
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
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Action to link to diet chart
                    },
                    child: Text(AppLocalizations.of(context)!.diet_but),
                  ),
                  const SizedBox(height: 20),
                  Text(AppLocalizations.of(context)!.protein),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(hintText: AppLocalizations.of(context)!.prot_hint),
                  ),
                  const SizedBox(height: 20),
                  Text(AppLocalizations.of(context)!.w_chart),
                  for (int i = 0; i < 5; i++) _buildWeightRow(i),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
                  const Divider(),
                  Text(AppLocalizations.of(context)!.hab),
                  const SizedBox(height: 10),
                  Text(AppLocalizations.of(context)!.date),
                  Row(
                    children: [
                      Text(lastSmokingDate == null
                          ? AppLocalizations.of(context)!.date_but
                          : '${lastSmokingDate?.toLocal()}'.split(' ')[0]),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => _selectDate(context, true),
                        child: Text(AppLocalizations.of(context)!.date_but),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(AppLocalizations.of(context)!.alcohol),
                  Row(
                    children: [
                      Text(lastAlcoholDate == null
                          ? AppLocalizations.of(context)!.date
                          : '${lastAlcoholDate?.toLocal()}'.split(' ')[0]),
                      const SizedBox(width: 10),
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