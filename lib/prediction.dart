import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                      style: TextStyle(fontWeight: FontWeight.bold),
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
                    leading: Text("Select Location"),
                    trailing: DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.deepPurple),
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
                    leading: Text("Select Wind Direction at 9am"),
                    trailing: DropdownButton<String>(
                      value: dropdownValue2,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.deepPurple),
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
                    leading: Text("Select Wind Direction at 3pm"),
                    trailing: DropdownButton<String>(
                      value: dropdownValue3,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.deepPurple),
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
                    leading: Text("Select Wind Gust Direction"),
                    trailing: DropdownButton<String>(
                      value: dropdownValue4,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.deepPurple),
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
                    leading: Text("Rain Today"),
                    trailing: DropdownButton<String>(
                      value: dropdownValue5,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.deepPurple),
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
                ElevatedButton(onPressed: () {}, child: const Text("Predict")),
                // ]
              ]),
        ),
      ),
    );
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
