import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:xgridz/classes/BaseAppBar.dart';
import 'package:xgridz/classes/data.dart';

class CustomImages extends StatefulWidget {
  @override
  _CustomImagesState createState() => _CustomImagesState();
}

class _CustomImagesState extends State<CustomImages> {
  final nameValue = TextEditingController();
  final typeValue = TextEditingController();

  String filePath;
  File pickedImage;

  int customImageCount;

  int displayErrors;


  final _picker = ImagePicker();
  PickedFile imageFile;


  _openGallery(BuildContext context) async {
    PickedFile imageFile = await _picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      pickedImage = File(imageFile.path);
    });
  }


  Future <void> galleryOpener(BuildContext context) {
    return _openGallery(context);
  }

  Widget defaultImage() {
    if (pickedImage == null) {
      return Container(margin: const EdgeInsets.only(
          left: 180, top: 10, right: 0, bottom: 0),
          child: Text("Image Not Selected!", style: TextStyle(fontSize: 30)));
    }
    else {
      return Center(child: Image.file(pickedImage, width: 200, height: 200));
    }
  }
  Widget confirmDialog(){
    if(displayErrors == 1) {
      return Container(
        margin: const EdgeInsets.only(
            left: 180, top: 10, right: 0, bottom: 0),
        child: Text(
          ("File successfully uploaded, number of custom images is now $customImageCount"),
          style: TextStyle(
              fontSize: 28, color: Colors.green, fontWeight: FontWeight.bold),
        ),
      );
    }
    else
      return SizedBox(

      );
  }
  Widget errorDialog() {
    if (displayErrors == 2) {
      return Container(
        margin: const EdgeInsets.only(
            left: 180, top: 10, right: 0, bottom: 0),
        child: Text(
          ("Error! \nImage list already contains an image with that name!"), style: TextStyle(
            fontSize: 28, color: Colors.red, fontWeight: FontWeight.bold),
        ),
      );
    }
    else
      return SizedBox(
        height: 0, width: 0,
      );
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_outlined, color: Colors.white),
              iconSize: 50,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/start');
              },
            ),
            title: Center(child: Text(
                'Custom Image Adder', style: TextStyle(fontSize: 40))),
          ),
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0),
                  children: <Widget>[
                    Container(
                      child: Center(
                        child: Text(
                          'Select an Image',
                          style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 180, top: 10, right: 0, bottom: 0),
                          child: Text(
                            'Image:',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                        ),
                        defaultImage(),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 180, top: 10, right: 0, bottom: 0),
                          height: 50,
                          width: 180,
                          child: (RaisedButton(
                            textColor: Colors.white,
                            color: Colors.blue,
                            elevation: 5,
                            onPressed: () {
                              galleryOpener(context);
                            },
                            child: Text(
                              "Add Image",
                              style: TextStyle(fontSize: 26),
                            ),
                          )),
                        ),
                        Container(
                          child: (IconButton(
                            color: Colors.grey,
                            iconSize: 60,
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                pickedImage = null;
                              });
                            },
                          )),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 180, top: 30, right: 0, bottom: 0),
                          child: Text(
                            'Name:',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(
                                left: 10, top: 30, right: 0, bottom: 0),
                            width: 550,
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              controller: nameValue,
                              decoration: const InputDecoration(
                                labelText: 'Name',
                                border: OutlineInputBorder(),
                              ),
                            )
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 180, top: 30, right: 0, bottom: 0),
                          child: Text(
                            'Type:',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(
                                left: 20, top: 30, right: 0, bottom: 0),
                            width: 550,
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              controller: typeValue,
                              decoration: const InputDecoration(
                                labelText: 'Type',
                                border: OutlineInputBorder(),
                              ),
                            )
                        ),
                      ],
                    ),
                    errorDialog(),
                    confirmDialog(),
                    Row(
                      children: [
                        Container(
                          height: 50.0, width: 150,
                          margin: const EdgeInsets.only(
                              left: 500, top: 50, right: 360, bottom: 0),
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.blue,
                            elevation: 5,
                            onPressed: () {
                              for (int i = 0; i < imageList.length; i++) {
                                if (imageList[i].name == nameValue.text) {
                                  setState(() {
                                    displayErrors = 2;
                                    pickedImage = null;
                                    typeValue.clear();
                                    nameValue.clear();
                                  });
                                }
                              }
                              if (nameValue.text != ""  && typeValue.text != "" && pickedImage != null) {
                                filePath = pickedImage.toString().substring(7);
                                filePath = filePath.substring(0, filePath.length - 1);
                                var newImage = new ImageSelector(name: nameValue.text, type: typeValue.text, value: imageList.length + 1, imagePick: filePath);
                                imageList.add(newImage);
                                customImageCount = imageList.length - 32;
                                setState(() {
                                  displayErrors = 1;
                                  pickedImage = null;
                                  typeValue.clear();
                                  nameValue.clear();
                                });
                              }
                            },
                            child: Text(
                              "Upload",
                              style: TextStyle(fontSize: 30),
                            ),
                          ),

                        ),
                      ],
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
}


