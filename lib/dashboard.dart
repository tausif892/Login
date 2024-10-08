import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:login/checklists.dart';
import 'package:login/nutrition_page.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:login/painscale.dart';
import 'package:login/preparation.dart';
import 'package:http/http.dart' as http;

class Patient {
  final String address;
  final String contactNumber;
  final String currentMedication;
  final String dateOfAdmission;
  final String dateOfBirth;
  final String dateOfDischarge;
  final String diagnosis;
  final int doctorId;
  final String email;
  final String followUpDate;
  final String gender;
  final String insuranceProvider;
  final String medicalHistory;
  final String password;
  final int patientId;
  final String patientName;
  final String surgeryDetails;
  final String testResults;
  final String treatment;

  Patient({
    required this.address,
    required this.contactNumber,
    required this.currentMedication,
    required this.dateOfAdmission,
    required this.dateOfBirth,
    required this.dateOfDischarge,
    required this.diagnosis,
    required this.doctorId,
    required this.email,
    required this.followUpDate,
    required this.gender,
    required this.insuranceProvider,
    required this.medicalHistory,
    required this.password,
    required this.patientId,
    required this.patientName,
    required this.surgeryDetails,
    required this.testResults,
    required this.treatment,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      address: json['address'],
      contactNumber: json['contact_number'],
      currentMedication: json['current_medication'],
      dateOfAdmission: json['date_of_admission'],
      dateOfBirth: json['date_of_birth'],
      dateOfDischarge: json['date_of_discharge'],
      diagnosis: json['diagnosis'],
      doctorId: json['doctor_id'],
      email: json['email'],
      followUpDate: json['follow_up_date'],
      gender: json['gender'],
      insuranceProvider: json['insurance_provider'],
      medicalHistory: json['medical_history'],
      password: json['password'],
      patientId: json['patient_id'],
      patientName: json['patient_name'],
      surgeryDetails: json['surgery_details'],
      testResults: json['test_results'],
      treatment: json['treatment'],
    );
  }
}

class Dashboard extends StatefulWidget {
  final String user_id;
  const Dashboard({super.key, required this.user_id});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List<IconData> items;
  late IconData selectedItem;
  Patient? patient; // Variable to hold patient data

  final List<String> videoURLs = [
    'https://youtu.be/cj1ZBaXOl9w?si=kM5u5a1bkHM5rpLL',
    'https://youtu.be/74T6AlgaPxg',
    'https://youtu.be/Z0VRcvZUdQk',
    'https://youtu.be/qmgCV1U9PwU',
    'https://youtu.be/mVE3bhbFSD0',
    'https://youtu.be/i46twOnehSc',
    'https://youtu.be/zgSVxVKxx1o'
  ];

  @override
  void initState() {
    super.initState();
    fetchPatientData(); // Fetch patient data on init
  }

  Future<void> fetchPatientData() async {
    final response = await http.get(Uri.parse('https://flask-q63d.onrender.com/erms?patient_id=${widget.user_id}'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        setState(() {
          patient = Patient.fromJson(data[0]); // Assuming you want the first patient
        });
      }
    } else {
      throw Exception('Failed to load patient data');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    items = [
      Icons.auto_graph_sharp,
      Icons.info,
      Icons.restaurant,
      Icons.check_box_outlined,
      Icons.sentiment_neutral_sharp
    ];
    selectedItem = items[0];
  }

  @override
  Widget build(BuildContext context) {
    double scrWidth = MediaQuery.of(context).size.width;
    double scrHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(AppLocalizations.of(context)!.app_title),
        ),
        backgroundColor: const Color.fromRGBO(255, 140, 0, 1.0),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.all(10)),
          // Check if patient data is loaded
          if (patient != null) ...[
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(patient!.patientName, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                        const Padding(padding: EdgeInsets.all(15)),
                        Row(
                          children: [
                            Expanded(child: Text(patient!.gender, style: const TextStyle(fontSize: 16))),
                            Expanded(child: Text(patient!.diagnosis, style: const TextStyle(fontSize: 16))),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.all(5)),
                        Row(
                          children: [
                            Expanded(child: Text(patient!.email, style: const TextStyle(fontSize: 16))),
                            Expanded(child: Text(patient!.dateOfBirth, style: const TextStyle(fontSize: 16))),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(20)),
          ],
          SizedBox(
            height: 60,
            child: ListView.builder(
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final item = items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedItem = item;
                      });
                      if (item == Icons.auto_graph_sharp) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Checklists()));
                      } else if (item == Icons.restaurant) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NutritionPage()));
                      } else if (item == Icons.check_box_outlined) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PreparationList()));
                      } else if (item == Icons.sentiment_neutral_sharp) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  PainScale(patientId: widget.user_id)));
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
                      child: Center(child: Icon(item)),
                    ),
                  ),
                );
              },
            ),
          ),
           SizedBox(
            width: double.infinity,
            height: 50,
            child: Text(
              AppLocalizations.of(context)!.physiotherapy,
              textAlign: TextAlign.left,
              style: const TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(padding: EdgeInsets.all(15)),
          SizedBox(
            height: 250, // Set a fixed height for the video player list
            child: ListView.builder(
              itemCount: videoURLs.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                     Text("${index+1}"),
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: VideoPlayerScreen(videoURL: videoURLs[index]),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoURL;

  const VideoPlayerScreen({super.key, required this.videoURL});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Extract video ID from URL
    String? videoId = YoutubePlayer.convertUrlToId(widget.videoURL);

    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '', // Ensure videoId is not null
      flags: const YoutubePlayerFlags(autoPlay: true),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when not in use
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(controller: _controller);
  }
}
