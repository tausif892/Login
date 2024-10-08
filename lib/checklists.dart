import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:login/esophegal_cancer.dart';
import 'package:login/stomach_cancer.dart';
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
          const Padding(padding: EdgeInsets.all(20)),
          SizedBox(
            height: 50,
            child: Center(child: Text(AppLocalizations.of(context)!.cond,
                style:const TextStyle(
                    fontSize: 40, fontWeight: FontWeight.bold
                ),
            ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(10),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text(AppLocalizations.of(context)!.lung, style: const TextStyle(fontSize: 30),
              ),
          ),
              const Padding(padding: EdgeInsets.all(20),),
              ElevatedButton(onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>const LungCancer())
                );
              }, child: const Icon(Icons.arrow_circle_right_sharp))
          ],
          ),
          const Padding(padding: EdgeInsets.all(3),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Center(child: Text(AppLocalizations.of(context)!.stomach, style: const TextStyle(fontSize: 30),
    ),
    ),
            const Padding(padding: EdgeInsets.all(20),),
    ElevatedButton(onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>const StomachCancer())
      );
    },
        child: const Icon(Icons.arrow_circle_right_sharp))
          ],
        ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text(AppLocalizations.of(context)!.ovary, style: const TextStyle(fontSize: 30),
              ),
              ),
              const Padding(padding: EdgeInsets.all(20),),
              ElevatedButton(onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>const OvarianCancer())
                );
              }, child: const Icon(Icons.arrow_circle_right_sharp))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text(AppLocalizations.of(context)!.eso, style: const TextStyle(fontSize: 30),
              ),
              ),
              const Padding(padding: EdgeInsets.all(20),),
              ElevatedButton(onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>const EsophegalCancer())
                );
              }, child: const Icon(Icons.arrow_circle_right_sharp))
            ],
          ),
        ],
      ),
      ),
    );
  }
}
