import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:xgridz/classes/BaseAppBar.dart';
import 'dart:math';
import 'package:xgridz/classes/data.dart';
import 'dart:io';

String correctName;
int correctVal = 0;
int numOfCards = 0;
void waitOnPressed(BuildContext context) {
  if (counter < gridValue){
    correctVal = 0;
    Timer(Duration(milliseconds: 30),
            ()=> Navigator.pushReplacementNamed(context, '/grids'));
  }
  else{
    counter = 0;
    correctVal = 0;
    Timer(Duration(milliseconds: 30),
            ()=> Navigator.pushReplacementNamed(context, '/results'));
  }

}

class Grids extends StatefulWidget {
  @override
  _GridsState createState() => _GridsState();
}

class _GridsState extends State<Grids> {
  Future getFutureHeader;
  int imageSize = imageList.length;
  Set<int> intSet = new HashSet<int>();
  String imageName;
  File imageFile;
  String header = '';
  bool slotPicked = false;
  int countTrack = -1;
  int winner = -1;
  @override
  void initState() {
    super.initState();
    getFutureHeader = _getHeader(header);
  }

_getHeader(header) async {
    return header;
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(75),
            child: AppBar(
                backgroundColor: Colors.grey[600],
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  iconSize: 50,
                  onPressed: () {
                    counter = 0;
                    correctVal = 0;
                    scoreCount = 0;
                    Navigator.pushReplacementNamed(context, '/start');
                  },
                ),
                title: Text('Custom Grids', style: TextStyle(fontSize: 40)))),
               body: SingleChildScrollView(
                 child: Container(
                   padding: EdgeInsets.all(5),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,

                     children: [
                       Container(
                         margin: EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 50),
                         child: Center(
                           child: FutureBuilder(
                             future: getFutureHeader,
                             builder: (context, snapshot){
                               if (snapshot.hasData){
                                 return Text("Find the $header", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold));
                               }
                               else
                                 return Text("Waiting...", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold));

                             }
                           ),
                         ),
                       ),
                       GridView.count(
                         shrinkWrap: true,
                         physics: ScrollPhysics(),
                         // Create a grid with 2 columns. If you change the scrollDirection to
                         // horizontal, this produces 2 rows.
                         padding: EdgeInsets.all(16.0),
                         crossAxisCount: verticalValue,// setting this to horizontal value properly fits correct amount of items in grid rows
                         mainAxisSpacing: 20.0,
                         crossAxisSpacing: 20.0,
                         children: List.generate(horizontalValue * verticalValue , (index) {
                           numOfCards = verticalValue * horizontalValue;
                           Random random = new Random();
                           index = random.nextInt(imageSize);
                           while(intSet.contains(index)) {
                             index = random.nextInt(imageSize);
                           }
                           countTrack++;
                           intSet.add(index);
                           imageName = imageList[index].imagePick;
                           Random random3 = new Random();
                           if (!slotPicked) {
                             winner = random3.nextInt(numOfCards);
                             slotPicked = true;
                           }
                           if (countTrack == winner){
                             header = imageList[index].name;
                             _getHeader(header);
                             return Card(                         // This card is Correct!
                                 shadowColor: Colors.blue,
                                 elevation: 3.0,
                                 margin: EdgeInsets.all(10),
                                 child: Container(
                                     child: new Ink.image(
                                       image: AssetImage(imageName),
                                       fit: BoxFit.scaleDown,
                                       child: InkWell(
                                         splashColor: Colors.green,
                                         splashFactory: InkRipple.splashFactory,
                                         onTap: () {
                                           var scoreObj = new IndividualResults(pickedCard: imageList[index].name, pick: true, correctChoice: header);
                                           detailedResults.add(scoreObj);
                                           scoreCount++;
                                           intSet.clear();
                                           counter++;
                                           waitOnPressed(context);
                                         },
                                         onLongPress: () {
                                           var scoreObj = new IndividualResults(pickedCard: imageList[index].name, pick: true, correctChoice: header);
                                           detailedResults.add(scoreObj);
                                           intSet.clear();
                                           counter++;
                                           waitOnPressed(context);
                                         },
                                       ),
                                     )
                                 )
                             );
                           }
                           return Card(     // These cards are wrong!
                             shadowColor: Colors.blue,
                             elevation: 3.0,
                             margin: EdgeInsets.all(10),
                             child: Container(
                               child: new Ink.image(
                                 image: AssetImage(imageName),
                                 fit: BoxFit.scaleDown,
                                     child: InkWell(
                                       splashColor: Colors.red,
                                       splashFactory: InkRipple.splashFactory,
                                       onLongPress: () {
                                         var scoreObj = new IndividualResults(pickedCard: imageList[index].name, pick: false, correctChoice: header);
                                         detailedResults.add(scoreObj);
                                         intSet.clear();
                                         counter++;
                                         waitOnPressed(context);
                                       },
                                       onTap: (){
                                       var scoreObj = new IndividualResults(pickedCard: imageList[index].name, pick: false, correctChoice: header);
                                       detailedResults.add(scoreObj);
                                       intSet.clear();
                                       counter++;
                                       waitOnPressed(context);
                           },
                                 ),
                             )
                           )
                           );
                         },
                         ),
                       ),
                     ],
                   ),
                 ),
               )),
    );
      }
    }


