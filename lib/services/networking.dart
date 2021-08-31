import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;

  Future getData() async {
    var newUrl = Uri.parse(url);
    http.Response response = await http.post(newUrl);
    // print(response.body);

    if (response.statusCode == 200) {
      String data = response.body;
      // var decodeData = jsonDecode(data);
      // var longitude = decodeData['coord']['lon'];
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
