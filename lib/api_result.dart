import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'dart:io';

// import 'package:http/http.dart';
import 'dart:async';
// import 'dart:convert';

Future getAccessToken() async {
  try {
    final ioc = HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    final http = IOClient(ioc);
    http
        .post(Uri.parse('https://rainpredictionhackathon.herokuapp.com/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'list': [
                'Albury',
                13.4,
                22.9,
                0.6,
                'W',
                44.0,
                'W',
                'WNW',
                20.0,
                24.0,
                71.0,
                22.0,
                1007.7,
                1007.1,
                8.0,
                0,
                16.9,
                21.8,
                'No'
              ]
              /*'': 'Albury',
              '': 13.4,
              '': 22.9,
              '': 0.6,
              '': 'W',
              '': 44.0,
              '': 'W',
              '': 'WNW',
              '': 20.0,
              '': 24.0,
              '': 71.0,
              '': 22.0,
              '': 1007.7,
              '': 1007.1,
              '': 8.0,
              '': 0,
              '': 16.9,
              '': 21.8,
              '': 'No'*/
            }))
        .then((response) {
      print("Reponse status : ${response.statusCode}");
      print("Response body : ${response.body}");
      var myresponse = jsonDecode(response.body);
      String token = myresponse["token"];
    });
  } catch (e) {
    print(e.toString());
  }
}

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
      String token = myresponse["token"];
    });
  } catch (e) {
    print(e.toString());
  }
}
