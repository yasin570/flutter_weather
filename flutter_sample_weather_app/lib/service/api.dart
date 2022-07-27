import 'package:http/http.dart' as http;

String name = "ankara";

class Api {
  static Future get(String name) async {
    return await http.get(
        Uri.parse(
            "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=$name"),
        headers: {
          "authorization": 'apikey "write your api key"',
          "content": 'application/json'
        });
  }
}
