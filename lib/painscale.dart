import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PainScale extends StatefulWidget {
  const PainScale({super.key});

  @override
  State<PainScale> createState() => _PainScaleState();
}

class _PainScaleState extends State<PainScale> {
  int days = 0; // Initialize with a default value
  List<Map<String, int>> painLevelsList = [];
  List<Map<String, int>> activityLevelsList = [];

  // Pain values mapped to their corresponding colors
  final List<MapEntry<IconData, int>> painValues = [
    const MapEntry(Icons.sentiment_very_satisfied_outlined, 0),
    const MapEntry(Icons.sentiment_satisfied_alt_outlined, 2),
    const MapEntry(Icons.sentiment_neutral, 4),
    const MapEntry(Icons.sentiment_neutral_outlined, 6),
    const MapEntry(Icons.sentiment_dissatisfied_outlined, 8),
    const MapEntry(Icons.sentiment_very_dissatisfied_outlined, 10),
  ];

  // Colors ranging from green to red
  final List<Color> painColors = [
    Colors.green,
    Colors.lightGreen,
    Colors.yellow,
    Colors.orange,
    Colors.deepOrange,
    Colors.red,
  ];

  @override
  void initState() {
    super.initState();
    _loadDays();
  }

  // Function to load number of days from shared preferences
  void _loadDays() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      days = prefs.getInt('days') ?? 4; // Default to 4 if no value saved
      painLevelsList = List.generate(
        days,
            (index) => {
          AppLocalizations.of(context)!.morning: 0,
          AppLocalizations.of(context)!.afternoon: 0,
          AppLocalizations.of(context)!.evening: 0
        },
      );
      activityLevelsList = List.generate(
        days,
            (index) => {
          AppLocalizations.of(context)!.steps: 0,
          AppLocalizations.of(context)!.stairs: 0,
          AppLocalizations.of(context)!.running: 0
        },
      );
    });
    _loadPainLevels();
    _loadActivityLevels();
  }

  // Function to load pain levels from shared preferences
  void _loadPainLevels() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < days; i++) {
      setState(() {
        painLevelsList[i][AppLocalizations.of(context)!.morning] =
            prefs.getInt('day${i}_morning') ?? 0;
        painLevelsList[i][AppLocalizations.of(context)!.afternoon] =
            prefs.getInt('day${i}_afternoon') ?? 0;
        painLevelsList[i][AppLocalizations.of(context)!.evening] =
            prefs.getInt('day${i}_evening') ?? 0;
      });
    }
  }

  // Function to load activity levels from shared preferences
  void _loadActivityLevels() async {
    final prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < days; i++) {
      setState(() {
        activityLevelsList[i][AppLocalizations.of(context)!.steps] =
            prefs.getInt('day${i}_steps') ?? 0;
        activityLevelsList[i][AppLocalizations.of(context)!.stairs] =
            prefs.getInt('day${i}_stairs') ?? 0;
        activityLevelsList[i][AppLocalizations.of(context)!.running] =
            prefs.getInt('day${i}_running') ?? 0;
      });
    }
  }

  void _changeDay() async {
    setState(() {
      days += 1;
      painLevelsList.add({
        AppLocalizations.of(context)!.morning: 0,
        AppLocalizations.of(context)!.afternoon: 0,
        AppLocalizations.of(context)!.evening: 0
      });
      activityLevelsList.add({
        AppLocalizations.of(context)!.steps: 0,
        AppLocalizations.of(context)!.stairs: 0,
        AppLocalizations.of(context)!.running: 0
      });
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('days', days);
  }

  // Function to save pain levels to shared preferences
  void _savePainLevel(int dayIndex, String timeOfDay, int newPainLevel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('day${dayIndex}_${timeOfDay.toLowerCase()}', newPainLevel);
  }

  // Function to save activity levels to shared preferences
  void _saveActivityLevel(int dayIndex, String activityType, int newActivityLevel) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('day${dayIndex}_${activityType.toLowerCase()}', newActivityLevel);
  }

  // Function to handle icon tap and update the state
  void _updatePainLevel(int dayIndex, String timeOfDay, int newPainLevel) {
    setState(() {
      painLevelsList[dayIndex][timeOfDay] = newPainLevel;
      _savePainLevel(dayIndex, timeOfDay, newPainLevel);
    });
  }

  // Function to handle text field input and update the state
  void _updateActivityLevel(int dayIndex, String activityType, String newActivityLevel) {
    setState(() {
      int value = int.tryParse(newActivityLevel) ?? 0;
      activityLevelsList[dayIndex][activityType] = value;
      _saveActivityLevel(dayIndex, activityType, value);
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Pain and Exercise Register",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: days,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Day ${index + 1}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        _buildPainRow(index, AppLocalizations.of(context)!.morning),
                        _buildPainRow(index, AppLocalizations.of(context)!.afternoon),
                        _buildPainRow(index, AppLocalizations.of(context)!.evening),
                        const SizedBox(height: 20),
                        _buildActivityRow(index, AppLocalizations.of(context)!.steps),
                        _buildActivityRow(index, AppLocalizations.of(context)!.stairs),
                        _buildActivityRow(index, AppLocalizations.of(context)!.running),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(onPressed: _changeDay, child: const Text('Increase columns')),
          ],
        ),
      ),
    );
  }

  // Method to build a row for each time of the day
  Widget _buildPainRow(int dayIndex, String timeOfDay) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              timeOfDay,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: painValues.map((entry) {
                  int painLevel = entry.value;
                  Color iconColor = painColors[painValues.indexOf(entry)];
                  return IconButton(
                    icon: Icon(
                      entry.key,
                      color: painLevelsList[dayIndex][timeOfDay] == painLevel ? iconColor : Colors.grey,
                    ),
                    onPressed: () {
                      _updatePainLevel(dayIndex, timeOfDay, painLevel);
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method to build a row for each activity type
  Widget _buildActivityRow(int dayIndex, String activityType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              activityType,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            flex: 2,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: activityLevelsList[dayIndex][activityType]?.toString() ?? '0',
              ),
              onChanged: (newValue) {
                _updateActivityLevel(dayIndex, activityType, newValue);
              },
            ),
          ),
        ],
      ),
    );
  }
}
