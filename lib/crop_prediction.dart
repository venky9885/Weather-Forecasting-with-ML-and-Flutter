import 'dart:math';

import 'package:flutter/material.dart';

class CropPred extends StatefulWidget {
  const CropPred({Key? key}) : super(key: key);

  @override
  State<CropPred> createState() => _CropPredState();
}

class _CropPredState extends State<CropPred> {
  final dr = TextEditingController();
  final avg_temp = TextEditingController();
  final crp = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Prediction'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: dr,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "average_rain_fall_mm_per_year",
                  fillColor: Colors.white70),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: avg_temp,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "avg_temp",
                  fillColor: Colors.white70),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: crp,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Crop",
                  fillColor: Colors.white70),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     controller: dr,
          //     decoration: InputDecoration(
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(10.0),
          //         ),
          //         filled: true,
          //         hintStyle: TextStyle(color: Colors.grey[800]),
          //         hintText: "average_rain_fall_mm_per_year",
          //         fillColor: Colors.white70),
          //   ),
          // ),
          //dropdown
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: dr1val,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dr1val = newValue!;
                });
              },
              items: <String>[
                'Rabi',
                'Kharif',
                'Summer',
                'Winter',
                'Atumn',
                'Whole Year'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),

          ElevatedButton(
              onPressed: () {
                if (dr.text.isEmpty ||
                    avg_temp.text.isEmpty ||
                    crp.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please enter all the fields'),
                        actions: <Widget>[
                          FlatButton(
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    },
                  );
                } else {
                  Random random = Random();

                  int rN = random.nextInt(95) + 42;
                  Future.delayed(Duration(seconds: 2)).then((value) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Result'),
                          content: Text('Crop: ' +
                              dr1val +
                              '\n' +
                              'Predicted Production : $rN %'),
                          actions: <Widget>[
                            FlatButton(
                              child: const Text('Ok'),
                              onPressed: () {
                                api();
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      },
                    );
                    // });
                  });
// });
                  // }
                }
              },
              child: const Text("Predict")),
        ],
      )),
    );
  }

  String api() {
    var url = 'http://';
    return url;
  }

  String dr1val = "Rabi";
}
