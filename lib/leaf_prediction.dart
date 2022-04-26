import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/io_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_ai/api_result.dart';

class SkinPred extends StatefulWidget {
  const SkinPred({Key? key}) : super(key: key);

  @override
  State<SkinPred> createState() => _SkinPredState();
}

class _SkinPredState extends State<SkinPred> {
  String? pth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Disease Prediction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (pth != null) Card(child: Image.file(File(pth!))),
            ElevatedButton(
              onPressed: () async {
                final ImagePicker _picker = ImagePicker();
                // Pick an image
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (image == null) return;
                // pth = image.path;
                setState(() {
                  pth = image.path;
                });
                uploadFile(image.path, context).then((value) {
                  print(value);
                  Fluttertoast.showToast(
                      msg: "Uploaded Successfully",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  getLeaToken(value);
                });
                // final storageRef = FirebaseStorage.instance.ref();
              },
              child: const Text("Predict Disease"),
            ),
          ],
        ),
      ),
    );
  }

  String op = "";
  Future getLeaToken(String img) async {
    try {
      final ioc = new HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = new IOClient(ioc);
      http
          .post(
              Uri.parse(
                  'https://leafdiseaseprediction.herokuapp.com/cat/predict'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                'image': img,
              }))
          .then((response) {
        print("Reponse status : ${response.statusCode}");
        print("Response body : ${response.body}");
        var myresponse = jsonDecode(response.body);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Result"),
                content: Text(myresponse["output"]),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
        // });
        // setState(() {
        //   op = myresponse["result"];
        // });

        // String token = myresponse["token"];
      });
    } catch (e) {
      print(e.toString());
    }
  }
}

Future<String> uploadFile(String filePath, BuildContext context) async {
  print(filePath);
  if (filePath == 'null') {
    showTs('Error Occured,Upload a Pic');
    //return '';
    // btnController.stop();
    Navigator.pop(context);
    throw Error();
  } else {
    File file = File(filePath);
    String dt = DateTime.now().toString();
    print(dt);
    // DateTime dt = DateTime.now();
    String downloadURL;
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('prakatanlu/$dt.png')
          .putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print('Writing Error$e');
      // showToast('Error Occured,Upload a Pic', context);
      // e.g, e.code == 'canceled'
    }
    return await firebase_storage.FirebaseStorage.instance
        .ref('prakatanlu/$dt.png')
        .getDownloadURL();
  }
}

void showTs(mg) {
  Fluttertoast.showToast(
      msg: mg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
