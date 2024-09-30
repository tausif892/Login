import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:login/controller/language_change_controller.dart';
import 'package:login/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:login/checklists.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StomachCancer extends StatefulWidget {
  const StomachCancer({super.key});

  @override
  State<StomachCancer> createState() => _StomachCancerState();
}

class _StomachCancerState extends State<StomachCancer> {
  final List<int> filters = const [1, 2, 3, 4];
  late List<int> selectedFilters;

  @override
  void initState() {
    super.initState();
    selectedFilters = List.filled(21, filters[0]);
    _loadSelectedFilter();
  }

  _loadSelectedFilter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < selectedFilters.length; i++) {
      selectedFilters[i] = (prefs.getInt('selectedFilter$i') ?? filters[0]);
    }
    setState(() {});
  }

  _saveSelectedFilter(int index, int filter) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedFilter$index', filter);
  }

  void _onSelectFilter(int index, int filter) {
    setState(() {
      selectedFilters[index] = filter;
    });
    _saveSelectedFilter(index, filter);
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
      body: SingleChildScrollView(
        child: Column(
            children: List.generate(12, (questionIndex) {
              String questionText='';
              switch(questionIndex){
                case  0: questionText= AppLocalizations.of(context)!.sto_ques_one;
                break;
                case  1: questionText= AppLocalizations.of(context)!.sto_ques_two;
                break;
                case  2: questionText= AppLocalizations.of(context)!.sto_ques_three;
                break;
                case  3: questionText= AppLocalizations.of(context)!.sto_ques_four;
                break;
                case  4: questionText= AppLocalizations.of(context)!.sto_ques_five;
                break;
                case  5: questionText= AppLocalizations.of(context)!.sto_ques_six;
                break;
                case  6: questionText= AppLocalizations.of(context)!.sto_ques_seven;
                break;
                case  7: questionText= AppLocalizations.of(context)!.sto_ques_eight;
                break;
                case  8: questionText= AppLocalizations.of(context)!.sto_ques_nine;
                break;
                case  9: questionText= AppLocalizations.of(context)!.sto_ques_ten;
                break;
                case  10: questionText= AppLocalizations.of(context)!.sto_ques_eleven;
                break;
                case  11: questionText= AppLocalizations.of(context)!.sto_ques_twelve;
                break;
                case  12: questionText= AppLocalizations.of(context)!.sto_ques_thirteen;
                break;
                case  13: questionText= AppLocalizations.of(context)!.sto_ques_fourteen;
                break;
                case  14: questionText= AppLocalizations.of(context)!.sto_ques_fifteen;
                break;
                case  15: questionText= AppLocalizations.of(context)!.sto_ques_sixteen;
                break;
                case  16: questionText= AppLocalizations.of(context)!.sto_ques_seventeen;
                break;
                case  17: questionText= AppLocalizations.of(context)!.sto_ques_eighteen;
                break;
                case  18: questionText= AppLocalizations.of(context)!.sto_ques_nineteen;
                break;
                case  19: questionText= AppLocalizations.of(context)!.sto_ques_twenty;
                break;
                case  20: questionText= AppLocalizations.of(context)!.sto_ques_twentyone;
                break;
                case  21: questionText= AppLocalizations.of(context)!.sto_ques_twentytwo;
                break;
                default:
                  questionText='';
                  break;
              }

              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(questionText),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: filters.length,
                        itemBuilder: (context, index){
                          final filter=filters[index];
                          return buildChip(
                              context: context,
                              filter: filter,
                              select: selectedFilters[
                              questionIndex],
                              onSelect: (filter) => _onSelectFilter(questionIndex, filter));
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            )
        ),
      ),
    );
  }
}

Widget buildChip({
  required BuildContext context,
  required int filter,
  required int select,
  required Function(int) onSelect,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
    child: GestureDetector(
      onTap: () {
        onSelect(filter);
      },
      child: Chip(
        elevation: 15,
        backgroundColor: select == filter
            ? Theme.of(context).colorScheme.primary
            : const Color.fromRGBO(255, 255, 255, 0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        label: Text(filter.toString()),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    ),
  );
}
