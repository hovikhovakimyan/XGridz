import 'package:flutter/material.dart';

/* Dart file I created to store the AppBar that might be reused on several different pages, this page contains all the
necessary code for the icons and where they go. The base app bar is used for the home screen and the returning one I used
for the Start screen so far. Not sure how useful this will be yet*/
//Global Variable for Grids, maybe we can find a cleaner way of doing this later
int horizontalValue = 4;
int verticalValue = 4;
int gridValue = 5;
int counter = 0;
int scoreCount = 0;
class IndividualResults{
  final String pickedCard;
  final bool pick;
  final String correctChoice;
  IndividualResults(
  {
    @required this.pickedCard,
    @required this.pick,
    @required this.correctChoice,
  });
}
var detailedResults = [];
class ImageSelector {
  final String imagePick;
  final String name;
  final String type;
  final int value;

  const ImageSelector({
    @required this.imagePick,
    @required this.name,
    @required this.type,
    @required this.value,
  });
}
class BaseAppBar {
  PreferredSize baseAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(75),
      child: AppBar(
        flexibleSpace: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            appBarIcon(Icons.help_outline_outlined, "Help", context),
            //appBarIcon(Icons.search, "Data", context),
            Text('XGridZ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 55,
                )),
           // appBarIcon(Icons.settings, "Settings", context),
            appBarIcon(Icons.arrow_forward_rounded, "Start", context),
          ],
        ),
      ),
    );
  }
//this function is currently not in use
/*  PreferredSize returningAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(75),
      child: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            iconSize: 41,
            onPressed: () {
              Navigator.pop(context);
            }),
        flexibleSpace: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            appBarIcon(Icons.help_outline_outlined, "Help", context),
            appBarIcon(Icons.search, "Data", context),
            appBarIcon(Icons.settings, "Settings", context),
            appBarIcon(Icons.arrow_forward_rounded, "Start Test", context),
          ],
        ),
      ),
    );
  }
*/
//Global horizontal and vertical values for grids

  Widget appBarIcon(IconData givenIcon, String iconName, BuildContext context) {
    return Container(
      height: 100.0,
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Icon(
                givenIcon,
                size: 40,
                color: Colors.white,
              ),
            ),
            Center(
              child: Text(
                iconName,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        onTap: () {
          onTap(iconName, context);
        },
      ),
    );
  }

  void onTap(String iconName, BuildContext context) {
    switch (iconName) {
      case "Help":
        {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    'Welcome to XGridZ:',
                    style: TextStyle(fontSize: 50, color: Colors.blue),
                  ),
                  content: Text(
                    'XGridZ is an AAC evaluation tool, you can begin an evaluation by selecting a user profile, then tapping the "Start" icon on the top right.You can also '
                    'configure the test by tapping the "Settings" icon on the top bar.',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    TextButton(
                      child: Text(
                        'Ok',
                        style: TextStyle(fontSize: 30),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              });
          break;
        }
      case "Data":
        {
          break;
        }
      case "Settings":
        {
          Navigator.pushNamed(context, '/settings');
          break;
        }
      case "Start":
        {
          Navigator.pushReplacementNamed(context, '/start');
          break;
        }
    }
  }
}

