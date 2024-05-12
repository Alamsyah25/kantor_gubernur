import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:kantor_gubernur/constants/strings.dart';
import 'package:kantor_gubernur/model/kantor_gubernur_response.dart';

class ApiProvider {
  // Await the http get response, then decode the json-formatted response.
  Future<List<KantorGubenurResponse>> fetchData() async {
    var url = Uri.parse(
        "https://requestly.dev/api/mockv2/data.json?username=user1698894060609&");

    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final List body = json.decode(response.body);
      return body.map((e) => KantorGubenurResponse.fromJson(e)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future<List<Location>> getLocation({required String address}) async {
    List<Location> locations = [];
    locations = await locationFromAddress("$address, $country");
    return locations;
  }
}
