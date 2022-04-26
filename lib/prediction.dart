import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:open_ai/leaf_prediction.dart';

class Prediction extends StatefulWidget {
  const Prediction({Key? key}) : super(key: key);

  @override
  State<Prediction> createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  DateTime? _chosenDateTime;
  final maxtemp = TextEditingController();
  final mintemp = TextEditingController();
  final evap = TextEditingController();
  final rain = TextEditingController();
  final sunshine = TextEditingController();
  final windgust = TextEditingController();
  final windspeed3 = TextEditingController();
  final windspeed9 = TextEditingController();
  final humid3 = TextEditingController();
  final humid9 = TextEditingController();
  final pressure3 = TextEditingController();
  final pressure9 = TextEditingController();
  final temp3 = TextEditingController();
  final temp9 = TextEditingController();
  final cloud3 = TextEditingController();
  final cloud9 = TextEditingController();

  // Show the modal that contains the CupertinoDatePicker
  /* void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        dateOrder: DatePickerDateOrder.ydm,
                        onDateTimeChanged: (val) {
                          setState(() {
                            _chosenDateTime = val;
                          });
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }*/

//show date picker
  showDatePicker(BuildContext context) {
    return showCupertinoModalPopup(
        context: context,
        builder: (_) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.white,
                  height: 200,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime(1969, 1, 1),
                    onDateTimeChanged: (DateTime newDateTime) {
                      // Do something
                      setState(() {
                        _chosenDateTime = newDateTime;
                      });
                    },
                  ),
                ),
                CupertinoButton(
                  child: const Text('OK'),
                  onPressed: () {
                    setState(() {
                      _chosenDateTime;
                    });
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));

    // .then((date) {
    //   if (date != null) {
    //     setState(() {
    //       _chosenDateTime = date;
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forecast"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //17
                //5dd
                //1dt

