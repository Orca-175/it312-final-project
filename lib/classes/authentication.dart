import 'package:http/http.dart';
import 'package:it312_final_project/constants/constants.dart';

class Authentication {
  static Future<int> login(String username, String password) async {
    Response response = await post(Uri.parse('$requestUrl/login_user.php'), body: {'username': username, 'password': password});
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return int.parse(response.body);
  }

  static Future<String> register(String username, String password) async {
    Response response = await post(Uri.parse('$requestUrl/register_user.php'), body: {'username': username, 'password': password});
    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    return response.body.toString();
  }
}