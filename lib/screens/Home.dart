import 'package:flutter/material.dart';
import 'package:xgridz/classes/BaseAppBar.dart';
import 'package:xgridz/screens/Start.dart';

String currentUser = '';
List<String> users = new List<String>();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: new BaseAppBar().baseAppBar(context),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    currentUser == ''
                        ? "Current User: None"
                        : "Current User: " + currentUser,
                    style: TextStyle(
                      color: Colors.blue[400],
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      letterSpacing: 2.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Divider(
                  color: Colors.grey[800],
                  height: 30.0,
                ),
                Container(
                  height: 400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 130.0,
                          child: InkWell(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Icon(
                                    Icons.add_box_outlined,
                                    size: 60,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Add User',
                                    style: TextStyle(
                                      color: Colors.blue[400],
                                      fontSize: 24.0,
                                      letterSpacing: 1.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              addUser();
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: ListView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            padding: EdgeInsets.all(10),
                            children: //maps users from user list to userContainer Widgets
                                users.map((s) => userContainer(s)).toList()),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 130.0,
                          child: InkWell(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Icon(
                                    Icons.delete,
                                    size: 60,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Delete User',
                                    style: TextStyle(
                                      color: Colors.blue[400],
                                      fontSize: 24.0,
                                      letterSpacing: 1.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              deleteUser();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey[800],
                  height: 30.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.grid_view,
                        size: 60,
                        color: Colors.grey[400],
                      ),
                    ),
                    Center(
                      child: Text(
                        'XGridZ',
                        style: TextStyle(
                          color: Colors.amber[400],
                          fontSize: 30.0,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  //User Widget in the List
  Widget userContainer(String name) {
    return Container(
      height: 50,
      color: name == currentUser ? Colors.amber[200] : Colors.grey[200],
      child: InkWell(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            name,
            style: TextStyle(fontSize: 30),
          ),
        ),
        onTap: () {
          setState(() {
            currentUser = name;
          });
        },
      ),
    );
  }
  Future addUser() {
    final GlobalKey<FormState> _keyDialogForm = new GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Form(
              key: _keyDialogForm,
              child: Column(
                children: <Widget>[
                  Text(
                    "Add User",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.lightBlue,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Name",
                    ),
                    maxLength: 16,
                    textAlign: TextAlign.center,
                    onSaved: (val) {
                      users.add(val);
                      setState(() {});
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Title Name';
                      } else if (users.contains(value)) {
                        return 'User Already Exists';
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  if (_keyDialogForm.currentState.validate()) {
                    _keyDialogForm.currentState.save();

                    Navigator.pop(context);
                  }
                },
                child: Text('Save'),
                color: Colors.blue,
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
            ],
          );
        });
  }
  Future deleteUser() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Are You Sure You Want to Delete User: " + currentUser,
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  setState(() {
                    users.remove(currentUser);
                    currentUser = '';
                  });
                  Navigator.pop(context);
                },
                child: Text('Yes'),
                color: Colors.blue,
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
            ],
          );
        });
  }
}
