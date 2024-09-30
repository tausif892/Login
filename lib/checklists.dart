import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:login/controller/language_change_controller.dart';
import 'package:login/esophegal_cancer.dart';
import 'package:login/stomach_cancer.dart';
import 'package:provider/provider.dart';
import 'package:login/login.dart';
import 'package:login/lung_cancer.dart';
import 'package:login/ovarian_cancer.dart';


class Checklists extends StatefulWidget {
  const Checklists({super.key});

  @override
  State<Checklists> createState() => _ChecklistsState();
}

class _ChecklistsState extends State<Checklists> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title: Center(
          child: Text(AppLocalizations.of(context)!.app_title), // Use the correct localized string key
        ),
        backgroundColor: const Color.fromRGBO(255, 140, 0, 1.0),
      ),
      body:Center( child:  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(padding: const EdgeInsets.all(20)),
          Container(
            height: 50,
            child: Center(child: Text(AppLocalizations.of(context)!.cond,
                style:TextStyle(
                    fontSize: 40, fontWeight: FontWeight.bold
                ),
            ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(10),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text(AppLocalizations.of(context)!.lung, style: TextStyle(fontSize: 30),
              ),
          ),
              Padding(padding: const EdgeInsets.all(20),),
              ElevatedButton(onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>LungCancer())
                );
              }, child: Icon(Icons.arrow_circle_right_sharp))
          ],
          ),
          Padding(padding: const EdgeInsets.all(3),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Center(child: Text(AppLocalizations.of(context)!.stomach, style: TextStyle(fontSize: 30),
    ),
    ),
            Padding(padding: const EdgeInsets.all(20),),
    ElevatedButton(onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>StomachCancer())
      );
    },
        child: Icon(Icons.arrow_circle_right_sharp))
          ],
        ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text(AppLocalizations.of(context)!.ovary, style: TextStyle(fontSize: 30),
              ),
              ),
              Padding(padding: const EdgeInsets.all(20),),
              ElevatedButton(onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>OvarianCancer())
                );
              }, child: Icon(Icons.arrow_circle_right_sharp))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text(AppLocalizations.of(context)!.eso, style: TextStyle(fontSize: 30),
              ),
              ),
              Padding(padding: const EdgeInsets.all(20),),
              ElevatedButton(onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>EsophegalCancer())
                );
              }, child: Icon(Icons.arrow_circle_right_sharp))
            ],
          ),
        ],
      ),
      ),
    );
  }
}
