import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:open_ai/crop_prediction.dart';
import 'package:open_ai/prediction.dart';
import 'package:open_ai/leaf_prediction.dart';

import '../model data/weather_data.dart';
import '../widgets/custom_textstyle.dart';
import '../widgets/extra_weather_widget.dart';
import '../widgets/weather_widget.dart';
import 'details_page.dart';
// import 'package:flutter_upwork_project/model%20data/weather_data.dart';
// import 'package:flutter_upwork_project/screens/details_page.dart';
// import 'package:flutter_upwork_project/widgets/custom_textstyle.dart';
// import 'package:flutter_upwork_project/widgets/extra_weather_widget.dart';
// import 'package:flutter_upwork_project/widgets/weather_widget.dart';

Weather? currentTemp;
Weather? tomorrowTemp;
List<Weather>? todayWeather;
List<Weather>? sevenDay;
String lat = "9.925";
String lon = "78.119774";
String city = "Madurai";

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getData() async {
    fetchData(lat, lon, city).then((value) {
      currentTemp = value[0];
      todayWeather = value[1];
      tomorrowTemp = value[2];
      sevenDay = value[3];
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
// final key = ScaffoldKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Icon(CupertinoIcons.person_alt_circle,
                            color: Colors.black, size: 80),
                        Text(
                          FirebaseAuth.instance.currentUser!.displayName
                              .toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          // style: textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Logout'),
                      // selected: _selectedDestination == 0,
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                      },
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.auto_graph),
                      title: const Text('Forcast'),
                      // selected: _selectedDestination == 0,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Prediction()),
                        );
                        // FirebaseAuth.instance.signOut();
                      },
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.auto_graph),
                      title: const Text('Crop Prediction'),
                      // selected: _selectedDestination == 0,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CropPred()),
                        );
                        // FirebaseAuth.instance.signOut();
                      },
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.batch_prediction),
                      title: const Text('Plant Disease Prediction'),
                      // selected: _selectedDestination == 0,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SkinPred()),
                        );
                        // FirebaseAuth.instance.signOut();
                      },
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                ]),
          ),
          backgroundColor: const Color(0xff030317),
          body: currentTemp == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      CurrentWeather(getData, _scaffoldKey),
                      TodayWeather()
                    ],
                  ),
                )),
    );
  }
}

class CurrentWeather extends StatefulWidget {
  final Function() updateData;
  GlobalKey<ScaffoldState> skey;

  CurrentWeather(this.updateData, this.skey);

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  bool searchbar = false;
  bool updating = false;
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (searchbar) {
          setState(() {
            searchbar = false;
          });
        }
      },
      child: GlowContainer(
        // height: MediaQuery.of(context).size.height / 10 * 7,
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
        // glowColor: Color(0xfffc1158).withOpacity(0.5),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
        // color: Color(0xfffc1158),
        color: const Color.fromARGB(255, 91, 176, 246),
        // Color(0xfffc1158),
        glowColor: const Color.fromARGB(255, 91, 176, 246).withOpacity(0.5),
        spreadRadius: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: searchbar
                  ? TextField(
                      style: custom_textStyle(16, Colors.white),
                      focusNode: focusNode,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintStyle: custom_textStyle(16, Colors.white),
                          fillColor: const Color(0xff030317),
                          filled: true,
                          hintText: "Enter a city Name"),
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) async {
                        CityModel? temp = await fetchCity(value);
                        if (temp == null) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: const Color(0xff030317),
                                  title: Text(
                                    "City not found",
                                    style: custom_textStyle(16, Colors.white),
                                  ),
                                  content: Text(
                                    "Please check the city name",
                                    style: custom_textStyle(16, Colors.white),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          "Ok",
                                          style: custom_textStyle(
                                              16, Colors.white),
                                        ))
                                  ],
                                );
                              });
                          searchbar = false;
                          return;
                        }
                        city = temp.name!;
                        lat = temp.lat!;
                        lon = temp.lon!;
                        updating = true;
                        setState(() {});
                        widget.updateData();
                        searchbar = false;
                        updating = false;
                        setState(() {});
                      },
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            widget.skey.currentState!.openDrawer();
                            // _scaffoldKey.currentState.openDrawer()
                          },
                          icon: const Icon(
                            CupertinoIcons.square_grid_2x2,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(CupertinoIcons.map_fill,
                                color: Colors.white),
                            GestureDetector(
                              onTap: () {
                                searchbar = true;
                                setState(() {});
                                focusNode.requestFocus();
                              },
                              child: Text(
                                " " + city,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                            ),
                          ],
                        ),
                        const Icon(Icons.search, color: Colors.white)
                      ],
                    ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(width: 0.2, color: Colors.white),
                  borderRadius: BorderRadius.circular(30)),
              child: Text(
                updating ? "Updating" : "Updated",
                style: custom_textStyle(14, Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Container(
                height: 240,
                child: Stack(
                  children: [
                    Image(
                      image: AssetImage(currentTemp!.image!),
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GlowText(
                              currentTemp!.current.toString(),
                              style: custom_textStyle(
                                  50, Colors.black, FontWeight.w900),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            GlowText(
                              currentTemp!.name!,
                              style: custom_textStyle(
                                  24, Colors.black, FontWeight.w700),
                            ),
                            GlowText(
                              currentTemp!.day!,
                              style: custom_textStyle(
                                  14, Colors.black, FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            ExtraWeather(currentTemp!)
          ],
        ),
      ),
    );
  }
}

class TodayWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 6),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today",
                style: custom_textStyle(25, Colors.white, FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return DetailPage(tomorrowTemp!, sevenDay!);
                  }));
                },
                child: Row(
                  children: [
                    const Text(
                      "7 days ",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.grey,
                      size: 15,
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 30,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: WeatherWidget(todayWeather![0]),
                  ),
                  Expanded(
                    flex: 1,
                    child: WeatherWidget(todayWeather![1]),
                  ),
                  Expanded(
                    flex: 1,
                    child: WeatherWidget(todayWeather![2]),
                  ),
                  Expanded(
                    flex: 1,
                    child: WeatherWidget(todayWeather![3]),
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