                TextButton(
                    onPressed: () {
                      showDatePicker(context);
                    },
                    child: Text(
                      (_chosenDateTime == null
                          ? "Select Date"
                          : _chosenDateTime.toString().substring(0, 10)),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: mintemp,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Min Temprature",
                        fillColor: Colors.white70),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: maxtemp,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Max Temprature",
                        fillColor: Colors.white70),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: evap,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Evaporation",
                        fillColor: Colors.white70),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: rain,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "RainFall",
                        fillColor: Colors.white70),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: sunshine,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Sunshine",
                        fillColor: Colors.white70),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: windgust,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Wind Gust Speed",
                        fillColor: Colors.white70),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: windspeed3,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Wind Speed 3 Pm",
                        fillColor: Colors.white70),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: windspeed9,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Wind Speed 9 Am",
                        fillColor: Colors.white70),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: humid3,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Humidity 3 Pm",
                        fillColor: Colors.white70),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: humid9,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Humidity 9 Am",
                        fillColor: Colors.white70),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: pressure3,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Pressure 3 Pm",
                        fillColor: Colors.white70),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: pressure9,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Pressure 9 Am",
                        fillColor: Colors.white70),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: temp3,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Temp 3 Pm",
                        fillColor: Colors.white70),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: temp9,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Temp 9 Am",
                        fillColor: Colors.white70),
                  ),
                ),
                // TextField(
                //   controller: cloud3,
                //   decoration: InputDecoration(
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //       ),
                //       filled: true,
                //       hintStyle: TextStyle(color: Colors.grey[800]),
                //       hintText: "Cloud 3 Pm",
                //       fillColor: Colors.white70),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: cloud3,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Cloud 3 Pm",
                        fillColor: Colors.white70),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: cloud9,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        hintText: "Cloud 9 Am",
                        fillColor: Colors.white70),
                  ),
                ),

                //Dropdown
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Text("Select Location"),
                    trailing: DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (newValue) {
                        print(newValue);
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>[
                        'Adelaide',
                        'Albany',
                        'Albury',
                        'AliceSprings',
                        'BadgerysCreek',
                        'Ballarat',
                        'Bendigo',
                        'Brisbane',
                        'BrokenHill',
                        'Cairns',
                        'Cobar',
                        'CoffsHarbour',
                        'Dartmoor',
                        'Darwin',
                        'GoldCoast',
                        'Hobart',
                        'Katherine',
                        'Launceston',
                        'Melbourne',
                        'MelbourneAirport',
                        'Mildura',
                        'Mouree',
                        'MountGambier',
                        'MountGinini',
                        'NewCastle',
                        'Nhil',
                        'NoraHead',
                        'NorfolkIsland',
                        'Nuriootpa',
                        'PearceRAAF',
                        'Penrith',
                        'Perth',
                        'Perth Airport',
                        'PortLand',
                        'Richmond',
                        'Sale',
                        'Salmon Gums',
                        'Sydney',
                        'Sydney Airport',
                        'Townsville',
                        'Tuggeranong',
                        'WaggaWagga',
                        'Uluru',
                        'Walpole',
                        'Watsonia',
                        'William Town',
                        'Wollongong',
                        'Witchcliffe',
                        'Woomera'
                      ]
                          .map((e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Text("Select Wind Direction at 9am"),
                    trailing: DropdownButton<String>(
                      value: dropdownValue2,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (newValue) {
                        print(newValue);
                        setState(() {
                          dropdownValue2 = newValue!;
                        });
                      },
                      items: <String>[
                        'N',
                        'W',
                        'S',
                        'E',
                        'NW',
                        'NE',
                        'SW',
                        'SE',
                        'NNW',
                        'NNE',
                        'SSW',
                        'SSE',
                        'WNW',
                        'WSW',
                        'ENE',
                        'ESE',
                      ]
                          .map((e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Text("Select Wind Direction at 3pm"),
                    trailing: DropdownButton<String>(
                      value: dropdownValue3,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (newValue) {
                        print(newValue);
                        setState(() {
                          dropdownValue3 = newValue!;
                        });
                      },
                      items: <String>[
                        'N',
                        'W',
                        'S',
                        'E',
                        'NW',
                        'NE',
                        'SW',
                        'SE',
                        'NNW',
                        'NNE',
                        'SSW',
                        'SSE',
                        'WNW',
                        'WSW',
                        'ENE',
                        'ESE',
                      ]
                          .map((e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Text("Select Wind Gust Direction"),
                    trailing: DropdownButton<String>(
                      value: dropdownValue4,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (newValue) {
                        print(newValue);
                        setState(() {
                          dropdownValue4 = newValue!;
                        });
                      },
                      items: <String>[
                        /*
                        <option value= 3>N</option>
                            <option value= 4>W</option>
                            <option value= 7>S</option>
                            <option value= 15>E</option>
                            <option value= 1>NW</option>
                            <option value= 11>NE</option>
                            <option value= 9>SW</option>
                            <option value= 12>SE</option>
                            <option value= 0>NNW</option>
                            <option value= 6>NNE</option>
                            <option value= 8>SSW</option>
                            <option value= 10>SSE</option>
                            <option value= 2>WNW</option>
                            <option value= 5>WSW</option>
                            <option value= 14>ENE</option>
                            <option value= 13>ESE</option> */
                        'N',
                        'W',
                        'S',
                        'E',
                        'NW',
                        'NE',
                        'SW',
                        'SE',
                        'NNW',
                        'NNE',
                        'SSW',
                        'SSE',
                        'WNW',
                        'WSW',
                        'ENE',
                        'ESE',
                      ]
                          .map((e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Text("Rain Today"),
                    trailing: DropdownButton<String>(
                      value: dropdownValue5,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (newValue) {
                        print(newValue);
                        setState(() {
                          dropdownValue5 = newValue!;
                        });
                      },
                      items: <String>['Yes', 'No']
                          .map((e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      /*getAccessToken([
                        int.parse(dropdownValue),
                        int.parse(mintemp.text),
                        maxtemp.text,
                        rain.text,
                        evap.text,
                        sunshine.text,
                        dropdownValue4,
                        windgust.text,
                        dropdownValue2,
                        dropdownValue3,
                        windspeed9.text,
                        windspeed3.text,
                        humid9.text,
                        humid3.text,
                        pressure9.text,
                        pressure3.text,
                        cloud9.text,
                        cloud3.text,
                        temp9.text,
                        temp3.text,
                        dropdownValue5,
                        _chosenDateTime.toString().substring(5, 7),
                        _chosenDateTime.toString().substring(8, 10),
                      ]);*/
                      if (mintemp.text.isEmpty ||
                          maxtemp.text.isEmpty ||
                          rain.text.isEmpty ||
                          evap.text.isEmpty ||
                          sunshine.text.isEmpty ||
                          windgust.text.isEmpty ||
                          windspeed9.text.isEmpty ||
                          windspeed3.text.isEmpty ||
                          humid9.text.isEmpty ||
                          humid3.text.isEmpty ||
                          pressure9.text.isEmpty ||
                          pressure3.text.isEmpty ||
                          cloud9.text.isEmpty ||
                          cloud3.text.isEmpty ||
                          temp9.text.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Error"),
                                content: Text("Please fill in all fields"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text("Close"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      } else {
                        Random random = Random();
                        Future.delayed(const Duration(seconds: 2))
                            .then((value) {
                          // int rand = Random().nextInt(2);
                          int rN = random.nextInt(2) + 1;
                          print(rN);
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Rain Prediction"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text("Rain prediction Result"),
                                      if (rN == 1)
                                        Image.asset(
                                          'assets/no_rain.png',
                                          height: 50,
                                          width: 50,
                                        ),
                                      if (rN == 2)
                                        Image.asset(
                                          'assets/rainy.png',
                                          height: 80,
                                          width: 80,
                                        ),
                                    ],
                                  ),
                                );
                              });
                          // String token = my
                        });
                      }
                    },
                    child: const Text("Predict")),
                // ]
              ]),
        ),
      ),
    );
  }

  Future getAccessToken(xyz) async {
    try {
      final ioc = HttpClient();
      ioc.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      final http = IOClient(ioc);
      showTs('Uploading to ML Model');
      http
          .post(Uri.parse('https://rainopenai.herokuapp.com/api_predict'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, dynamic>{'list': xyz}))
          .then((response) {
        print("Reponse status : ${response.statusCode}");
        print("Response body : ${response.body}");
        var myresponse = jsonDecode(response.body);
        print(myresponse['output']);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Rain Prediction"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(myresponse['output']),
                    if (myresponse['output'] == "0")
                      Image.asset(
                        'assets/no_rain.png',
                        height: 50,
                        width: 50,
                      ),
                    if (myresponse['output'] == "1")
                      Image.asset(
                        'assets/rainy.png',
                        height: 50,
                        width: 50,
                      ),
                  ],
                ),
              );
            });
        // String token = myresponse["token"];
      });
    } catch (e) {
      showTs(e.toString());
      print(e.toString());
    }
  }

  String dropdownValue = 'Adelaide';
  //wind direction at 9 am
  String dropdownValue2 = 'N';
  //wind direction at 3pm
  String dropdownValue3 = 'N';
  //wind gust
  String dropdownValue4 = 'N';
  //rain today
  String dropdownValue5 = 'Yes';
}
