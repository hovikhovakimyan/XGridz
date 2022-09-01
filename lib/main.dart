import 'package:flutter/material.dart';
import 'package:xgridz/screens/Home.dart';
import 'package:xgridz/screens/Loading.dart';
import 'package:xgridz/screens/Settings.dart';
import 'package:xgridz/screens/Start.dart';
import 'package:xgridz/screens/Grids.dart';
import 'package:xgridz/screens/Results.dart';
import 'package:xgridz/classes/BaseAppBar.dart';
import 'package:xgridz/screens/CustomImages.dart';
void main() => runApp(xGridZ());
 
class xGridZ extends StatelessWidget {
  @override
  build(BuildContext context) {
    return MaterialApp(
      title: "xGridZ",
      routes: {
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/settings': (context) => Settings(),
      '/start': (context) => Start(),
      '/grids': (context) => Grids(),
      '/results':(context) => Results(scoreCount),
      '/custom': (context) => CustomImages(),

  },
    );
  }
}

