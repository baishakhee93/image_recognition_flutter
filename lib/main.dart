import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'details.dart';

main() async {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _text = '';
     File? _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Image Recognition'),
          backgroundColor: Colors.purple,
          actions: [
            ElevatedButton(

              onPressed: scanText,

              child: Text(
                'Scan',
                style: TextStyle(color: Colors.white),

              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
              )
            )

          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: getImage,
          child: Icon(Icons.add_a_photo,color: Colors.white,),
          backgroundColor: Colors.purple,


        ),
        backgroundColor: Colors.white,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: _image != null
              ? Image.file(
                  File(_image!.path),
                  fit: BoxFit.fitWidth,
                )
              : Container(
            child: Text( 'Please capture the Image through camera',style: TextStyle(color: Colors.green,),textAlign: TextAlign.center,),
          ),
        ));
  }

  Future scanText() async {
    // showDialog(
    //     context: context,
    //     child: Center(
    //       child: CircularProgressIndicator(),
    //     ));
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(File(_image!.path));
    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();
    final VisionText visionText =
        await textRecognizer.processImage(visionImage);

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        _text += (line.text);
      }
    }

    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Details(_text)));
  }
  @override
  void initState() {
    super.initState();
  }


  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        File image = File(pickedFile.path);
        final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(image);
        final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
        setState(() {
          _image = image;
        });
      } else {
        print('No image selected');
      }
    });
  }
}
