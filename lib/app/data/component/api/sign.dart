import 'package:ti_learning/app/data/model/login_model.dart';

import 'env.dart';
import 'index.dart';

class SignAPI {
  static const _baseUrl = Env.urlSign;
  static const _postLogin = '$_baseUrl/login';
  static final url = Env();

  Future<LoginModel> login({
    required String email,
    required String pass,
  }) async {
    Map<String, dynamic> data = {
      "email": email,
      "password": pass,
    };
    final response = await API.httpNetwork(url: _postLogin, data: data);
    final obj = LoginModel.fromJson(response);
    return obj;
  }
}
