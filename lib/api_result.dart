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
        .post(Uri.parse(''),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'image': '',
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
