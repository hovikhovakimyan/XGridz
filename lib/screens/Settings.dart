import 'package:flutter/material.dart';
import 'package:xgridz/constants/SettingsValues.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: AppBar(
          backgroundColor: Colors.grey[600],
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              iconSize: 50,
              onPressed: () {
                Navigator.pop(context, '/home');
              }),
          title: Text('Settings', style: TextStyle(fontSize: 40)),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CheckboxListTile(
            title: const Text("Visual Identification"),
            value: SettingsValues.visualIdentification,
            onChanged: (bool value) {
              print(value);
              setState(() {
                SettingsValues.visualIdentification = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
