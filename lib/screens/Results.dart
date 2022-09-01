import 'package:flutter/material.dart';
import 'package:xgridz/classes/BaseAppBar.dart';

class Results extends StatefulWidget {
  int scoreCount;
  Results(ScoreCount){
    this.scoreCount = ScoreCount;
  }
  @override
  _ResultsState createState() => _ResultsState();
}
class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    int listCount = 0;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: AppBar(
            centerTitle: true,
            leading: IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                iconSize: 50,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                  scoreCount = 0;
                  detailedResults.clear();
                }),
            title: Text('Results', style: TextStyle(fontSize: 40)),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children:[
              Container(
                padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text
                      ("Final Result: $scoreCount / $gridValue", style: TextStyle
                      (fontSize: 50,
                        fontWeight: FontWeight.bold
                    )
                    ),
                  )
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(20),
                  child: Text
                  ("Detailed Results:", style: TextStyle
                  (fontSize: 32,
                  fontWeight: FontWeight.bold
                  )
                  ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(20),
                child: ListView.separated(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => Divider(color: Colors.transparent),
                  itemBuilder: (context, index){
                    listCount++;
                    if (detailedResults[index].pick == false) {
                      return Padding(
                          padding: EdgeInsets.all(3),
                          child: Container(
                            alignment: Alignment.centerLeft,
                              height: 50,
                              child: Text(
                                "$listCount. " + detailedResults[index].pickedCard + " (Answer was: " + detailedResults[index].correctChoice + ")", style: TextStyle(fontSize: 28, color: Colors.red, fontWeight: FontWeight.bold),
                              )
                          )
                      );
                    }
                    return Padding(
                        padding: EdgeInsets.all(3),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            height: 50,
                            child: Text(
                                "$listCount. " + detailedResults[index].correctChoice, style: TextStyle(fontSize: 28, color: Colors.green, fontWeight: FontWeight.bold)
                            )
                        )
                    );
                },
                  itemCount: detailedResults.length,
                )
                ),
            ]
          ),
        )
    );
  }
}