import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PainScale extends StatefulWidget {
  final String patientId;
  PainScale({super.key, required this.patientId});

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

  // Function to submit the collected data to the API
  void _submitData() async {
    final url = 'https://flask-q63d.onrender.com/pain_scale/patient_id=${widget.patientId}';
    final request = http.MultipartRequest('POST', Uri.parse(url));

    for (int i = 0; i < days; i++) {
      final day = i + 1;
      // Submitting data for each time period
      request.fields['time_period'] = 'morning';
      request.fields['pain_rating'] = painLevelsList[i][AppLocalizations.of(context)!.morning].toString();
      request.fields['day'] = day.toString();
      request.fields['patient_id'] = widget.patientId;

      request.fields['time_period'] = 'afternoon';
      request.fields['pain_rating'] = painLevelsList[i][AppLocalizations.of(context)!.afternoon].toString();
      request.fields['day'] = day.toString();
      request.fields['patient_id'] = widget.patientId;

      request.fields['time_period'] = 'evening';
      request.fields['pain_rating'] = painLevelsList[i][AppLocalizations.of(context)!.evening].toString();
      request.fields['day'] = day.toString();
      request.fields['patient_id'] = widget.patientId;

      // Submitting activity levels
      request.fields['activity_type'] = 'steps';
      request.fields['activity_level'] = activityLevelsList[i][AppLocalizations.of(context)!.steps].toString();
      request.fields['day'] = day.toString();
      request.fields['patient_id'] = widget.patientId;

      request.fields['activity_type'] = 'stairs';
      request.fields['activity_level'] = activityLevelsList[i][AppLocalizations.of(context)!.stairs].toString();
      request.fields['day'] = day.toString();
      request.fields['patient_id'] = widget.patientId;

      request.fields['activity_type'] = 'running';
      request.fields['activity_level'] = activityLevelsList[i][AppLocalizations.of(context)!.running].toString();
      request.fields['day'] = day.toString();
      request.fields['patient_id'] = widget.patientId;
    }

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        // Handle success response
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data submitted successfully!")));
      } else {
        // Handle error response
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to submit data. Please try again.")));
      }
    } catch (e) {
      // Handle network error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Network error: $e")));
    }
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
                        Container(
                          width: double.infinity-17,
                        child: Column(
                          children: [const SizedBox(height: 8),
                        _buildPainRow(index, AppLocalizations.of(context)!.morning),
                        _buildPainRow(index, AppLocalizations.of(context)!.afternoon),
                        _buildPainRow(index, AppLocalizations.of(context)!.evening),
                        const SizedBox(height: 20),
                        _buildActivityRow(index, AppLocalizations.of(context)!.steps),
                        _buildActivityRow(index, AppLocalizations.of(context)!.stairs),
                        _buildActivityRow(index, AppLocalizations.of(context)!.running),
                        ],
                        ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _changeDay,
              child: const Text("Add Day"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text("Submit Data"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPainRow(int dayIndex, String timeOfDay) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(timeOfDay, style: const TextStyle(fontSize: 16)),
        Row(
          children: painValues.map((entry) {
            final icon = entry.key;
            final value = entry.value;
            final color = painColors[value ~/ 2]; // Divide by 2 to get the correct color index
            return IconButton(
              icon: Icon(icon, color: color),
              onPressed: () => _updatePainLevel(dayIndex, timeOfDay, value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActivityRow(int dayIndex, String activityType) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(activityType, style: const TextStyle(fontSize: 16)),
        SizedBox(
          width: 60,
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: (newValue) => _updateActivityLevel(dayIndex, activityType, newValue),
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "0",
            ),
          ),
        ),
      ],
    );
  }
}
