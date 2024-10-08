// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:login/dashboard.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// class Login extends StatefulWidget {
//   const Login({super.key});
//
//   @override
//   State<Login> createState() => _LoginState();
// }
//
// class _LoginState extends State<Login> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   String message = "";
//
//   Future<void> _login() async {
//     String contact_number = _usernameController.text;
//     String password = _passwordController.text;
//
//     final response = await http.post(
//       Uri.parse('https://flask-q63d.onrender.com/login'),
//       body: {'contact_number': contact_number, 'password': password},
//     );
//
//     if (response.statusCode == 200) {
//       setState(() {
//         message = json.decode(response.body)['message'];
//         String userId = json.decode(response.body)['patient_id'];
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => Dashboard(user_id: userId)),
//         );
//       });
//     } else {
//       setState(() {
//         message = json.decode(response.body)['message'];
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text(
//             AppLocalizations.of(context)!.app_title, // Use localization
//             style: const TextStyle(
//               fontSize: 30,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         backgroundColor: const Color.fromRGBO(255, 140, 0, 1.0),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 controller: _usernameController,
//                 decoration: InputDecoration(
//                   hintText: AppLocalizations.of(context)!.enter_login_id, // Use localization
//                   labelText: AppLocalizations.of(context)!.login_id, // Use localization
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 onFieldSubmitted: (_) => _login(), // Trigger login on submit
//               ),
//               SizedBox(height: 16),
//               TextFormField(
//                 controller: _passwordController,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   hintText: AppLocalizations.of(context)!.enter_password, // Use localization
//                   labelText: AppLocalizations.of(context)!.password, // Use localization
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 onFieldSubmitted: (_) => _login(), // Trigger login on submit
//               ),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: _login,
//                 child: Text('Login'), // Use localization
//               ),
//               SizedBox(height: 16),
//               Text(
//                 message,
//                 style: TextStyle(fontSize: 20, color: Colors.red),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:login/dashboard.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String message = "";

  Future<void> _login() async {
    String contactNumber = _usernameController.text;
    String password = _passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('https://flask-q63d.onrender.com/login'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'contact_number': contactNumber,
          'password': password,
        },
      );

      print('Request: ${response.request}');
      print('Response body: ${response.body}');
      print('Status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        setState(() {
          message = responseBody['message'];
        });
        if (responseBody.containsKey('patient_id')) {
          String userId = responseBody['patient_id'].toString();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Dashboard(user_id: userId)),
          );
        }
      } else {
        setState(() {
          message = 'Error: ${response.statusCode} - ${json.decode(response.body)['message']}';
        });
      }
    } catch (e) {
      setState(() {
        message = 'An error occurred: $e';
      });
    }
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.enter_login_id,
                  labelText: AppLocalizations.of(context)!.login_id,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onFieldSubmitted: (_) => _login(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.enter_password,
                  labelText: AppLocalizations.of(context)!.password,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onFieldSubmitted: (_) => _login(),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _login,
                child: Text(AppLocalizations.of(context)!.login_id),
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: const TextStyle(fontSize: 20, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
