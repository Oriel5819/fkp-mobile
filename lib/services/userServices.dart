import 'package:fkpmobile/api/api.dart';
import 'package:http/http.dart' as http;

class EmployeeServices {
  ApiURL api = ApiURL();

  Future<http.Response> fetchAll(String token) async {
    http.Response response = await http.get(
      Uri.parse(api.HEROKU_URI + 'users'),
      headers: <String, String>{
        "Authorization": "Bearer $token",
        "Content-type": "application/json",
        "Accept": "application/json",
        "charset": "utf-8"
      },
    );
    return response;
  }
}
