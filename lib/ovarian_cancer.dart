import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:login/controller/language_change_controller.dart';
import 'package:login/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:login/checklists.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OvarianCancer extends StatefulWidget {
  const OvarianCancer({super.key});

  @override
  State<OvarianCancer> createState() => _OvarianCancerState();
}

class _OvarianCancerState extends State<OvarianCancer> {
  final List<int> filters = const [1, 2, 3, 4];
  late List<int> selectedFilters;

  @override
  void initState() {
    super.initState();
    selectedFilters = List.filled(24, filters[0]);
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
                case  0: questionText= AppLocalizations.of(context)!.ov_ques_one;
                break;
                case  1: questionText= AppLocalizations.of(context)!.ov_ques_two;
                break;
                case  2: questionText= AppLocalizations.of(context)!.ov_ques_three;
                break;
                case  3: questionText= AppLocalizations.of(context)!.ov_ques_four;
                break;
                case  4: questionText= AppLocalizations.of(context)!.ov_ques_five;
                break;
                case  5: questionText= AppLocalizations.of(context)!.ov_ques_six;
                break;
                case  6: questionText= AppLocalizations.of(context)!.ov_ques_seven;
                break;
                case  7: questionText= AppLocalizations.of(context)!.ov_ques_eight;
                break;
                case  8: questionText= AppLocalizations.of(context)!.ov_ques_nine;
                break;
                case  9: questionText= AppLocalizations.of(context)!.ov_ques_ten;
                break;
                case  10: questionText= AppLocalizations.of(context)!.ov_ques_eleven;
                break;
                case  11: questionText= AppLocalizations.of(context)!.ov_ques_twelve;
                break;
                case  12: questionText= AppLocalizations.of(context)!.ov_ques_thirteen;
                break;
                case  13: questionText= AppLocalizations.of(context)!.ov_ques_fourteen;
                break;
                case  14: questionText= AppLocalizations.of(context)!.ov_ques_fifteen;
                break;
                case  15: questionText= AppLocalizations.of(context)!.ov_ques_sixteen;
                break;
                case  16: questionText= AppLocalizations.of(context)!.ov_ques_seventeen;
                break;
                case  17: questionText= AppLocalizations.of(context)!.ov_ques_eighteen;
                break;
                case  18: questionText= AppLocalizations.of(context)!.ov_ques_nineteen;
                break;
                case  19: questionText= AppLocalizations.of(context)!.ov_ques_twenty;
                break;
                case  20: questionText= AppLocalizations.of(context)!.ov_ques_twentyone;
                break;
                case  21: questionText= AppLocalizations.of(context)!.ov_ques_twentytwo;
                break;
                case  22: questionText= AppLocalizations.of(context)!.ov_ques_twentythree;
                break;
                case  23: questionText= AppLocalizations.of(context)!.ov_ques_twentyfour;
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
