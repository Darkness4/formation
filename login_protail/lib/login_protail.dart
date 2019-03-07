import 'dart:io';

import 'package:http/io_client.dart';

Future<String> autoLogin(
    String uid, String pswd, String selectedUrl, int selectedTime) async {
  var status = "";

  HttpClient client = HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);
  IOClient ioClient = IOClient(client);

  try {
    var sessionId =
        await ioClient.post("https://$selectedUrl/auth/plain.html", body: {
      'uid': uid,
      'time': '$selectedTime',
      'pswd': pswd,
    }).then((response) {
      if (response.statusCode == 200) {
        if (response.body.contains('title_error'))
          throw ("Error: Bad Username or Password");
        else
          return response.body;
      } else
        throw Exception("HttpError: ${response.statusCode}");
    }).then((body) => RegExp(r'"(id=([^"]*))').firstMatch(body).group(1));

    status = await ioClient
        .post("https://$selectedUrl/auth/disclaimer.html", body: {
          'session': sessionId,
          'read': 'accepted',
          'action': "J'accepte",
        })
        .then((response) => RegExp(r'<span id="l_rtime">([^<]*)<\/span>')
            .firstMatch(response.body)
            .group(1))
        .then((match) => '$match seconds left');
  } catch (e) {
    print(e);
  }

  return status;
}
