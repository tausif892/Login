import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:login/lang_change.dart';

class LangChange extends StatefulWidget {
  const LangChange({super.key});

  @override
  State<LangChange> createState() => _LangChangeState();
}

class _LangChangeState extends State<LangChange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Kasturba Hospital',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(255, 140, 0, 1.0),
      ),
      body: Center(
        child:Text('Enter your preferred language',style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        )
      ),
    );
  }
}
