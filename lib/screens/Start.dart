import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:xgridz/classes/BaseAppBar.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  var _horizontalVal = ['1', '2', '3', '4'];
  var _verticalVal = ['1', '2', '3', '4', '5', '6', '7', '8'];
  var _numberOfGrids = ['5', '10', '15', '20'];
  var _currentHorizontalSelected = '4';
  var _currentVerticalSelected = '4';
  var _currentGridsSelected = '5';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            iconSize: 50,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          title: Center(child: Text('Custom Grids', style: TextStyle(fontSize: 40))),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  Container(
                    child: Center(
                      child: Text(
                        'Enter Custom Grid Values',
                        style:
                            TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 180, top: 50, right: 0, bottom: 0),
                    child: Text(
                      'Horizontal Rows',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 180, top: 0, right: 0, bottom: 0),
                    child: DropdownButton<String>(
                      items: _horizontalVal.map((String dropDownStringItem){
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem, style: TextStyle(fontSize: 24)),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected) {
                        setState(() {
                          this._currentHorizontalSelected = newValueSelected;
                        });
                      },
                      value: _currentHorizontalSelected,
                      ),
                    ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 180, top: 50, right: 0, bottom: 0),
                    child: Text(
                      'Vertical Columns',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 180, top: 0, right: 0, bottom: 0),
                    child: DropdownButton<String>(
                      items: _verticalVal.map((String dropDownStringItem){
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem, style: TextStyle(fontSize: 24)),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected) {
                        setState(() {
                          this._currentVerticalSelected = newValueSelected;
                        });
                      },
                      value: _currentVerticalSelected,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 180, top: 50, right: 0, bottom: 0),
                    child: Text(
                      'Number of Grids',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 180, top: 0, right: 0, bottom: 0),
                    child: DropdownButton<String>(
                      items: _numberOfGrids.map((String dropDownStringItem){
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem, style: TextStyle(fontSize: 24)),
                        );
                      }).toList(),
                      onChanged: (String newValueSelected) {
                        setState(() {
                          this._currentGridsSelected = newValueSelected;
                        });
                      },
                      value: _currentGridsSelected,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 50.0,
                        width: 150,
                        child: EnterButton(_currentHorizontalSelected, _currentVerticalSelected, _currentGridsSelected),
                        margin: const EdgeInsets.only(
                            left: 300, top: 50, right: 10, bottom: 0),
                      ),
                      Container(
                        height: 50.0,
                        width: 340,
                        child: AddCustomImagesButton(),
                        margin: const EdgeInsets.only(
                            left: 150, top: 50, right: 10, bottom: 0),
                      ),
                    ],
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EnterButton extends StatelessWidget {
  int horizontalVal;
  int verticalVal;
  int gridVal;
  EnterButton(var horizontalVal, var verticalVal, var gridVal){
    this.horizontalVal = int.parse(horizontalVal);
    this.verticalVal = int.parse(verticalVal);
    this.gridVal = int.parse(gridVal);
  }

  @override
  Widget build(BuildContext context) {
    return (RaisedButton(
      textColor: Colors.white,
      color: Colors.blue,
      elevation: 5,
      onPressed: () {
        // Respond to button press
        horizontalValue = horizontalVal;
        verticalValue = verticalVal;
        gridValue = gridVal;
        Navigator.pushReplacementNamed(context, '/grids');
      },
      child: Text(
        "Start",
        style: TextStyle(fontSize: 30),
      ),
    ));
  }
}
class AddCustomImagesButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (RaisedButton(
      textColor: Colors.white,
      color: Colors.blue,
      elevation: 5,
      onPressed: () { // Respond to button press
        Navigator.pushReplacementNamed(context, '/custom');
      },
      child: Text(
        "Add Custom Images",
        style: TextStyle(fontSize: 30),
      ),
    ));
  }
}
