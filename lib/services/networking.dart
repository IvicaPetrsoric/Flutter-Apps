import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future getData() async {
    Response response = await get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);

      // print(response.body);

      // var longitude = jsonDecode(data)['coord']['lon'];
      // print(longitude);
      //
      // var weatherDescription = jsonDecode(data)['weather'][0]['description'];
      // print(weatherDescription);

      // var jsonData = jsonDecode(data);
      //
      // double temperature = jsonData['main']['temp'];
      // int condition = jsonData['weather'][0]['id'];
      // String cityName = jsonData['name'];
      //
      // print(temperature);
      // print(condition);
      // print(cityName);
    } else {
      print(response.statusCode);
    }
  }
}
