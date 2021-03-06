import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:weed_classification/details_screen.dart';

class Tensorflow extends StatefulWidget {
  @override
  _TensorflowState createState() => _TensorflowState();
}

class _TensorflowState extends State<Tensorflow> {
  List _outputs;
  File imageFile;
  String plant;
  PickedFile _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
    );
  }

  classifyImage(PickedFile image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true);
    setState(() {
      _loading = false;
      _outputs = output;
      plant = output.toString();
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  pickImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    //or gallery,whatever you'd like
    if (image == null) return null;

    setState(() {
      _loading = true;
      _image = image;
    });
    //using "file" object instead of "picked file"
    imageFile = File(image.path);
    classifyImage(image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Let's Identify your Weed",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _loading
                ? Container(
                    height: 300,
                    width: 300,
                  )
                : Container(
                    margin: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _image == null ? Container() : Image.file(imageFile),
                        SizedBox(
                          height: 20,
                        ),
                        _image == null
                            ? Container()
                            : _outputs != null
                                ? Text(
                                    _outputs[0]["label"],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  )
                                : Container(child: Text("")),
                      ],
                    ),
                  ),
            SizedBox(
              height: 90,
            ),
            FloatingActionButton(
              tooltip: 'Pick Image',
              onPressed: () {
                pickImage();
                // To navigate to details page
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => DetailsScreen(
                //       plant: plant,
                //     ),
                //   ),
                // );

                // Extra Tip:
                // You can also use "enums" instead of using strings from the type of plant.
              },
              child: Icon(
                Icons.add_a_photo,
                size: 20,
                color: Colors.white,
              ),
              backgroundColor: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }
}
