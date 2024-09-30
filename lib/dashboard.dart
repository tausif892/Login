// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:login/checklists.dart';
// import 'package:login/controller/language_change_controller.dart';
// import 'package:login/nutrition_page.dart';
// import 'package:provider/provider.dart';
// import 'package:login/login.dart';
// import 'package:login/checklists.dart';
//
// class Dashboard extends StatefulWidget {
//   final String user_id;
//   const Dashboard({super.key, required this.user_id});
//
//   @override
//   State<Dashboard> createState() => _DashboardState();
// }
//
// class _DashboardState extends State<Dashboard> {
//   late List<String> items;
//   late String selectedItem;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize selectedItem with the first item
//   }
//
//   @override
//   void didChangeDependencies(){
//     super.didChangeDependencies();
//     items = [
//       AppLocalizations.of(context)!.pain_sc,
//       AppLocalizations.of(context)!.about,
//       AppLocalizations.of(context)!.nutrition
//     ];
//     selectedItem=items[0];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text(AppLocalizations.of(context)!.app_title),
//         ),
//         backgroundColor: const Color.fromRGBO(255, 140, 0, 1.0),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const Padding(padding: EdgeInsets.all(10)),
//           SizedBox(
//             width: double.infinity,
//             child: Card(
//               elevation: 20,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       Text(AppLocalizations.of(context)!.p_name, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//                       ),
//                       const Padding(padding: EdgeInsets.all(15)),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               child:  Text(
//                                 AppLocalizations.of(context)!.p_gend,
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(
//                               child:  Text(
//                                 AppLocalizations.of(context)!.p_cond,
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Padding(padding: EdgeInsets.all(5)),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               child:  Text(
//                                 AppLocalizations.of(context)!.p_doc,
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(
//                               child:  Text(
//                                 AppLocalizations.of(context)!.p_age,
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const Padding(padding: EdgeInsets.all(20)),
//           SizedBox(
//             height: 60,
//             child: ListView.builder(
//               itemCount: items.length,
//               scrollDirection: Axis.horizontal,
//               itemBuilder: (context, index) {
//                 final item = items[index];
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedItem = item;
//                       });
//                       if (item == AppLocalizations.of(context)!.pain_sc) {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(builder: (context) {
//                             return const Checklists();
//                           }),
//                         );
//                       } else if (item == AppLocalizations.of(context)!.nutrition) {
//                         Navigator.of(context).push(
//                           MaterialPageRoute(builder: (context) {
//                             return  NutritionPage();
//                           }),
//                         );
//                       }
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[300],
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Center(
//                         child: Text(item),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:login/checklists.dart';
import 'package:login/controller/language_change_controller.dart';
import 'package:login/nutrition_page.dart';
import 'package:provider/provider.dart';
import 'package:login/login.dart';
import 'package:login/checklists.dart';

class Dashboard extends StatefulWidget {
  final String user_id;
  const Dashboard({super.key, required this.user_id});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late List<String> items;
  late String selectedItem;

  @override
  void initState() {
    super.initState();
    // Initialize selectedItem with the first item
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    items = [
      AppLocalizations.of(context)!.pain_sc,
      AppLocalizations.of(context)!.about,
      AppLocalizations.of(context)!.nutrition
    ];
    selectedItem=items[0];
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(padding: EdgeInsets.all(10)),
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
                      Text(AppLocalizations.of(context)!.p_name, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      const Padding(padding: EdgeInsets.all(15)),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child:  Text(
                                AppLocalizations.of(context)!.p_gend,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child:  Text(
                                AppLocalizations.of(context)!.p_cond,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.all(5)),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child:  Text(
                                AppLocalizations.of(context)!.p_doc,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child:  Text(
                                AppLocalizations.of(context)!.p_age,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(20)),
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
                      if (item == AppLocalizations.of(context)!.pain_sc) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return const Checklists();
                          }),
                        );
                      } else if (item == AppLocalizations.of(context)!.nutrition) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return  NutritionPage();
                          }),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(item),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}